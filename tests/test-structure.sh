#!/usr/bin/env bash
set -eu

grep -Fq 'linux_hardening' site.yml
grep -Fq 'PermitRootLogin no' roles/linux_hardening/templates/sshd-hardening.conf.j2
grep -Fq 'PasswordAuthentication no' roles/linux_hardening/templates/sshd-hardening.conf.j2
grep -Fq 'fail2ban' roles/linux_hardening/tasks/main.yml
grep -Fq 'unattended-upgrades' roles/linux_hardening/tasks/main.yml
printf '%s\n' 'PASS: hardening role contains the expected controls'

