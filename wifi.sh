#!/usr/bin/env bash

main () {
    device=$(nmcli device wifi list |
        sed -n '1!p' |
        dmenu -p 'Connect to wifi 🌍: ') || exit 1;

    if [ "$device" ]; then
        wifiName=$(echo "$device" | awk '{print $1}')
        wifiPass=$(dmenu -p 'Enter password:')

        nmcli device wifi connect "$wifiName" password "$wifiPass"
    else
        exit 0;
    fi
}


main "$@"
