#!/bin/bash

declare -A websites
websites=(
    ["google"]="https://www.google.com"
    ["chatgpt"]="https://chatgpt.com"
    ["deepseek"]="https://chat.deepseek.com/"
    ["duck.ai"]="https://duck.ai/"
    ["github"]="https://www.github.com"
    ["reddit"]="https://www.reddit.com"
    ["youtube"]="https://www.youtube.com"
    ["stackoverflow"]="https://www.stackoverflow.com"
    ["wikipedia"]="https://www.wikipedia.org"
    ["discord"]="https://discord.com/channels/@me"
)

website=$(echo "${!websites[@]}" | tr ' ' '\n' | dmenu -p "Enter website:")

if [ -n "$website" ]; then
    chromium --new-window "${websites[$website]}"
fi
