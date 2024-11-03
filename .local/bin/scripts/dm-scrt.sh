#!/bin/bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables
dir="$HOME/Pictures/Screenshots"
file="$(:| dmenu -p "Enter filename:").png"
xclip="xclip -selection clipboard -t image/png"

send_notif_file() {
	notify-send "Screenshot taken" "Saved at '$1/$2'" --urgency=normal
}

send_notif() {
	notify-send "Screenshot taken" "Copied to clipboard" --urgency=normal
}

# Start of Code
case "$(printf "Area\\nCurrent window\\nDesktop\\nArea(file)\\nCurrent window(file)\\nDesktop(file)\\n" | sort | $dmdpy "Capture:")" in
"Area(file)") maim -s "$dir"/"(Area)$file" && send_notif_file "$dir" "$file" ;;
"Current window(file)") maim -q -i "$(xdotool getactivewindow)" "$dir"/"(Window)$file" && send_notif_file "$dir" "$file" ;;
"Desktop(file)") maim -u "$dir"/"(Desktop)$file" && send_notif_file "$dir" "$file" ;;
"Area") maim -s | ${xclip} && send_notif ;;
"Current window") maim -q -i "$(xdotool getactivewindow)" | ${xclip} && send_notif ;;
"Desktop") maim -u | ${xclip} && send_notif ;;
esac

# End of Code
