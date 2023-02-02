#!/usr/bin/env bash

lines="-l 20 -h 30 "
font="-fn FiraCode"
colors="-nb #282c34 -nf #9899a0 -sb #F28FAD -sf #2C323E"

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
