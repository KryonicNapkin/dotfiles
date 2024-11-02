#!/usr/bin/env bash

# Set monitor color warmness
redshift -P -O 3800k &
# Set cursor theme and dpi
xrdb -merge ~/.Xresources &
# Actual autostart programs and window manager itself
~/.local/bin/prep.sh
