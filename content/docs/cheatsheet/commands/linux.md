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

## process management

### resident memory in megabytes for pid

```
ps -o pid,%mem,rss,command ax | awk '/^\sPID/ {
    str = "date -u '+%Y-%m-%dT%T%z'";
    str | getline date;
    close str;
    print date","$2","$3/1024","$4
}'
```
