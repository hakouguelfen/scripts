#!/usr/bin/env zsh


main () {
    picsDir=/home/hakou/Pictures/"$(date +'%s.png')"

    choice="$(printf "%s\n" "fullscreen" "region" | fuzzel -d -i -p "Take your screenshot as: ")"

    if [[ "$choice" == "fullscreen" ]]; then
        grim -o eDP-1 "$picsDir"
        notify-send "ScreenShot taken"
    fi

    if [[ "$choice" == "region" ]]; then
        grim -g "$(slurp)" "$picsDir"
        notify-send "ScreenShot taken"
    fi
}


main "$@"
