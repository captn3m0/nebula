#!/usr/bin/env bash
# Idempotent listmonk setup for the blr.today weekly email: settings, list, roles, API users, templates
set -euo pipefail
: "${LISTMONK_URL:?}" "${LISTMONK_ADMIN_USER:?}" "${LISTMONK_ADMIN_PASSWORD:?}" "${ROOT_URL:?}" "${SMTP_HOST:?}" "${SMTP_PORT:?}"
SMTP_USER=${SMTP_USER:-} SMTP_PASSWORD=${SMTP_PASSWORD:-} SMTP_TLS=${SMTP_TLS:-STARTTLS}
OUT=${OUT:-.} HERE=$(dirname "$0")
jar=$(mktemp) && trap 'rm -f "$jar"' EXIT

api() {
  curl -sf -b "$jar" -H 'content-type: application/json' -X "$1" "$LISTMONK_URL$2" ${3:+--data "$3"}
}

curl -sf -c "$jar" -o /dev/null -X POST "$LISTMONK_URL/admin/login" \
  --data-urlencode "username=$LISTMONK_ADMIN_USER" --data-urlencode "password=$LISTMONK_ADMIN_PASSWORD" -d next=/admin

api GET /api/settings | jq --arg root "$ROOT_URL" --arg host "$SMTP_HOST" --argjson port "$SMTP_PORT" \
  --arg user "$SMTP_USER" --arg pass "$SMTP_PASSWORD" --arg tls "$SMTP_TLS" '.data
  | .["app.root_url"]=$root | .["app.site_name"]="blr.today" | .["app.from_email"]="blr.today <weekly@blr.today>"
  | .["app.check_updates"]=false | .["app.enable_public_archive"]=false | .["app.enable_public_subscription_page"]=false
  | .["app.message_rate"]=10 | .["bounce.enabled"]=true | .["bounce.webhooks_enabled"]=true | .["bounce.ses_enabled"]=true
  | .["privacy.individual_tracking"]=false | .["privacy.disable_tracking"]=true | .["privacy.unsubscribe_header"]=true
  | .["privacy.allow_preferences"]=false | .["privacy.allow_export"]=false | .["privacy.record_optin_ip"]=false
  | .smtp=[{name:"ses", enabled:true, host:$host, hello_hostname:"", port:$port,
      auth_protocol:(if $user == "" then "none" else "login" end), username:$user, password:$pass, email_headers:[],
      max_conns:4, max_msg_retries:2, msg_retry_delay:"10ms", idle_timeout:"15s", wait_timeout:"5s",
      tls_type:$tls, tls_skip_verify:false, from_addresses:[]}]' > "$jar.settings"
api PUT /api/settings "@$jar.settings" > /dev/null && rm -f "$jar.settings"
sleep 5 && for _ in $(seq 30); do api GET /api/lists > /dev/null 2>&1 && break || sleep 1; done

find_id() { jq -r --arg n "$2" "$1 | select(.name == \$n) | .id" | head -1; }

list=$(api GET '/api/lists?per_page=all' | find_id '.data.results[]' Weekly)
[ -n "$list" ] || list=$(api POST /api/lists '{"name":"Weekly","type":"public","optin":"double","description":"blr.today weekly events email"}' | jq .data.id)

list_roles=$(jq -nc --argjson l "$list" '{name:"weekly", lists:[{id:$l, permissions:["list:get","list:manage"]}]}')
list_role=$(api GET /api/roles/lists | find_id '.data[]' weekly)
if [ -n "$list_role" ]; then api PUT "/api/roles/lists/$list_role" "$list_roles" > /dev/null
else list_role=$(api POST /api/roles/lists "$list_roles" | jq .data.id); fi

declare -A perms=([web]='["subscribers:get","subscribers:manage","tx:send"]'
  [digest]='["campaigns:get","campaigns:manage","campaigns:send","templates:get"]')
for name in web digest; do
  body=$(jq -nc --arg n "$name" --argjson p "${perms[$name]}" '{name:$n, permissions:$p}')
  role=$(api GET /api/roles/users | find_id '.data[]' "$name")
  if [ -n "$role" ]; then api PUT "/api/roles/users/$role" "$body" > /dev/null
  else role=$(api POST /api/roles/users "$body" | jq .data.id); fi
  if [ -z "$(api GET /api/users | jq -r --arg n "$name" '.data[] | select(.username == $n) | .id')" ]; then
    user=$(jq -nc --arg n "$name" --argjson r "$role" --argjson l "$list_role" \
      '{username:$n, name:$n, type:"api", status:"enabled", user_role_id:$r, list_role_id:$l}')
    (umask 077 && api POST /api/users "$user" | jq -r .data.password > "$OUT/token-$name")
    echo "created API user $name, token in $OUT/token-$name" >&2
  fi
done

template() {
  body=$(jq -nc --arg n "$1" --arg t "$2" --arg s "$3" --rawfile b "$HERE/templates/$4" '{name:$n, type:$t, subject:$s, body:$b}')
  id=$(api GET /api/templates | find_id '.data[]' "$1")
  if [ -n "$id" ]; then api PUT "/api/templates/$id" "$body" > /dev/null && echo "$id"
  else api POST /api/templates "$body" | jq .data.id; fi
}
link_template=$(template "Manage link" tx "Your blr.today weekly link" manage-link.html)
weekly_template=$(template "blr.today weekly" campaign "" weekly.html)

for name in web digest; do
  if [ -n "${PASS_PREFIX:-}" ] && [ -s "$OUT/token-$name" ]; then
    printf '%s\nuser: %s\nlist_id: %s\nlink_template_id: %s\nweekly_template_id: %s\n' "$(cat "$OUT/token-$name")" \
      "$name" "$list" "$link_template" "$weekly_template" | pass insert -m -f "$PASS_PREFIX-$name" > /dev/null
    rm -f "$OUT/token-$name" && echo "stored the $name token in pass at $PASS_PREFIX-$name" >&2
  fi
done

echo "LISTMONK_LIST_ID=$list"
echo "LISTMONK_LINK_TEMPLATE_ID=$link_template"
echo "LISTMONK_WEEKLY_TEMPLATE_ID=$weekly_template"
