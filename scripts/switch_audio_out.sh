#!/bin/bash

# Safe mode: Set to true to mute output after each change, false to keep it unmuted
SAFE_MODE=true

# Get the list of sink names
sinks=($(pactl list short sinks | awk '{print $2}'))

# Get the current default sink
current_sink=$(pactl get-default-sink)

# Find the index of the current sink in the list
current_index=-1
for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current_sink" ]]; then
        current_index=$i
        break
    fi
done

# Calculate the index of the next sink
next_index=$(( (current_index + 1) % ${#sinks[@]} ))

# Set the next sink as default
pactl set-default-sink "${sinks[$next_index]}"

# Move all currently playing streams to the new sink
pactl list short sink-inputs | while read -r line; do
    input_id=$(echo $line | awk '{print $1}')
    pactl move-sink-input "$input_id" "${sinks[$next_index]}"
done

# Check if SAFE_MODE is enabled
if $SAFE_MODE; then
    # Mute the new default sink
    pactl set-sink-mute "${sinks[$next_index]}" 1
    echo "Safe mode is ON: Output is muted after switching."
else
    # Unmute the new default sink
    pactl set-sink-mute "${sinks[$next_index]}" 0
    echo "Safe mode is OFF: Output remains unmuted after switching."
fi
