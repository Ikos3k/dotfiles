#!/bin/bash
# sleep 0.05 # for terminals like xfce4-terminal, lxterminal 

tput clear

cols=$(tput cols)
rows=$(tput lines)
half=$((cols / 2))

min_height=10
image_height=$((rows - 2))

fortune -a -s | cowsay -W $((half - 2)) -r
# fastfetch --logo "/home/ikos3k/testweb/public/images/$(ls "/home/ikos3k/testweb/public/images/" | shuf -n 1)" --logo-width 50 --logo-padding-top 0 --logo-padding-right 0 --logo-padding-left 0 --logo-preserve-aspect-ratio 1
# fastfetch --logo "/home/ikos3k/testweb/public/images/download222.jpeg" --logo-width 50 --logo-padding-top 0 --logo-padding-right 0 --logo-padding-left 0 --logo-preserve-aspect-ratio 1

image_path="/home/ikos3k/image-processing/out/006_4889f.jpg"
# image_path="/home/ikos3k/image-processing/out/$(ls "/home/ikos3k/image-processing/out/" | shuf -n 1)"

dimensions=$(identify -format "%w %h" "$image_path")
orig_w=$(echo "$dimensions" | cut -d' ' -f1)
orig_h=$(echo "$dimensions" | cut -d' ' -f2)
prop_width=$(awk "BEGIN {print int( ($orig_w / $orig_h) * $image_height * 2 + 0.999 ) }")
available_width=$half

if (( prop_width > available_width )); then
    prop_height=$(awk "BEGIN {print int( ($orig_h / $orig_w) * $available_width / 2 + 0.999 ) }")
    x=$((cols - available_width))
    viu --absolute-offset -x "$x" -y 1 -w "$available_width" -s "$image_path"
else
    x=$((cols - prop_width))
    viu --absolute-offset -x "$x" -y 1 -h "$image_height" -s "$image_path"
fi