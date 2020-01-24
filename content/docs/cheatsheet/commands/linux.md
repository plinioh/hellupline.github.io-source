---
title: Linux
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## Notifications

```bash
notify-send --urgency=critical --app-name=hello-nurse TITLE "BODY"
```

## Clipboard

```bash
xclip -out -selection Clipboard > output.txt

xclip -in -selection Clipboard < input.txt
```
