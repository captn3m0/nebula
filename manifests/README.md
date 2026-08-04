# Kubernetes manifests and Helm values

Each subdirectory here corresponds to one namespace or cluster-scoped setup:

- `cert-manager/` for the cert-manager namespace and cluster-wide issuers
- `slidge/` for the Slidge Zulip bridge namespace and Helm values

The intended flow is:

1. install cert-manager with `manifests/cert-manager/values.yaml`
2. apply one of the `ClusterIssuer` manifests from `manifests/cert-manager/`
3. install `slidge-zulip` into the `slidge` namespace with `manifests/slidge/values.yaml`

`slidge/` only references cert-manager; it does not try to install cert-manager itself.
