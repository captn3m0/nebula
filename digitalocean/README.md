# digitalocean

The `ceylon` droplet, its floating IP and firewalls, and the single-node k3s install
(`k3s.tf`). Host tuning (k3s `config.yaml`, Go runtime drop-in, swap) lives in
`../ansible/ceylon.yml`, because the k3s installer rewrites `k3s.service` and
`k3s.service.env` on every run.

## Kubeconfig and credentials in pass

`kubeconfig` holds only the cluster CA and server. The admin client cert and key live
in `pass Nebula/k3s-ceylon/{client-cert,client-key}`, and kubectl, helm and tofu get them
through an exec credential plugin. `kubeconfig-to-pass.sh` copies them from
`/etc/rancher/k3s/k3s.yaml` into pass and rewrites `kubeconfig`. `k3s.tf` runs it after
every install. To refresh by hand:

```sh
./kubeconfig-to-pass.sh 100.105.210.25 kubeconfig && cp kubeconfig ~/.kube/config
```

## Certificate rotation

Upstream: <https://docs.k3s.io/cli/certificate>

- Client and server certs are valid for 365 days. The current admin cert expires
  **2027-08-02** (`k3s certificate check --output table` on the host).
- k3s renews any cert that is expired or within 120 days of expiry **when it starts**.
  Renewal keeps the existing keys. From about 2027-04-04, any k3s restart renews them,
  including an upgrade, an ansible run that restarts k3s, or a reboot.
- Within that window k3s emits `CertificateExpirationWarning` events:
  `kubectl get events -A --field-selector reason=CertificateExpirationWarning`.
- k3s rewrites `/etc/rancher/k3s/k3s.yaml` with the renewed admin cert on each start,
  but the copy in pass is not updated automatically. The old cert keeps working until
  its own expiry, then kubectl fails with `x509: certificate has expired`. Re-run
  `kubeconfig-to-pass.sh` after any renewal. An upgrade through `k3s.tf` does this
  for you.
- If nothing restarts k3s inside the window, rotate manually before expiry:
  `systemctl stop k3s && k3s certificate rotate && systemctl start k3s`, then refresh pass.
- The CAs are valid for 10 years (until 2036) and are **not** renewed automatically:
  `k3s certificate rotate-ca`.

## Upgrading k3s

Upstream: <https://docs.k3s.io/upgrades/manual> and the release notes for the target
minor version (<https://docs.k3s.io/release-notes/v1.37.X>). Upgrade one minor version
at a time.

1. Read the k3s release notes and the Kubernetes *Urgent Upgrade Notes* in
   `CHANGELOG-1.xx.md`. Check them against the cluster: SELinux (off, AppArmor host),
   removed API versions (`kubectl get --raw /apis/<group>`), kubelet flags in
   `ansible/ceylon.yml`, and `apiserver_requested_deprecated_apis`.
2. Compare the bundled Traefik chart, because a chart major bump can reject our values:
   `curl https://raw.githubusercontent.com/k3s-io/k3s/<tag>/manifests/traefik.yaml`.
   Render it with `helm template traefik/traefik --version <x>`, passing k3s's
   `valuesContent` and `../manifests/traefik/helmchartconfig.yaml`. Fix and apply any
   schema errors **before** upgrading.
3. Back up the datastore (SQLite via kine). This stops the API briefly; pods keep running:
   `systemctl stop k3s; cp -a /var/lib/rancher/k3s/server/{db,token,tls} /etc/rancher/k3s/config.yaml /root/k3s-backup-<ver>-<date>/; systemctl start k3s`
4. Bump `k3s_version` in `variables.tf`, then
   `tofu apply -target=null_resource.k3s_install`. This reruns the installer and
   `kubeconfig-to-pass.sh`.
5. Verify: `kubectl get nodes` shows the new version, the `helm-install-*` jobs in
   `kube-system` succeed, the traefik image matches the release notes, ingress hosts
   return 200, and the k3s process still has `GOMEMLIMIT` (from the
   `k3s.service.d/go-runtime.conf` drop-in).
6. Rollback: stop k3s, restore the backed-up `db` and `token`, set the old
   `k3s_version`, and apply again.

### Log

- **2026-10-12, v1.36.2+k3s1 → v1.37.1+k3s1.** None of the Kubernetes 1.37 urgent
  notes applied (no SELinux, no `scheduling.k8s.io/v1alpha2` objects, `eventRecordQPS`
  unset). Traefik chart 40 → 41 removed the top-level `logs` value, so it was dropped
  from the HelmChartConfig (it only set the default `INFO`). The installer wiped
  `k3s.service.env`, so `GOMEMLIMIT`/`GOGC` moved to a systemd drop-in first. The
  upgrade also installed Gateway API CRDs (`gateway-api-crd` chart). Backup:
  `/root/k3s-backup-v1.36.2-2026-10-12`.
