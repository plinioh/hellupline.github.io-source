---
title: Utils
weight: 999
bookCollapseSection: false
bookFlatSection: false
bookToc: true

---

## Prettify JSON

```bash
python -m json.tool
```

## Simple SMTP Debug Server

```bash
sudo python -m smtpd -n -c DebuggingServer localhost:25
```

## Simple HTTP Server

```bash
python -m http.server
```

## Rsync

```bash
rsync --verbose --human-readable --progress --stats --partial --archive \
      --exclude 'stuff/_data' \
      -- 'SOURCE_OBJECT_1' 'SOURCE_OBJECT_2' 'SOURCE_OBJECT_3' 'TARGET'
```

## Random Password

```bash
openssl rand -base64 33
```

## Date

```bash
# RFC-3339
date --date='1991-01-22 19:00:00 +300'
date --rfc-3339=seconds

# Timestamp
date --date='@664581600'
date '+%s'

# Relative
date --date="next Friday"
date --date="2 days ago"
```

## Download audio from video

```bash
youtube-dl \
    --audio-format mp3 \
    --audio-quality 320k \
    --extract-audio
```

## Stream desktop to address

```bash
ffmpeg -f x11grab -s 1600x900 -framerate 15 -i :0.0 -c:v libx264 -preset fast -s 1600x900 -threads 0 -f mpegts udp://127.0.0.1:2000
```

```bash
mpv udp://127.0.0.1:2000
```
