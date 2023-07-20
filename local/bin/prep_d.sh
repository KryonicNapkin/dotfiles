#!/bin/sh

# Importing universal variables declaration file
. /home/oizero/.local/share/univ/vars

# link alacritty
ln -sf $alattyd/alacritty_d.yml $alattyd/alacritty.yml

# link dunst
ln -sf $dunstd/dunstrc_d $dunstd/dunstrc

# link picom
ln -sf $picomd/picom_d.conf $picomd/picom.conf

# link feh
ln -sf $fehbgd/fehbg_d $fehbgd/fehbg

# End of linking
# startup apps
/home/oizero/.config/feh/fehbg &
picom --no-fading-openclose --backend glx &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setxkbmap -option "grp:alt_space_toggle" -layout "us,sk" &
dunst &
slbar &
nm-applet &
pkill clipmenud
clipmenud &
discord --start-minimized &
exec dwm
