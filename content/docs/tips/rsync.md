---
title: Rsync
tags:
weight: 0

---
# Rsync

```bash
# if source-dir ends with '/', sync contents
rsync \
    --verbose \
    --progress \
    --stats \
    --delete \
    --archive \
    --recursive \
    --links \
    --perms \
    --times \
    --group \
    --owner \
    --compress \
    source-dir/ \
    target-dir
```