#!/usr/bin/env bash

lines="-l 20 -h 35"
font="-fn FiraCode"
colors="-nb #282c34 -nf #9899a0 -sb #F28FAD -sf #2C323E"

# DMENU="rofi -dmenu"
DMENU="dmenu"

main () {
    declare -A links
    links[google]="https://startpage.com/search?q="
    links[youtube]="https://youtube.com/results?search_query="

    platform=$(printf "%s\n" "google" "youtube" |
                   ${DMENU} -i -p 'Chooose a platfrom to search 🌍 :' \
                   ${lines} ${colors} ${font})

    if [ "$platform" ]; then
        query=$(printf "" |
                    ${DMENU} -i -p 'Enter your search :' \
                    ${lines} ${colors} ${font})

        [ "$query" ] &&
            xdg-open "${links[$platform]} ${query}" |
            sed "s/ //"
    fi
}

main "$@"
