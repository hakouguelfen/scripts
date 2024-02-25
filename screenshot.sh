#!/usr/bin/env bash

picsDir=/home/hakou/Pictures/"$(date +'%s.png')"
choice="$(printf "%s\n" "fullscreen" "region" | fuzzel -d -i -p "Take your screenshot as: ")"

case "$choice" in
    fullscreen) grim -o eDP-1 "$picsDir" && notify-send "ScreenShot taken" ;;
    region) grim -g "$(slurp -c)" "$picsDir" && notify-send "ScreenShot taken" ;;
esac
