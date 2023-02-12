#!/usr/bin/env bash

main () {
    wikiDir="/usr/share/doc/arch-wiki/html/en/"
    wikiDocs="$(find ${wikiDir} -iname "*.html")"

    wiki=$(printf "%s\n" "${wikiDocs}" |
               awk -F "/" '{print $NF}' |
               sed "s/.html//g" |
               sort |
               dmenu -i -p 'ArchWiki: ') || exit 1;


    if [ "$wiki" ]; then
        article=$(printf "%s\n" "${wikiDir}${wiki}.html")
        xdg-open "$article"
    else
        echo "byebye" && exit 0;
    fi
}

main "$@"
