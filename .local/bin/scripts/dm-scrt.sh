#!/bin/bash

# Debugging
set -xe

# Imports
. ~/.local/share/univ/vars

# Variables
dir="$HOME/Pictures/Screenshots"
file=""
xclip="xclip -selection clipboard -t image/png"
choice=$(echo -e "Area\nCurrent window\nDesktop\n" | $dmdpy "Capture:")

send_notif_file() {
	notify-send "Screenshot taken" "Saved at '$1/$2'" --urgency=normal
}

send_notif() {
	notify-send "Screenshot taken" "Copied to clipboard" --urgency=normal
}

# Start of Code
case ${choice[@]} in
"Area")
    file+="$(:| $dmdpy "Enter filename:").png"
    maim -s "$dir"/"$file" && send_notif_file "$dir" "$file" 
    ;;
"Current window") 
    file+="$(:| $dmdpy "Enter filename:").png"
    maim -q -i "$(xdotool getactivewindow)" "$dir"/"$file" && send_notif_file "$dir" "$file" 
    ;;
"Desktop") 
    file+="$(:| $dmdpy "Enter filename:").png"
    maim -u "$dir"/"$file" && send_notif_file "$dir" "$file" 
    ;;
esac

# End of Code
