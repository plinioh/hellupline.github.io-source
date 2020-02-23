---
title: linux
weight: 100
type: docs
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## process management

### resident memory in megabytes for pid

```bash
ps - o pid, rss, % mem, command ax | awk '/ ^\s * PID\s / {
    d = "date --utc +%Y-%m-%dT%T%z"
    d | getline curtime
    close(d)
    print curtime","$1"", "$2/1024,"$3","$4
}'
```

## services management

### list running

```bash
systemctl list-units --type=service --state=running --all  # service --status-all
```

### services

```bash
systemctl enable --now SERVICE  # chkconfig SERVICE on
systemctl disable --now SERVICE  # chkconfig SERVICE off
systemctl is-enabled SERVICE  # chkconfig SERVICE
systemctl daemon-reload  # chkconfig SERVICE --add

systemctl start SERVICE  # service SERVICE start
systemctl stop SERVICE  # service SERVICE stop
systemctl status SERVICE  # service SERVICE status
systemctl restart SERVICE  # service SERVICE restart
systemctl reload SERVICE  # service SERVICE reload
```

### inspect

```bash
journalctl --follow --since=today  # tail --follow /var/log/{messages,syslog}
journalctl --dmesg
journalctl --unit SERVICE

journalctl --list-boots
journalctl --boot BOOT_ID
```
