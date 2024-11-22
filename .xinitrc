#!/usr/bin/env bash

# Set monitor color warmness
redshift -P -O 3800k &
# Set cursor theme and dpi
xrdb -merge ~/.Xresources &
# Browser file downloading fix
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi 
# Actual autostart programs and window manager itself
~/.local/bin/prep.sh
