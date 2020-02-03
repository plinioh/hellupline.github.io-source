---
title: ssh
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## Generate key

```bash
ssh-keygen -t rsa -b 4096 -C "me@mail.com"
```

## Change Key Passphrase

```bash
ssh-keygen -p -f ~/.ssh/id_rsa
```

## Test Key Passphrase

```bash
ssh-keygen -y -f ~/.ssh/id_rsa
```
