#!/bin/bash

# Define a list of websites with associated program names
declare -A websites
websites=(
    ["google"]="https://www.google.com"
    ["chatgpt"]="https://chatgpt.com"
    ["github"]="https://www.github.com"
    ["reddit"]="https://www.reddit.com"
    ["youtube"]="https://www.youtube.com"
    ["stackoverflow"]="https://www.stackoverflow.com"
    ["wikipedia"]="https://www.wikipedia.org"
    ["discord"]="https://discord.com/channels/@me"
)

# Use dmenu to prompt the user to type a website name
website=$(echo "${!websites[@]}" | tr ' ' '\n' | dmenu -p "Enter website:")

# Check if a website was selected and open it in Chromium
if [ -n "$website" ]; then
    chromium --new-window "${websites[$website]}"
fi
