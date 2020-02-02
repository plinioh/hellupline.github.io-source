---
title: ssh
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---


## GPG

### List Output Format

```bash
# sec   rsa4096/xxxxxxxxxxxxxxxx 0000-00-00 [SC]
#       yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
# uid                 [ultimate] My Name <me@mail.com>
# ssb   rsa4096/zzzzzzzzzzzzzzzz 0000-00-00 [E]
```

### Generate Key

```bash
gpg --full-generate-key
```

### Encrypt

```bash
gpg \
   --output file.txt.enc \
   --encrypt \
   --local-user hellupline@gmail.com \
   --recipient hellupline@gmail.com \
   file.txt
```

### Encrypt with Symmetric ( passphrase )

```bash
gpg --output file.txt.enc --symmetric file.txt
```

### Decrypt

```bash
gpg --output file.txt.enc --decrypt file.txt
```

### Sign File

```bash
gpg --sign file.txt
```

### Clear Sign File

```bash
gpg --clear-sign file.txt
```

### Verify File

```bash
gpg --output file.txt --verify file.txt.gpg
```

### Detach Sign File

```bash
gpg --output file.txt.sig --detach-sig file.txt
```

### Detach Verify File

```bash
gpg --verify file.txt.sig file.txt
```

### List PrivKeys

```bash
gpg --list-secret-keys --keyid-format LONG
```

### List PubKeys

```bash
gpg --list-keys --keyid-format LONG
```

### Export PubKey ( for github )

```bash
> pubkey.asc gpg --export --armor ID
```

### Export PrivKey

```bash
> privkey.asc gpg --export-secret-keys --armor ID
```

### Import PrivKey

```bash
gpg --import privkey.asc

gpp --edit-key ID trust quit
```

### Delete PrivKey

```bash
gpg --delete-secret-key ID
```

### Delete PubKey

```bash
gpg --delete--key ID
```