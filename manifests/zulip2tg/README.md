# zulip2tg manifests

Standalone (non-Helm) bidirectional Zulip <-> Telegram bridge, replacing
slidgram for Telegram. Runs in the existing `slidge` namespace. See
[captn3m0/zulip2tg](https://github.com/captn3m0/zulip2tg) for the source.

## Install

```bash
cd manifests/tofu && tofu apply -target=kubernetes_secret_v1.zulip2tg_config
kubectl apply -f manifests/zulip2tg/deployment.yaml
```

The config secret is rendered by `manifests/tofu/zulip2tg.tf` from
`config.yaml.tftpl`. The Zulip API key and Telegram bot token come from
`pass Nebula/zulip2tg-zulip-key` and `pass Nebula/zulip2tg-telegram-bot-token`.

## Updating routes or credentials

Edit `config.yaml.tftpl` (routes) or the `pass` entries (credentials), re-run
the `tofu apply` above, then:

```bash
kubectl -n slidge rollout restart deployment/zulip2tg
```

(no checksum annotation here, since the deployment isn't managed by tofu)
