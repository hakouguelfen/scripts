#!/usr/bin/env bash

main () {
    docsDir="$HOME/Documents"

    bookDir=$(find "${docsDir}" -iname "*.pdf" -o -iname "*.docx" -o -iname "*.epub"|
        awk -F "$HOME"'/Documents/' '{print $(NF-1)"/"$NF}' |
        sort -u |
        uniq |
        dmenu -p 'Select a document to read: ')

    if [ "$bookDir" ]; then
        bookName=$(awk -F '/' '{print $NF}' <<< "$bookDir")
        book=$(find "${docsDir}" -iname "${bookName}")

        extension=$(echo "$bookName" | awk -F "." '{print $NF}' )

        [ "$extension" = "pdf" ] && zathura "${book}" && exit;
        [ "$extension" = "docx" ] && abiword "${book}" && exit;
        [ "$extension" = "epub" ] && foliate "${book}" && exit;
    fi
}


main "$@"
