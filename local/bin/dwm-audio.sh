#!/bin/bash
# Audio script for slbar

vol=$(pamixer --get-volume)
muted=$(amixer get Master | grep -oE '[^ ]+$' | tail -n1 | tr -d '[]')

if [ $muted == "off" ]; then
    printf "%s%s" "M" "$vol%"
else 
    printf "%s" "$vol%"
fi

