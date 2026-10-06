#!/usr/bin/env bash
# End-to-end test of sign-up, choices and the weekly email: local listmonk, with Mailpit standing in for SES
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(cd "$HERE/../../.." && pwd)
WEBSITE=${WEBSITE:-$ROOT/blr-today-website} SCHEDULER=${SCHEDULER:-$ROOT/scheduler}
IMAGE=${IMAGE:-docker.io/listmonk/listmonk:v6.2.0} LM=http://127.0.0.1:19000 MP=http://127.0.0.1:18025
WORK=$(mktemp -d) && export OUT=$WORK
cleanup() { [ -n "${KEEP:-}" ] || podman pod rm -f lm-e2e > /dev/null 2>&1; rm -rf "$WORK"; }
trap cleanup EXIT
fails=0
check() { if eval "$2"; then echo "ok   $1"; else echo "FAIL $1"; fails=$((fails + 1)); fi; }

podman pod rm -f lm-e2e > /dev/null 2>&1 || true
podman pod create --name lm-e2e -p 127.0.0.1:19000:9000 -p 127.0.0.1:18025:8025 > /dev/null
podman run -d --pod lm-e2e -e POSTGRES_USER=lm -e POSTGRES_PASSWORD=lm -e POSTGRES_DB=lm docker.io/library/postgres:17-alpine > /dev/null
podman run -d --pod lm-e2e docker.io/axllent/mailpit:latest > /dev/null
ENVS=(-e LISTMONK_app__address=0.0.0.0:9000 -e LISTMONK_db__host=127.0.0.1 -e LISTMONK_db__user=lm -e LISTMONK_db__password=lm
  -e LISTMONK_db__database=lm -e LISTMONK_db__ssl_mode=disable -e LISTMONK_ADMIN_USER=admin -e LISTMONK_ADMIN_PASSWORD=e2e-password)
for _ in $(seq 30); do podman run --rm --pod lm-e2e "${ENVS[@]}" "$IMAGE" ./listmonk --install --idempotent --yes > /dev/null 2>&1 && break || sleep 1; done
podman run -d --pod lm-e2e "${ENVS[@]}" "$IMAGE" > /dev/null
for _ in $(seq 30); do curl -sf "$LM/admin/login" > /dev/null && break || sleep 1; done

eval "$(LISTMONK_URL=$LM LISTMONK_ADMIN_USER=admin LISTMONK_ADMIN_PASSWORD=e2e-password ROOT_URL=$LM \
  SMTP_HOST=127.0.0.1 SMTP_PORT=1025 SMTP_TLS=none "$HERE/configure.sh")"
sleep 5 && for _ in $(seq 30); do curl -sf "$LM/admin/login" > /dev/null && break || sleep 1; done

fn() {
  LISTMONK_URL=$LM LISTMONK_API_USER=web LISTMONK_API_TOKEN=$(cat "$WORK/token-web") LISTMONK_LIST_ID=$LISTMONK_LIST_ID \
  LISTMONK_LINK_TEMPLATE_ID=$LISTMONK_LINK_TEMPLATE_ID node --input-type=module -e '
    globalThis.Netlify = { env: { get: (k) => k === "URL" ? "https://blr.today" : process.env[k] } };
    const { default: fn } = await import(process.argv[1] + "/netlify/functions/digest.mjs");
    const [method, action, body] = process.argv.slice(2);
    const q = method === "GET" ? "?token=" + encodeURIComponent(body) : "";
    const res = await fn(new Request("https://blr.today/api/digest/" + action + q, method === "GET" ? {} : { method, body }));
    console.log(res.status, await res.text());' "$WEBSITE" "$@"
}
inbox() { sleep 2; curl -s "$MP/api/v1/search?query=to:$1" | jq -r '[.messages[].Subject] | join("|")'; }
html() { curl -s "$MP/api/v1/message/$(curl -s "$MP/api/v1/search?query=to:$1" | jq -r '.messages[0].ID')" | jq -r .HTML; }
empty_inbox() { curl -s -X DELETE "$MP/api/v1/messages" > /dev/null; }

