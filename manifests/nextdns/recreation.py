#!/usr/bin/env python3
import argparse
import json
import os
import sys
import urllib.parse
import urllib.request
from datetime import datetime, time, timedelta
from zoneinfo import ZoneInfo

API = "https://api.nextdns.io"
DAYS = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]


def call(method, path, key, body=None):
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(API + path, data=data, method=method)
    req.add_header("X-Api-Key", key)
    req.add_header("Content-Type", "application/json")
    req.add_header("User-Agent", "nebula-nextdns-recreation/1.0")
    with urllib.request.urlopen(req, timeout=30) as resp:
        raw = resp.read()
    return json.loads(raw) if raw else None


def in_recreation(times, now):
    for offset in (0, -1):
        day = now.date() + timedelta(days=offset)
        window = times.get(DAYS[day.weekday()])
        if not window:
            continue
        start = datetime.combine(day, time.fromisoformat(window["start"]), now.tzinfo)
        end = datetime.combine(day, time.fromisoformat(window["end"]), now.tzinfo)
        if end <= start:
            end += timedelta(days=1)
        if start <= now < end:
            return True
    return False


def main():
    parser = argparse.ArgumentParser(description="Toggle NextDNS denylist during recreation time")
    parser.add_argument("--profile", default=os.environ.get("NEXTDNS_PROFILE"))
    parser.add_argument("--at", help="ISO local time to evaluate instead of now")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    key = os.environ.get("NEXTDNS_API_KEY")
    if not key or not args.profile:
        sys.exit("NEXTDNS_API_KEY and NEXTDNS_PROFILE are required")

    profile = call("GET", f"/profiles/{args.profile}", key)["data"]
    recreation = profile["parentalControl"]["recreation"]
    tz = ZoneInfo(recreation["timezone"])
    now = datetime.fromisoformat(args.at).replace(tzinfo=tz) if args.at else datetime.now(tz)
    active = not in_recreation(recreation["times"], now)
    print(f"{profile['name']} {now.isoformat()} recreation={not active} denylist active={active}")

    for entry in profile["denylist"]:
        if entry["active"] == active:
            continue
        print(f"  {entry['id']}: {entry['active']} -> {active}")
        if not args.dry_run:
            entry_id = urllib.parse.quote(entry["id"], safe="")
            call("PATCH", f"/profiles/{args.profile}/denylist/{entry_id}", key, {"active": active})


if __name__ == "__main__":
    main()
