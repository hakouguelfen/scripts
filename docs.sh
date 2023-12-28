#!/usr/bin/env bash

main () {
    docsDir="$HOME/Documents"

    bookDir=$(find "${docsDir}" -iname "*.pdf" |
        awk -F $HOME'/Documents/' '{print $(NF-1)"/"$NF}' |
        sort -u |
        uniq |
        fuzzel -d -i -p 'Select a document to read:')

    if [ "$bookDir" ]; then
        bookName=$(awk -F '/' '{print $NF}' <<< "$bookDir")
        book=$(find "${docsDir}" -iname "${bookName}")

        zathura "${book}"
    fi
}


main "$@"
