#!/bin/sh

set -o pipefail # exit on pipeline error
set -e # exit on error
set -u # variable must exist
set -x # verbose

ALARM_URL="https://hellupline.dev/stall.opus"

WEBSITE_URL="https://hellupline.dev/"

echo -en '\e[2J\e]\e[0;0H\e]';
while true; do
    {
        curl --fail-early --fail --show-error --silent \
                --max-time 5 \
                --connect-timeout 3 \
                --dump-header - \
                --output - \
                --request GET \
                "${WEBSITE_URL}" |
            tr -d '\n' | grep -Eo '<title>[^<]+</title>'
    } || {
        echo OFFLINE
        notify-send --urgency=critical --app-name=stall \
                OFFLINE \
                "${WEBSITE_URL} DOWN" &&
            mpv --really-quiet "${ALARM_URL}";
    }
    date;

    sleep 1;
    echo -en '\e[0;0H\e]';
done
