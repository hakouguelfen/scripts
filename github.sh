#!/usr/bin/env bash

main () {
    github="https://github.com/hakouguelfen/"
    repos=$(gh repo list |
                awk '{
                        if ($(NF-1) == "fork") printf("%-30s %-20s\n", $1, $(NF-2))
                        else printf("%-30s %-20s\n", $1, $(NF-1))
                    }' |
                sed 's/hakouguelfen\///' |
                sed 's/,//' |
                sort
         )

    repo=$(printf "%s\n" "${repos}" | dmenu -p 'Github repositories: ') || exit 1;
    link=$(awk '{print $1}' <<< "${github}${repo}")

    [ "$repo" ] && xdg-open "$link"
}


main "$@"
