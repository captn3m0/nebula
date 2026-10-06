#!/bin/bash
# Creates the blr.today fedi accounts, sets their profiles, and stores passwords and API tokens in pass
set -euo pipefail
host=${SNAC_URL:-https://fedi.blr.today}
prefix=${PASS_PREFIX:-blr.today/fedi}
avatar=${AVATAR:-../../../blr-today-website/img/android-chrome-512x512.png}
declare -A names=([events]="BLR.today Events" [indiranagar]="BLR.today Indiranagar" [curated]="BLR.today Curated 🍉" [lastcall]="BLR.today Last Call")
declare -A notes=(
  [events]="Upcoming events in Bengaluru from blr.today, posted through the day (10am–7pm IST). Area and curated accounts boost from here."
  [indiranagar]="Boosts upcoming events in Indiranagar, Domlur, HAL and Old Airport Road from blr.today/cal/indiranagar."
  [curated]="Boosts events from the curated blr.today calendar, the one on blr.today's homepage."
  [lastcall]="Replies when a blr.today event is nearly sold out. Mute this account or #lastcall to skip them."
)
tokens='{}'
for uid in events indiranagar curated lastcall; do
  if ! pass show "$prefix/$uid" >/dev/null 2>&1; then
    ${KUBECTL:-kubectl} -n snac exec deploy/snac -c snac -- /opt/snac/snac adduser /data/snac "$uid" </dev/null \
      | sed -n 's/^User password is //p' | grep . | pass insert -m "$prefix/$uid" >/dev/null
  fi
  pw=$(pass show "$prefix/$uid" | head -1)
  [ -n "$pw" ] || { echo "no password for $uid in $prefix/$uid" >&2; exit 1; }
  tok=$(curl -sf -X POST "$host/oauth/x-snac-get-token" --data-urlencode "login=$uid" --data-urlencode "passwd=$pw")
  [[ "$tok" =~ ^[0-9a-f]+$ ]] || { echo "login failed for $uid" >&2; exit 1; }
  curl -sf -X PATCH -H "Authorization: Bearer $tok" "$host/api/v1/accounts/update_credentials" \
    -F "display_name=${names[$uid]}" -F "note=${notes[$uid]}" -F "bot=true" -F "avatar=@$avatar;type=image/png" >/dev/null
  tokens=$(jq -c --arg u "$uid" --arg t "$tok" '.[$u] = $t' <<<"$tokens")
  echo "$uid ready"
done
pass insert -m -f "$prefix/github-actions-secret" <<<"$tokens" >/dev/null
echo "FEDI_TOKENS saved to pass $prefix/github-actions-secret"
