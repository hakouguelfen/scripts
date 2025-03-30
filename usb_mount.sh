#!/usr/bin/env bash

main() {
    lsblkoutput="$(lsblk -rpo "uuid,name,type,size,label,mountpoint,fstype")"
    allluks="$(echo "$lsblkoutput" | grep crypto_LUKS)" || true
    decrypted="$(find /dev/disk/by-id/dm-uuid-CRYPT-LUKS2-* | sed "s|.*LUKS2-||;s|-.*||")"

    echo "$allluks"

    filter() { sed "s/ /:/g" | awk -F':' '$7==""{printf "%s%s (%s) %s\n",$1,$3,$5,$6}' ; }
    unopenedluks="$(for drive in $allluks; do
        uuid="${drive%% *}"
        uuid="${uuid//-}"	# This is a bashism.
        [ -n "$decrypted" ] && for open in $decrypted; do
            [ "$uuid" = "$open" ] && break 1
        done && continue 1
        echo "🔒 $drive"
    done | filter)"
    echo "$unopenedluks"

}

main "$@"
