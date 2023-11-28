#!/usr/bin/env bash

dmenu_path=".local/bin/dmenu/dmenu"

main () {
    github="https://github.com/hakouklvn/"
    repos=$(gh repo list |
                awk '{
                        if ($(NF-1) == "fork") printf("%-30s %-20s\n", $1, $(NF-2))
                        else printf("%-30s %-20s\n", $1, $(NF-1))
                    }' |
                sed 's/hakouklvn\///' |
                sed 's/,//' |
                sort
         )

    repo=$(printf "%s\n" "${repos}" | wofi -i -p 'Github repositories: ') || exit 1;
    link=$(awk '{print $1}' <<< "${github}${repo}")

    [ "$repo" ] && xdg-open "$link"
}


main "$@"
