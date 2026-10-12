# ansible

Host-level configuration for nodes that k3s and tofu don't manage.

- `ceylon.yml`: a 2 GB swapfile, `vm.swappiness = 10`, and kubelet hard eviction at
  150Mi free memory, so memory pressure evicts a pod instead of hanging the node.
  It also caps k3s' Go heap (`GOMEMLIMIT`, via a `k3s.service.d` drop-in), disables the unused cloud-controller
  and network-policy controllers, stops docker, and caps the journal at 300M.
  It also asserts the default route uses the anchor gateway, so egress stays on
  the floating IP (`--tags egress` to check just that).

```
ansible-playbook -i inventory.ini ceylon.yml --check --diff
ansible-playbook -i inventory.ini ceylon.yml
```
