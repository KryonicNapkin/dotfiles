#!/bin/bash

# Importing universal variables declaration file
. /home/oizero/.local/share/univ/vars

# startup apps
/home/oizero/.config/feh/fehbg &
picom --no-fading-openclose &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
wired &
nm-applet &
pkill clipmenud
clipmenud &
discord --start-minimized &
exec qtile start
