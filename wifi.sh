#!/usr/bin/env bash

lines="-l 20 -h 30 "
font="-fn FiraCode"
colors="-nb #282c34 -nf #9899a0 -sb #F28FAD -sf #2C323E"
DMENU="dmenu"

main () {
    device=$(nmcli device wifi list |
        sed -n '1!p' |
        ${DMENU} -i -p 'Connect to wifi 🌍:' ${lines} ${colors} ${font}) || exit 1;

    if [ "$device" ]; then
        wifiName=$(echo "$device" | awk '{print $1}')
        wifiPass=$(${DMENU} -i -p 'Enter password:' ${colors} ${font})

        nmcli device wifi connect "$wifiName" password "$wifiPass"
    else
        exit 0;
    fi
}


main "$@"
