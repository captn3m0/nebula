#!/bin/sh
# Moves k3s admin credentials into pass; the kubeconfig fetches them via an exec plugin
set -eu

host=$1
out=$2
prefix=Nebula/k3s-ceylon

raw=$(ssh -o StrictHostKeyChecking=accept-new "root@$host" cat /etc/rancher/k3s/k3s.yaml)
printf '%s' "$raw" | yq -r '.users[0].user."client-certificate-data"' | base64 -d |
  pass insert -m -f "$prefix/client-cert" >/dev/null
printf '%s' "$raw" | yq -r '.users[0].user."client-key-data"' | base64 -d |
  pass insert -m -f "$prefix/client-key" >/dev/null
ca=$(printf '%s' "$raw" | yq -r '.clusters[0].cluster."certificate-authority-data"')

cat >"$out" <<EOF
apiVersion: v1
kind: Config
clusters:
  - name: ceylon
    cluster:
      certificate-authority-data: $ca
      server: https://$host:6443
contexts:
  - name: ceylon
    context:
      cluster: ceylon
      user: ceylon
current-context: ceylon
users:
  - name: ceylon
    user:
      exec:
        apiVersion: client.authentication.k8s.io/v1
        interactiveMode: IfAvailable
        command: sh
        args:
          - -c
          - >-
            jq -n
            --arg c "\$(pass show $prefix/client-cert)"
            --arg k "\$(pass show $prefix/client-key)"
            '{apiVersion: "client.authentication.k8s.io/v1", kind: "ExecCredential",
            status: {clientCertificateData: \$c, clientKeyData: \$k}}'
EOF
