#!/usr/bin/env bash


bg="#282c34"
fg="#d9e0ee"
container="#d9e0ee"

lines="-l 20 -h 35"
font="-fn FiraCode"
colors="-nb $bg -nf $fg -sb $container -sf $bg"

# DMENU="rofi -dmenu"
DMENU="dmenu"

main () {
    declare -A links
    links[google]="https://startpage.com/search?q="
    links[youtube]="https://youtube.com/results?search_query="
    links[github]="https://github.com/"

    platform=$(printf "%s\n" "google" "youtube" "github"|
                   ${DMENU} -i -p 'Chooose a platfrom to search 🌍 :' \
                   ${lines} ${colors} ${font})

    if [ "$platform" ]; then
        query=$(printf "" |
                    ${DMENU} -i -p 'Enter your search :' \
                    ${lines} ${colors} ${font})

        [ "$query" ] && xdg-open "${links[$platform]}${query}"
    fi
}

main "$@"
