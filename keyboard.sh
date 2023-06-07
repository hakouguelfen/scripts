#!/usr/bin/env bash

keyboard=$(setxkbmap -query | grep "layout" | awk '{print $NF}')

if [[ "$keyboard" == "fr" ]]; then
    setxkbmap ara
fi

if [[ "$keyboard" == "ara" ]]; then
    setxkbmap fr
fi
