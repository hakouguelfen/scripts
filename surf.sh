#!/usr/bin/env bash

main () {
    declare -A links
    links[google]="https://startpage.com/search?q="
    links[youtube]="https://youtube.com/results?search_query="
    links[github]="https://github.com/"

    platform=$(printf "%s\n" "google" "youtube" "github"|
                   wofi -i -p 'Chooose a platfrom to search 🌍 :')

    if [ "$platform" ]; then
        query=$(printf "" |
                    wofi -i -p 'Enter your search :')

        [ "$query" ] && xdg-open "${links[$platform]}${query}"
    fi
}

main "$@"
