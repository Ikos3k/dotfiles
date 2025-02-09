#!/bin/sh

BACKLIGHT=$(cat /sys/class/backlight/*/brightness)
# BACKLIGHT=$(cat /sys/class/backlight/acpi_video0/actual_brightness)
MAX_BACKLIGHT=$(cat /sys/class/backlight/*/max_brightness)
URGENCY="normal"
CHARACTERS=35
bar=""

BACKLIGHT_NORM=$((BACKLIGHT*100/MAX_BACKLIGHT))

bar="["
FILLED_CHARACTERS=$((BACKLIGHT_NORM * CHARACTERS / 100))
for ((i=0;i<$FILLED_CHARACTERS;++i)); do
    bar="${bar}▮"
done
for ((i=$FILLED_CHARACTERS;i<$CHARACTERS;++i)); do
    bar="${bar} "
done
bar="${bar}]    (${BACKLIGHT_NORM}%)"

notify-send "$bar" -u $URGENCY -t 1000 -r 555
