#!/bin/bash

# List all installed packages
packages=$(paru -Qq)

# Use Rofi to display the package list and get the selected package
selected_package=$(echo "$packages" | rofi -dmenu -i -p "Select Package" -theme $HOME/.config/rofi/configs/pkginfo.rasi > /tmp/rofi-choice.txt)

if [ -s "/tmp/rofi-choice.txt" ]; then
    package_info=$(paru -Qi "$(cat /tmp/rofi-choice.txt)")
    echo "$package_info" | notify-send -t 100000 "$selected_package Info" "$package_info"
else
    notify-send -t 3000 -u normal "No package selected" "Exiting..."
    exit 1
fi
