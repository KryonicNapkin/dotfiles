#!/bin/bash

# Variables
CONFDIR=$HOME/.config

# link alacritty
ln -sf $CONFDIR/alacritty/alacritty_q.yml $CONFDIR/alacritty/alacritty.yml

# link dunst
ln -sf $CONFDIR/dunst/dunstrc_q $CONFDIR/dunst/dunstrc

# link picom
ln -sf $CONFDIR/picom/picom_q.conf $CONFDIR/picom/picom.conf

# link feh
ln -sf $CONFDIR/feh/fehbg_q $CONFDIR/feh/fehbg

# link rofi
ln -sf $CONFDIR/rofi/qtile/bin $CONFDIR/rofi
ln -sf $CONFDIR/rofi/qtile/configs $CONFDIR/rofi
ln -sf $CONFDIR/rofi/qtile/colors $CONFDIR/rofi

# End of linking
#
# startup apps
/home/oizero/.config/feh/fehbg &
picom --no-fading-openclose --backend glx &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
dunst &
nm-applet &
thunderbird &
discord --start-minimized &
source ~/.zshrc &
