#!/bin/sh

# Disable unused monitor
xrandr --output VGA-0 --off
# Set monitor color intenstity
redshift -P -O 3600k &
# Set cursor theme
xrdb ~/.Xresources &
# Actual autostart programs and window manager itself
/home/oizero/.local/bin/prep.sh
