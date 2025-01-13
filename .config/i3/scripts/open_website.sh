#!/bin/bash

declare -A categories
categories=(
    ["AI"]="chatgpt deepseek duck.ai"
    ["Search Engines"]="google duckduckgo"
    ["Social Media"]="reddit discord"
    ["Development"]="github stackoverflow"
    ["Entertainment"]="youtube"
    ["Reference"]="wikipedia"
)

declare -A websites
websites=(
    ["google"]="https://www.google.com"
    ["duckduckgo"]="https://duckduckgo.com"
    ["chatgpt"]="https://chatgpt.com"
    ["deepseek"]="https://chat.deepseek.com"
    ["duck.ai"]="https://duck.ai"
    ["github"]="https://www.github.com"
    ["reddit"]="https://www.reddit.com"
    ["youtube"]="https://www.youtube.com"
    ["stackoverflow"]="https://www.stackoverflow.com"
    ["wikipedia"]="https://www.wikipedia.org"
    ["discord"]="https://discord.com/channels/@me"
)

if [[ "$1" == "rofi" ]]; then
    command="rofi -dmenu -theme ~/.config/rofi/mytheme.rasi"
else
    command='dmenu -nb #1e1e1e -sf #1e1e1e -sb #f4800d -nf #F4800d'
fi

if [[ "$ENABLE_CATEGORIES" -eq 1 ]]; then
    category=$(printf "%s\n" "${!categories[@]}" | $command -p "Select category:")

    if [ -n "$category" ]; then
        websites_in_category=${categories[$category]}
        website=$(echo "$websites_in_category" | tr ' ' '\n' | $command -p "Select website in $category:")

        if [ -n "$website" ]; then
            chromium --new-window "${websites[$website]}" &
        fi
    fi
else
    website=$(printf "%s\n" "${!websites[@]}" | $command -p "Select website:")
    if [ -n "$website" ]; then
        chromium --new-window "${websites[$website]}" &
    fi
fi
