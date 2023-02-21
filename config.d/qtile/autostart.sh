#!/bin/bash

picom --no-fading-openclose --backend glx --config ~/.config/picom/picom.conf &
/home/oizero/.fehbg_qtile &
mate-power-manager &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
dunst &
discord --start-minimized &
thunderbird &
