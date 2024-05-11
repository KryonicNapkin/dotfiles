#!/bin/sh
# Audio script for slbar

vol=$(pamixer --get-volume)
muted=$(amixer get Master | grep -oE '[^ ]+$' | tail -n1 | tr -d '[]')

if [ $muted = "off" ]; then
    printf "%s%s%s\n" "VOL " "M" "$vol%"
else
    printf "%s%s\n" "VOL " "$vol%"
fi
