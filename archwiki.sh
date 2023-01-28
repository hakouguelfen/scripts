#!/usr/bin/env bash

lines="-l 20 -h 30 "
font="-fn FiraCode"
colors="-nb #282c34 -nf #9899a0 -sb #F28FAD -sf #2C323E"
DMENU="dmenu"

wikiDir="/usr/share/doc/arch-wiki/html/en/"
wikiDocs="$(find ${wikiDir} -iname "*.html")"


main () {
    wiki=$(printf "%s\n" "${wikiDocs}" |
               awk -F "/" '{print $NF}' |
               sed "s/.html//g" |
               sort |
               ${DMENU} -i -p 'ArchWiki: ' ${lines} ${colors} ${font}) || exit 1;


    if [ "$wiki" ]; then
        article=$(printf "%s\n" "${wikiDir}${wiki}.html")
        xdg-open "$article"
    else
        echo "byebye" && exit 0;
    fi
}

main "$@"
