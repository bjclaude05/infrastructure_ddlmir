# Server Hardening Checklist (Ubuntu/Debian)

| # | Control | How to apply | Verify |
|---|---|---|---|
| 1 | Disable root SSH login, use keys | `/etc/ssh/sshd_config`: `PermitRootLogin no`, `PasswordAuthentication no`, `MaxAuthTries 3` | `sshd -T \| grep -E 'permitroot\|passwordauth'` |
| 2 | Host firewall, default deny | `ufw default deny incoming`, allow only needed ports (see `network/firewall`) | `ufw status verbose` |
| 3 | Automatic security updates | `apt install unattended-upgrades` and `dpkg-reconfigure -plow unattended-upgrades` | `systemctl status unattended-upgrades` |
| 4 | Brute-force protection | `apt install fail2ban`, enable the `sshd` jail | `fail2ban-client status sshd` |
| 5 | Least privilege | Dedicated service accounts (`create_app_user.sh`), `sudo` by group, no shared accounts | `getent group sudo` |
| 6 | Logging and time sync | `rsyslog`/`journald` persistent, `chrony` for NTP, forward logs to a central server | `chronyc tracking`, `journalctl -p err -b` |
| 7 | Auditing | `apt install auditd` with rules for `/etc/passwd`, `/etc/sudoers`, `/etc/ssh` | `auditctl -l` |
| 8 | Remove unneeded services | `systemctl list-unit-files --state=enabled`, disable what is not used | `ss -tulpn` |
| 9 | File permissions | Secrets `chmod 600`, app dirs `750`, no world-writable files outside `/tmp` | `find / -xdev -perm -0002 -type f` |
| 10 | Backups tested | `tools/backup/backup.sh` scheduled, `restore-test.sh` monthly | Restore test log |
| 11 | Password policy | `libpam-pwquality`, minimum length 12, lockout via `faillock` | `/etc/security/pwquality.conf` |
| 12 | Kernel/network | `sysctl`: `net.ipv4.conf.all.rp_filter=1`, `net.ipv4.tcp_syncookies=1`, ignore ICMP redirects | `sysctl -a \| grep rp_filter` |

Review quarterly and after every major upgrade. Record exceptions with an owner and an expiry date.
