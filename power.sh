#!/usr/bin/env sh

actions=(Suspend Restart Shutdown)
selected=$(printf "%s\n" "${actions[@]}" | dmenu -i -p 'Options: ')

if [ "$selected" ]; then
    case $selected in
        Suspend) systemctl suspend;;
        Restart) systemctl reboot;;
        Shutdown) shutdown now;;
    esac
fi
