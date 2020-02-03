---
title: linux
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## notifications

```bash
notify-send --urgency=critical --app-name=hello-nurse TITLE "BODY"
```

## clipboard

```bash
xclip -out -selection Clipboard > output.txt

xclip -in -selection Clipboard < input.txt
```
