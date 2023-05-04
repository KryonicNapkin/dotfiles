#!/bin/sh

WINDOW=$(xprop -root | grep _NET_ACTIVE_WINDOW | head -1 | sed 's/.* //')
xprop -id $WINDOW | grep -v _NET_WM_ICON > /tmp/xprop-info.txt
notify-send -u normal -t 5000 "$(basename /tmp/xprop-info.txt)" "$(cat /tmp/xprop-info.txt)"
