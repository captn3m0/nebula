# zulip2tg manifests

Standalone (non-Helm) bidirectional Zulip <-> Telegram bridge, replacing
slidgram for Telegram. Runs in the existing `slidge` namespace. See
[captn3m0/zulip2tg](https://github.com/captn3m0/zulip2tg) for the source.

## Install

```bash
cp manifests/zulip2tg/secret.example.yaml manifests/zulip2tg/secret.yaml
# fill in zulip.key and telegram.bot_token in secret.yaml

kubectl apply -f manifests/zulip2tg/secret.yaml
kubectl apply -f manifests/zulip2tg/deployment.yaml
```

## Updating routes or credentials

Edit `secret.yaml`, `kubectl apply` it, then:

```bash
kubectl -n slidge rollout restart deployment/zulip2tg
```

(no checksum annotation here, since this isn't Helm-templated)
