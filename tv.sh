#!/usr/bin/env bash

main() {
    moviesDir="$HOME/Videos/movies"

    moviePath=$(find "${moviesDir}" -type d -not -path "${moviesDir}"|
        sort -u |
        dmenu -p 'Select what you want to watch:')

    video=$(find "$moviePath" -regex '.*\.\(mp4\|mpv\|mkv\)')
    subtitle=$(find "$moviePath" -regex '.*\.\(srt\|ass\)')

    [[ -z "$subtitle" ]] && mpv "$video" && exit
    [[ "$subtitle" && "$video" ]] && mpv --sub-files="$subtitle" "$video" && exit
}

main "$@"
