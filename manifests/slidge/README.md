# slidge manifests

This directory holds the namespace manifest and Helm values for the `slidge-zulip` chart.

## Install

```bash
kubectl apply -f manifests/slidge/namespace.yaml
cd manifests/tofu && tofu apply -target=kubernetes_secret_v1.slidge_zulip_runtime && cd -

helm upgrade --install slidge-zulip \
  /home/nemo/projects/personal/521ab-sync/slidge-zulip/charts/slidge-zulip \
  --namespace slidge \
  -f manifests/slidge/values.yaml
```

Secrets live in `pass Nebula/slidge-*` and reach the chart via `secretRefName`, so
after rotating one, re-run the `tofu apply` and `kubectl -n slidge rollout restart deploy`.

This values file assumes cert-manager is already installed and that a `ClusterIssuer`
named `letsencrypt-prod` exists.
