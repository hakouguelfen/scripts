#!/usr/bin/env bash

main () {
    docsDir="$HOME/Documents"
    bookDir=$(find "${docsDir}" -iname "*.pdf" |
        awk -F '/' '{print $(NF-1)"/"$NF}' |
        sort -u |
        uniq |
        dmenu -i -p 'Select a document to read:')

    if [ "$bookDir" ]; then
        bookName=$(awk -F '/' '{print $NF}' <<< "$bookDir")

        book=$(awk -F'/' '{print $NF}' | find "${docsDir}" -iname "${bookName}")
        zathura "${book}"
    fi
}


main "$@"
