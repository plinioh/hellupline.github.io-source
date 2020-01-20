---
title: Netcat
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## Connect to Server


```bash
netcat -vvv localhost 8000
```


## Listen do Port

```bash
netcat -vvv -l -p 8000 -s localhost
```


## Port Tunnel

```bash
netcat -vvv -L "localhost:8001" -p 8000 -s localhost
```
