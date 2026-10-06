# ansible

Host-level configuration for nodes that k3s and tofu don't manage.

- `ceylon.yml`: a 2 GB swapfile, `vm.swappiness = 10`, and kubelet hard eviction at
  150Mi free memory, so memory pressure evicts a pod instead of hanging the node.

```
ansible-playbook -i inventory.ini ceylon.yml --check --diff
ansible-playbook -i inventory.ini ceylon.yml
```
