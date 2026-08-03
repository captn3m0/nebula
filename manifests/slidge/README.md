# slidge manifests

This directory holds the namespace manifest and Helm values for the `slidge-zulip` chart.

## Install

```bash
kubectl apply -f manifests/slidge/namespace.yaml

helm upgrade --install slidge-zulip \
  /home/nemo/projects/personal/521ab-sync/slidge-zulip/charts/slidge-zulip \
  --namespace slidge \
  -f manifests/slidge/values.yaml
```

This values file assumes cert-manager is already installed and that a `ClusterIssuer`
named `letsencrypt-prod` exists.
