#!/bin/bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Varialbes
# List of all WM session files
wm_list=$(ls /usr/share/xsessions/ | grep ".desktop$" | sed 's/\.desktop//')
# Menu of avaible options
option=$(printf "%s\n" "$wm_list" | $rfdmdpy "Choose Window Manager:")

# Start of Code
# Create a symbolic link to the chosen WM's .xinitrc file
case "$option" in
awesome)
    ln -sf $scriptd/prep_a.sh $scriptd/prep.sh
    notify-send -t 3000 "WM changed" "You changed the window manager you want to login nextime to Awesome"
    ;;
dwm)
    ln -sf $scriptd/prep_d.sh $scriptd/prep.sh
    notify-send -t 3000 "WM changed" "You changed the window manager you want to login nextime to Dwm"
    ;;
qtile)
    ln -sf $scriptd/prep_q.sh $scriptd/prep.sh
    notify-send -t 3000 "WM changed" "You changed the window manager you want to login nextime to Qtile"
    ;;
*)
    echo "Invalid option $1"
    exit 1
    ;;
esac

# End of Code
