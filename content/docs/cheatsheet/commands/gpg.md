---
title: gpg
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## list output format

```bash
# sec   rsa4096/xxxxxxxxxxxxxxxx 0000-00-00 [SC]
#       yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
# uid                 [ultimate] My Name <me@mail.com>
# ssb   rsa4096/zzzzzzzzzzzzzzzz 0000-00-00 [E]
```

## generate key

```bash
gpg --full-generate-key
```

## encrypt

```bash
gpg \
   --output file.txt.enc \
   --encrypt \
   --local-user hellupline@gmail.com \
   --recipient hellupline@gmail.com \
   file.txt
```

## encrypt with passphrase

```bash
gpg --output file.txt.enc --symmetric file.txt
```

## decrypt

```bash
gpg --output file.txt.enc --decrypt file.txt
```

## sign file

```bash
gpg --sign --armor file.txt
```

## clear sign file

```bash
gpg --clear-sign file.txt
```

## verify file

```bash
gpg --output file.txt --verify file.txt.gpg
```

## detach sign file

```bash
gpg --output file.txt.sig --detach-sig file.txt
```

## detach verify file

```bash
gpg --verify file.txt.sig file.txt
```

## list privkeys

```bash
gpg --list-secret-keys --keyid-format LONG
```

## list pubkeys

```bash
gpg --list-public-keys --keyid-format LONG
```

## export pubkey ( for github )

```bash
gpg --output pubkey.asc --export --armor ID
```

## export privkey

```bash
gpg --output privkey.asc --export-secret-keys --armor ID
```

## import privkey

```bash
gpg --import privkey.asc

gpp --edit-key ID trust quit
```

## change privkey  passphrase

```bash
gpp --edit-key ID passwd save
```

## delete privkey

```bash
gpg --delete-secret-key ID
```

## delete pubkey

```bash
gpg --delete--key ID
```
