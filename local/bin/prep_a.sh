#!/bin/bash

# Variables
CONFDIR=$HOME/.config

# link alacritty
ln -sf $CONFDIR/alacritty/alacritty_a.yml $CONFDIR/alacritty/alacritty.yml

# link dunst
ln -sf $CONFDIR/dunst/dunstrc_a $CONFDIR/dunst/dunstrc

# link picom
ln -sf $CONFDIR/picom/picom_a.conf $CONFDIR/picom/picom.conf

# link feh
ln -sf $CONFDIR/feh/fehbg_a $CONFDIR/feh/fehbg

# link rofi
ln -sf $CONFDIR/rofi/awesome/bin $CONFDIR/rofi
ln -sf $CONFDIR/rofi/awesome/configs $CONFDIR/rofi
ln -sf $CONFDIR/rofi/awesome/colors $CONFDIR/rofi

# End of linking
#
# startup apps
/home/oizero/.config/feh/fehbg &
picom --no-fading-openclose --backend glx &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setxkbmap -option "grp:alt_space_toggle" -layout "us,sk" &
dunst &
nm-applet &
discord --start-minimized &
source ~/.zshrc &
