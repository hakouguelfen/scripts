#!/usr/bin/env bash

main () {
    vidoesDir="$HOME/Videos/movies"

    tvShowDir=$(ls "${vidoesDir}" |
        sort -u |
        dmenu -p 'Select what you want to watch:')

    tvShow=$(find "$vidoesDir"/"$tvShowDir" -regex '.*\.\(mp4\|mpv\|mkv\)')
    subtitle=$(find "$vidoesDir"/"$tvShowDir" -regex '.*\.\(srt\|ass\)')

    [[ -z "$subtitle" ]] &&  mpv "$tvShow" && exit
    [[ "$subtitle" && "$tvShow" ]] && mpv --sub-files="$subtitle" "$tvShow" && exit
}


main "$@"
