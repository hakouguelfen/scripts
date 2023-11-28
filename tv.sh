#!/usr/bin/env bash

main () {
    vidoesDir="$HOME/Vidoes"

    dunst "$vidoesDir"
    tvShowDir=$(ls "${vidoesDir}" |
        sort -u |
        wofi -i -p 'Select what you want to watch:')

    tvShow=$(find "$vidoesDir"/"$tvShowDir" -regex '.*\.\(mp4\|mpv\)')
    subtitle=$(find "$vidoesDir"/"$tvShowDir" -regex '.*\.\(srt\|ass\)')

    [[ -z "$subtitle" ]] && notify-send "No subtitle found" && mpv "$tvShow"

    [[ "$subtitle" && "$tvShow" ]] && mpv --sub-files="$subtitle" "$tvShow"
}


main "$@"
