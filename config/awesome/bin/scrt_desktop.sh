#!/bin/bash
#set -xe

time=$(date +%Y-%m-%d-%H-%M-%S)
geometry=$(xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current')
dir="/home/oizero/Screenshots"
file="Screenshot_${time}_${geometry}.png"

notify() {
    notify_cmd_shot='dunstify -u low --replace=699'
    ${notify_cmd_shot} "Copied to clipboard."
    viewnior ${dir}/"$file"
    if [[ -e "$dir/$file" ]]; then
        ${notify_cmd_shot} "Screenshot Saved."
    else
        ${notify_cmd_shot} "Screenshot Deleted."
    fi
}

copy_shot() {
    tee "$file" | xclip -selection clipboard -t image/png
}

shotnow() {
    cd ${dir} && maim -u -f png | copy_shot
    notify
}

shotnow
