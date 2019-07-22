---
title: Utils
weight: 99

---
# Utils

## Python helpers

### Prettify JSON

```bash
python -m json.tool
```

### Simple SMTP Debug Server

```bash
sudo python -m smtpd -n -c DebuggingServer localhost:25
```

### Simple HTTP Server

```bash
python -m http.server
```

## Rsync

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

##

```bash
youtube-dl \
    --audio-format mp3 \
    --audio-quality 320k \
    --extract-audio
```
