#!/bin/sh

# Get the current volume percentage
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '[0-9]+(?=%)' | head -1)
# Check if the sink is muted
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP '(?<=Mute: )\w+')

# Set default urgency to low
URGENCY="low"

# Handle the muted case
if [ "$MUTED" = "yes" ]; then
    bar="?   Mute"
    URGENCY="critical"
else
    bar="♫  "
    ((chunks=VOLUME/10))
    for ((i=0;i<chunks;++i)); do
        bar="${bar} ●"
    done
    if ((VOLUME-10*chunks > 4)); then
        bar="${bar} ◉"
        ((++chunks))
    fi
    for ((i=chunks;i<10;++i)); do
        bar="${bar} ○"
    done
    bar="${bar} (${VOLUME}%)"
    
    # Set urgency to critical if volume is very high (e.g., above 80%)
    if [ "$VOLUME" -gt 100 ]; then
        URGENCY="critical"
    fi
fi

# Display the notification with the current volume level
dunstify "$bar" -u $URGENCY -t 1000 -h int:value:"$VOLUME" -h string:synchronous:"$bar" --replace=555

# pkill dunst && dunst &
