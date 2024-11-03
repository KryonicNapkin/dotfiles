#!/bin/bash
# Script for getting volume
# set -xe

vol=$(pamixer --get-volume)
muted=$(amixer get Master | grep -oE '[^ ]+$' | tail -n1 | tr -d '[]')

if [ $muted = "off" ]; then
    printf "VOL M%s\n" "$vol%"
else
    printf "VOL %s\n" "$vol%"
fi
