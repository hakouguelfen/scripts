#!/usr/bin/env bash

scriptName="lightController"
msgTag="mylight"

max_brightness=96000
current_brightness=$(brightnessctl get)
current_percentage=$((current_brightness * 100 / max_brightness))

if [[ "$1" == "UP" ]]; then
    if (( current_percentage < 5 )); then
        brightnessctl set 1%+
    else
        brightnessctl set 5%+
    fi
elif [[ "$1" == "DOWN" ]]; then
    if (( current_percentage <= 5 )); then
        brightnessctl set 1%-
    else
        brightnessctl set 5%-
    fi
else
    echo "Usage: $0 {UP|DOWN}"
fi

next_brightness=$(brightnessctl get)
next_percentage=$((next_brightness * 100 / max_brightness))
dunstify -a "$scriptName" -t 1500 -i custom/sun-solid -h string:x-dunst-stack-tag:$msgTag "ⴼⴰⵡⵜ: " -h int:value:"$next_percentage"

