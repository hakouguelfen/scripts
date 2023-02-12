#!/usr/bin/env bash

DMENU="dmenu"

main () {
    declare -A links
    links[google]="https://startpage.com/search?q="
    links[youtube]="https://youtube.com/results?search_query="
    links[github]="https://github.com/"

    platform=$(printf "%s\n" "google" "youtube" "github"|
                   ${DMENU} -i -p 'Chooose a platfrom to search 🌍 :')

    if [ "$platform" ]; then
        query=$(printf "" |
                    ${DMENU} -i -p 'Enter your search :')

        [ "$query" ] && xdg-open "${links[$platform]}${query}"
    fi
}

main "$@"
