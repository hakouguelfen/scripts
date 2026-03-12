#!/usr/bin/env bash

main() {
    # mac="41:42:FF:6B:99:EC"

    bluetoothctl power on >/dev/null
    bluetoothctl --timeout 8 scan on

    devices=$(bluetoothctl devices)
    [ -z "$devices" ] && exit 0

    choice=$(echo "$devices" | sed 's/^Device //' | sort -u | dmenu -p 'Select a device to connect to:')
    [ -z "$choice" ] && exit 0

    MAC=$(echo "$choice" | awk '{print $1}')
    
    bluetoothctl pair "$MAC"
    bluetoothctl trust "$MAC"
    bluetoothctl connect "$MAC"

    notify-send "Connected to $choice"
}

main "$@"
