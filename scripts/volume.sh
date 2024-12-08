#!/bin/sh

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '[0-9]+(?=%)' | head -1)
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP '(?<=Mute: )\w+')
URGENCY="low"

if [ "$MUTED" = "yes" ]; then
    bar="?   Mute"
    URGENCY="critical"
else
    bar="♫  "

    VOLUME_NORM=$VOLUME
    if [ "$VOLUME" -gt 100 ]; then
        VOLUME_NORM=100
    fi

    ((chunks=VOLUME_NORM/10))
    for ((i=0;i<chunks;++i)); do
        bar="${bar} ●"
    done
    if ((VOLUME_NORM-10*chunks > 4)); then
        bar="${bar} ◉"
        ((++chunks))
    fi
    for ((i=chunks;i<10;++i)); do
        bar="${bar} ○"
    done
    bar="${bar} (${VOLUME}%)"
    
    if [ "$VOLUME" -gt 100 ]; then
        URGENCY="critical"
    fi
fi

# dunstify "$bar" -u $URGENCY -t 1000 -h int:value:"$VOLUME" -h string:synchronous:"$bar" --replace=555
dunstify "$bar" -u $URGENCY -t 1000  --replace=555
# pkill dunst && dunst &
