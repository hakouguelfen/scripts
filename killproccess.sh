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
