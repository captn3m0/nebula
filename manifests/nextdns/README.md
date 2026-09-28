# nextdns

CronJob that disables every denylist entry on the NextDNS profile `Jeju`
(`ccb484`) during its Recreation Time, and re-enables them outside it.

The schedule and timezone are read from the profile's parental control
recreation settings, so edit them at <https://my.nextdns.io/ccb484/parentalcontrol>.
The job runs every 5 minutes and only PATCHes entries that need flipping.

## Install

```bash
kubectl apply -k manifests/nextdns
cd manifests/tofu && tofu apply -target=kubernetes_secret_v1.nextdns_api
```

The API key comes from `pass Keys/NEXTDNS_API`.

## Test locally

```bash
NEXTDNS_API_KEY=$(pass show Keys/NEXTDNS_API) NEXTDNS_PROFILE=ccb484 \
  uv run manifests/nextdns/recreation.py --dry-run --at 2026-09-28T18:00
```
