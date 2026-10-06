#!/bin/bash
# Creates the blr.today fedi accounts, sets their profiles, and stores passwords and API tokens in pass
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
host=${SNAC_URL:-https://fedi.blr.today}
prefix=${PASS_PREFIX:-blr.today/fedi}
avatar=${AVATAR:-$here/../../../blr-today-website/img/android-chrome-512x512.png}
kubectl=${KUBECTL:-kubectl}
all="One of blr.today's area, topic and venue accounts: follow the ones you care about."
# Accounts that can't be followed: they only exist for the others to boost
locked="events"

# uid|display name|bio
accounts=$(cat <<EOF
events|BLR.today Events|Every upcoming Bengaluru event from blr.today, posted 2–7 days ahead. Follow the area, topic and venue accounts instead: they boost the events you care about.
curated|BLR.today Curated 🍉|Events from the blr.today homepage calendar. $all
lastcall|BLR.today Last Call|Replies when a blr.today event is nearly sold out. Mute this account or #lastcall to skip them. $all
indiranagar|BLR.today Indiranagar|Upcoming events in Indiranagar from blr.today. $all
cbd|BLR.today Central Bengaluru|Upcoming events in Central Bengaluru from blr.today. $all
whitefield|BLR.today Whitefield|Upcoming events in Whitefield from blr.today. $all
koramangala|BLR.today Koramangala|Upcoming events in Koramangala from blr.today. $all
north|BLR.today North Bengaluru|Upcoming events in North Bengaluru from blr.today. $all
hsr|BLR.today HSR Layout|Upcoming events in HSR Layout from blr.today. $all
jpnagar|BLR.today JP Nagar|Upcoming events in JP Nagar from blr.today. $all
jayanagar|BLR.today Jayanagar|Upcoming events in Jayanagar from blr.today. $all
fitness|BLR.today Fitness|Upcoming fitness events in Bengaluru from blr.today. $all
free|BLR.today Free|Upcoming free events in Bengaluru from blr.today. $all
budget|BLR.today Budget|Upcoming Bengaluru events under ₹500 from blr.today. $all
workshops|BLR.today Workshops|Upcoming workshops in Bengaluru from blr.today. $all
sports|BLR.today Sports|Upcoming sports events in Bengaluru from blr.today. $all
food|BLR.today Food|Upcoming food events in Bengaluru from blr.today. $all
music|BLR.today Music|Upcoming music events in Bengaluru from blr.today. $all
film|BLR.today Film|Upcoming film screenings in Bengaluru from blr.today. $all
books|BLR.today Books|Upcoming book events in Bengaluru from blr.today. $all
underline|BLR.today Underline Center|Upcoming events at Underline Center from blr.today. $all
bic|BLR.today Bangalore International Centre|Upcoming events at Bangalore International Centre from blr.today. $all
sabha|BLR.today Sabha BLR|Upcoming events at Sabha BLR from blr.today. $all
scigallery|BLR.today Science Gallery Bengaluru|Upcoming events at Science Gallery Bengaluru from blr.today. $all
EOF
)

[ -f "$avatar" ] || { echo "avatar $avatar not found" >&2; exit 1; }
existing=$($kubectl -n snac exec deploy/snac -c snac -- ls /data/snac/user)
tokens=$(pass show "$prefix/github-actions-secret" 2>/dev/null || echo '{}')
while IFS="|" read -r -u 3 uid name bio; do
  if ! grep -qx "$uid" <<<"$existing"; then
    if pass show "$prefix/$uid" >/dev/null 2>&1; then
      echo "$uid is missing from snac but $prefix/$uid exists; refusing to guess" >&2; exit 1
    fi
    $kubectl -n snac exec deploy/snac -c snac -- snac adduser /data/snac "$uid" </dev/null \
      | sed -n 's/^User password is //p' | grep . | pass insert -m "$prefix/$uid" >/dev/null
    new=1
  else
    new=0
  fi
  pw=$(pass show "$prefix/$uid" 2>/dev/null | head -1) || true
  [ -n "$pw" ] || { echo "$uid exists in snac but has no password in $prefix/$uid" >&2; exit 1; }
  tok=$(jq -r --arg u "$uid" '.[$u] // empty' <<<"$tokens")
  if [ -z "$tok" ] || ! curl -sf -o /dev/null -H "Authorization: Bearer $tok" "$host/api/v1/accounts/verify_credentials"; then
    tok=$(curl -sf -X POST "$host/oauth/x-snac-get-token" --data-urlencode "login=$uid" --data-urlencode "passwd=$pw")
  fi
  [[ "$tok" =~ ^[0-9a-f]{32}$ ]] || { echo "login failed for $uid" >&2; exit 1; }
  me=$(curl -sf -H "Authorization: Bearer $tok" "$host/api/v1/accounts/verify_credentials")
  img=()
  [[ "$(jq -r .avatar <<<"$me")" == */s/* ]] || img=(-F "avatar=@$avatar;type=image/png")
  curl -sf -X PATCH -H "Authorization: Bearer $tok" "$host/api/v1/accounts/update_credentials" \
    --form-string "display_name=$name" --form-string "note=$bio" --form-string "bot=true" \
    --form-string "locked=$([[ " $locked " == *" $uid "* ]] && echo true || echo false)" "${img[@]}" >/dev/null
  tokens=$(jq -c --arg u "$uid" --arg t "$tok" '.[$u] = $t' <<<"$tokens")
  pass insert -m -f "$prefix/github-actions-secret" <<<"$tokens" >/dev/null
  [ "$new" = 1 ] && echo "$uid created" || echo "$uid updated"
done 3<<<"$accounts"
echo "FEDI_TOKENS saved to pass $prefix/github-actions-secret"
