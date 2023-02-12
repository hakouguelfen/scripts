#!/usr/bin/env bash

main () {
    proccessName=$(ps -au "$USER" |
        awk '{print $4}' |
        sort -u |
        uniq |
        dmenu -i -p 'Search and select process to kill:')

    if [ "$proccessName" ]; then
        pid=$(pgrep "$proccessName")

        for id in $pid
        do
            kill -9 "$id"
        done
    fi
}


main "$@"
