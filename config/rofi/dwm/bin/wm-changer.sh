#!/bin/bash

xinitrc_file="$HOME/.xinitrc"

# Get a list of all WM session files in the directory
wm_list=$(ls /usr/share/xsessions/ | grep ".desktop$" | sed 's/\.desktop//')

# Use rofi to display a menu of WM options
option=$(printf "%s\n" "$wm_list" | rofi -dmenu -p "Choose a Window Manager" -theme ~/.config/rofi/configs/wm_changer.rasi)

# Create a symbolic link to the chosen WM's .xinitrc file
case "$option" in
    awesome)
        ln -sf "$HOME/.xinitrc_a" $xinitrc_file
        notify-send -t 3000 "X WM changed" "You changed the window manager you want to login nextime to Awesome"
        export NWM='awesome'
        ;;
    dwm)
        ln -sf "$HOME/.xinitrc_d" $xinitrc_file
        notify-send -t 3000 "X WM changed" "You changed the window manager you want to login nextime to Dwm"
        export NWM='dwm'
        ;;
    qtile)
        ln -sf "$HOME/.xinitrc_q" $xinitrc_file
        notify-send -t 3000 "X WM changed" "You changed the window manager you want to login nextime to Qtile"
        export NWM='qtile'
        ;;
    *)
        echo "Invalid option $1"
        exit 1
        ;;
esac

NWMCHECK="$(echo $NWM)"
if [[ $NWMCHECK == "awesome" ]]; then
    ln -sf ~/.local/bin/prep_a.sh ~/.local/bin/prep.sh
elif [[ $NWMCHECK == "dwm" ]]; then
    ln -sf ~/.local/bin/prep_d.sh ~/.local/bin/prep.sh
else
    ln -sf ~/.local/bin/prep_q.sh ~/.local/bin/prep.sh
fi