check "sign-up is accepted" '[[ $(fn POST subscribe "{\"email\":\"Ann@Example.com\",\"always\":[\"free\"],\"never\":[\"pricey\"]}") == 200* ]]'
check "sign-up sends one confirmation" '[[ $(inbox ann@example.com) == "Confirm subscription" ]]'
optin=$(html ann@example.com | grep -o 'href="[^"]*/subscription/optin/[^"]*"' | head -1 | sed 's/href="//;s/"$//;s/&amp;/\&/g')
check "confirm link works" 'curl -s -X POST "$optin" -d confirm=true | grep -q Confirmed'
empty_inbox
check "resubmitting a confirmed address sends only a link" 'fn POST subscribe "{\"email\":\"ann@example.com\"}" > /dev/null && [[ $(inbox ann@example.com) == "Your blr.today weekly link" ]]'
token=$(html ann@example.com | grep -o 'subscribe/#[0-9]*\.[0-9a-f-]*' | head -1 | cut -d'#' -f2)
check "resubmitting keeps the saved choices" '[[ $(fn GET prefs "$token") == *"\"always\":[\"free\"],\"never\":[\"pricey\"]"* ]]'
check "a wrong uuid is refused" '[[ $(fn GET prefs "${token%%.*}.00000000-0000-0000-0000-000000000000") == 404* ]]'
check "choices save through the link" '[[ $(fn POST prefs "{\"token\":\"$token\",\"always\":[\"indiranagar\"],\"never\":[]}") == 200* ]]'
check "saved choices read back" '[[ $(fn GET prefs "$token") == *"\"always\":[\"indiranagar\"],\"never\":[]"* ]]'
empty_inbox
check "an unconfirmed resubmit sends one confirmation" 'fn POST subscribe "{\"email\":\"bo@example.com\"}" > /dev/null && empty_inbox && fn POST subscribe "{\"email\":\"bo@example.com\"}" > /dev/null && [[ $(inbox bo@example.com) == "Confirm subscription" ]]'
check "a link for an unknown address sends nothing" 'fn POST link "{\"email\":\"nobody@example.com\"}" > /dev/null && [[ -z $(inbox nobody@example.com) ]]'
check "the honeypot sends nothing" 'fn POST subscribe "{\"email\":\"bot@example.com\",\"website\":\"x\"}" > /dev/null && [[ -z $(inbox bot@example.com) ]]'

empty_inbox
config=$WORK/scheduler.yml
sed "s#listmonk: https://lists.blr.today#listmonk: $LM\n  list: $LISTMONK_LIST_ID\n  template: $LISTMONK_WEEKLY_TEMPLATE_ID#" "$SCHEDULER/scheduler.yml" > "$config"
digest() { (cd "$SCHEDULER" && LISTMONK_API_USER=digest LISTMONK_API_TOKEN=$(cat "$WORK/token-digest") \
  uv run --frozen python -m scheduler --config "$config" --website "$WEBSITE" --state "$WORK/state" digest --send); }
check "the weekly email is sent" 'digest | grep -q sending'
sleep 5
check "only confirmed subscribers get it" '[[ -n $(inbox ann@example.com) && -z $(inbox bo@example.com) ]]'
check "it links to the manage page" 'html ann@example.com | grep -q "blr.today/subscribe/#$token"'
headers=$(curl -s "$MP/api/v1/message/$(curl -s "$MP/api/v1/search?query=to:ann@example.com" | jq -r '.messages[0].ID')/headers")
check "it has one-click unsubscribe headers" '[[ $(jq -r ".[\"List-Unsubscribe-Post\"][0]" <<< "$headers") == "List-Unsubscribe=One-Click" ]]'
check "a second run does not resend" 'digest | grep -q already'
unsub=$(jq -r '.["List-Unsubscribe"][0]' <<< "$headers" | grep -o 'http[^>]*')
check "one-click unsubscribe works" 'curl -sf -X POST "$unsub" -d List-Unsubscribe=One-Click > /dev/null && [[ $(fn GET prefs "$token") == *"\"subscribed\":false"* ]]'

echo "$fails failed"
exit "$((fails > 0))"
