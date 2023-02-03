#!/usr/bin/env bash

# dmenu theming
bg="#282c34"
fg="#d9e0ee"
container="#d9e0ee"

lines="-l 20 -h 35"
font="-fn FiraCode"
colors="-nb $bg -nf $fg -sb $container -sf $bg"

DMENU="dmenu"

main () {
    device=$(nmcli device wifi list |
        sed -n '1!p' |
        ${DMENU} -i -p 'Connect to wifi 🌍:' ${lines} ${colors} ${font}) || exit 1;

    if [ "$device" ]; then
        wifiName=$(echo "$device" | awk '{print $1}')
        wifiPass=$(${DMENU} -i -p 'Enter password:' ${lines} ${colors} ${font})

        nmcli device wifi connect "$wifiName" password "$wifiPass"
    else
        exit 0;
    fi
}


main "$@"
