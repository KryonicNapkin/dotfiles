#!/bin/sh

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables
dir="$HOME/Pictures/Screenshots"
file="Screenshot_$(date '+%d-%m-%Y_%H:%M:%S').png"
xclip="xclip -selection clipboard -t image/png"

# Start of Code
case "$(printf "Area\\nCurrent window\\nDesktop\\nArea(file)\\nCurrent window(file)\\nDesktop(file)\\n" | sort | $rfdmdpy "Capture:")" in
"Area(file)") maim -s "$dir"/"(Area)$file" ;;
"Current window(file)") maim -q -i "$(xdotool getactivewindow)" "$dir"/"(Window)$file" ;;
"Desktop(file)") maim -u "$dir"/"(Desktop)$file" ;;
"Area") maim -s | ${xclip} ;;
"Current window") maim -q -i "$(xdotool getactivewindow)" | ${xclip} ;;
"Desktop") maim -u | ${xclip} ;;
esac

# End of Code
