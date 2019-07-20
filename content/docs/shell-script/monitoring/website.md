---
title: Website Alarm
tags:
    - monitoring
    - curl
    - alarm
weight: 1
---

# Monitoring

## Monitoring if https response contains text

```bash
echo -en '\e[2J\e]\e[0;0H\e]';
while true; do
    {
        curl --fail-early --fail --show-error --silent \
                --max-time 5 \
                --connect-timeout 3 \
                --dump-header - \
                --output - \
                --request GET \
                https://hellupline.com.br |
            tr -d '\n' | grep -Eo '<titlee>[^<]+</title>'
    } || {
        notify-send --urgency=critical --app-name=stall \
                STALL \
                "https://hellupine.com.br/ DOWN" &&
            mpv --really-quiet https://hellupline.com.br/stall.opus;
    }

    date;
    sleep 1;
    echo -en '\e[0;0H\e]';
done
```
