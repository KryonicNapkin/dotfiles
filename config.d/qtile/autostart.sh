#!/bin/bash

picom --no-fading-openclose --backend glx --config ~/.config/qtile/picom.conf &
/home/thinker/.fehbg &
xfce4-power-manager &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
dunst &
discrod --start-minimized &
thunderbird &
artha &
