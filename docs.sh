#!/usr/bin/env bash

# dmenu theming
bg="#282c34"
fg="#d9e0ee"
container="#d9e0ee"

lines="-l 20 -h 35"
font="-fn FiraCode"
colors="-nb $bg -nf $fg -sb $container -sf $bg"

# DMENU="rofi -dmenu"
DMENU="dmenu"

docsDir="$HOME/Documents"

main () {
    bookDir=$(find "${docsDir}" -iname "*.pdf" |
        awk -F '/' '{print $(NF-1)"/"$NF}' |
        sort -u |
        uniq |
        ${DMENU} -i -p 'Select a document to read:' ${lines} ${colors} ${font})

    if [ "$bookDir" ]; then
        bookName=$(awk -F '/' '{print $NF}' <<< "$bookDir")

        book=$(awk -F'/' '{print $NF}' | find "${docsDir}" -iname "${bookName}")
        zathura "${book}"
    fi
}


main "$@"
