# cert-manager manifests

This directory holds the namespace manifest, HelmChart manifest, and issuer manifests for
cert-manager.

## Install cert-manager

```bash
kubectl apply -f manifests/cert-manager/namespace.yaml
kubectl apply -f manifests/cert-manager/helmchart.yaml
```

k3s' helm-controller picks up the `HelmChart` resource and installs the chart.

## Configure an issuer
clusterissuer-cloudflare-tatooine -> tatooine.club
clusterissuer-cloudflare.yaml -> bb8.fun