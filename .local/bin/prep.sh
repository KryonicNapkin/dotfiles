#!/usr/bin/env bash

~/.fehbg &
picom --no-fading-openclose &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
wired &
nm-applet &
blueman-applet &
pkill clipmenud
clipmenud &
# kdeconnect-indicator &
# kdeconnectd &
thunderbird &
discord --start-minimized &
exec qtile start 
