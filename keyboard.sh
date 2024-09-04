#!/usr/bin/env bash

keyboard=$(setxkbmap -query | grep "layout" | awk '{print $NF}')

if [[ "$keyboard" == "fr" ]]; then
    setxkbmap ara
    pkill -RTMIN+15 dwmblocks
fi

if [[ "$keyboard" == "ara" ]]; then
    setxkbmap fr
    pkill -RTMIN+15 dwmblocks
fi
