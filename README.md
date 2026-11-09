# Problem 2: Linux hardening with Ansible

## What it does

The playbook applies a small hardening baseline to Ubuntu or RHEL hosts: it disables root SSH login and password authentication, limits SSH attempts and forwarding, installs and enables fail2ban, and enables unattended upgrades on Debian hosts.

The role is safe to review without a server. The structure test checks that the important controls are present. Use Ansible check mode against a real inventory when you are ready to review a host without changing it.

See [`DESIGN.md`](DESIGN.md) for the role flow and rollout safeguards.

## Files

- `site.yml`: entry point that applies the role to the `linux` group.
- `inventory.ini.example`: inventory shape; replace the example address locally.
- `roles/linux_hardening/defaults`: editable defaults.
- `roles/linux_hardening/tasks`: package and service tasks.
- `roles/linux_hardening/templates`: SSH settings written to a drop-in file.
- `roles/linux_hardening/handlers`: restarts SSH only when its config changes.
- `tests/test-structure.sh`: offline check for the expected controls.

## Demo

```bash
bash tests/test-structure.sh
ansible-playbook --syntax-check -i inventory.ini.example site.yml
ansible-playbook --check --diff -i inventory.ini.example site.yml
```

Say: “The role is idempotent: if the desired package, service, or setting is already correct, Ansible reports no change. The handler restarts SSH only when the drop-in changes.” Do not run a real apply until you have a test host and a working SSH key.

