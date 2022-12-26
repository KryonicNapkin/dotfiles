#!/bin/sh

xrandr --output VGA-0 --off
redshift -P -O 3600k &
xrdb ~/.Xresources &
source ~/.zshrc
exec awesome
