#!/usr/bin/env sh

# dmenu_path=".local/bin/dmenu/dmenu"

actions=(Suspend Restart Shutdown)
selected=$(printf "%s\n" "${actions[@]}" | dmenu -p 'Options: ')

if [ "$selected" ]; then
    case $selected in
        Suspend) systemctl suspend;;
        Restart) systemctl reboot;;
        Shutdown) shutdown now;;
    esac
fi
