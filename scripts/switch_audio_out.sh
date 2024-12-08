#!/bin/bash

SAFE_MODE=true
sinks=($(pactl list short sinks | awk '{print $2}'))
current_sink=$(pactl get-default-sink)

current_index=-1
for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current_sink" ]]; then
        current_index=$i
        break
    fi
done

next_index=$(( (current_index + 1) % ${#sinks[@]} ))
pactl set-default-sink "${sinks[$next_index]}"

pactl list short sink-inputs | while read -r line; do
    input_id=$(echo $line | awk '{print $1}')
    pactl move-sink-input "$input_id" "${sinks[$next_index]}"
done

if $SAFE_MODE; then
    pactl set-sink-mute "${sinks[$next_index]}" 1
    echo "Safe mode is ON: Output is muted after switching."
else
    pactl set-sink-mute "${sinks[$next_index]}" 0
    echo "Safe mode is OFF: Output remains unmuted after switching."
fi
