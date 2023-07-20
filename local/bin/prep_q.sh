#!/bin/sh

# Importing universal variables declaration file
. /home/oizero/.local/share/univ/vars

# link alacritty
ln -sf $alattyd/alacritty_q.yml $alattyd/alacritty.yml

# link dunst
ln -sf $dunstd/dunstrc_q $dunstd/dunstrc

# link picom
ln -sf $picomd/picom_q.conf $picomd/picom.conf

# link feh
ln -sf $fehbgd/fehbg_q $fehbgd/fehbg

# change color scheme of rofi
sed -i 's/onedark/dracula/g' $rofid/dmenu.rasi
sed -i 's/blue/magenta/g' $rofid/dmenu.rasi

# End of linking
# startup apps
/home/oizero/.config/feh/fehbg &
picom --no-fading-openclose --backend glx &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setxkbmap -option "grp:alt_space_toggle" -layout "us,sk" &
dunst &
nm-applet &
pkill clipmenud
clipmenud &
discord --start-minimized &
exec qtile start
