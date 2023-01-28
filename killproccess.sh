#!/usr/bin/env bash

# dmenu theming
lines="-l 20 -h 30 "
font="-fn FiraCode"
colors="-nb #2C323E -nf #9899a0 -sb #BF616A -sf #2C323E"

# DMENU="rofi -dmenu"
DMENU="dmenu"

main () {
    proccessName=$(ps -au "$USER" |
        awk '{print $4}' |
        sort -u |
        uniq |
        ${DMENU} -i -p 'Search and select process to kill:' ${lines} ${colors} ${font})

    if [ "$proccessName" ]; then
        pid=$(pgrep "$proccessName")

        for id in $pid
        do
            kill -9 "$id"
        done
    fi
}


main "$@"
