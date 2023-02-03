#!/usr/bin/env bash

# dmenu theming
bg="#282c34"
fg="#d9e0ee"
container="#d9e0ee"

lines="-l 20 -h 35"
font="-fn FiraCode"
colors="-nb $bg -nf $fg -sb $container -sf $bg"

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
