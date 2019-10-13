---
title: FFMPEG
weight: 99
bookToc: false

---

# Stream Desktop to port

```
ffmpeg -f x11grab -s 1600x900 -framerate 15 -i :0.0 -c:v libx264 -preset fast -s 1600x900 -threads 0 -f mpegts udp://127.0.0.1:2000
```

```
mpv  udp://1237.0.0.1:2000
```