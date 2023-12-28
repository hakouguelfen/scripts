#!/usr/bin/env bash

main () {
    vidoesDir="$HOME/Videos"

    dunst "$vidoesDir"
    tvShowDir=$(ls "${vidoesDir}" |
        sort -u |
        fuzzel -d -i -p 'Select what you want to watch:')

    tvShow=$(find "$vidoesDir"/"$tvShowDir" -regex '.*\.\(mp4\|mpv\|mkv\)')
    subtitle=$(find "$vidoesDir"/"$tvShowDir" -regex '.*\.\(srt\|ass\)')

    [[ -z "$subtitle" ]] &&  mpv "$tvShow"

    [[ "$subtitle" && "$tvShow" ]] && mpv --sub-files="$subtitle" "$tvShow"
}


main "$@"
