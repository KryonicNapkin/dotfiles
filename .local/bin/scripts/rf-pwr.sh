#!/bin/bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars
shutdown='  Shutdown'
reboot='  Reboot'
lock='  Lock'
suspend='  Suspend'
logout='  Logout'

rofi_cmd() {
    rofi -no-show-icons -i -dmenu -p 'Action:'
}
# Variables
# Options
options=$(printf "  Shutdown\\n  Reboot\\n  Lock\\n  Suspend\\n  Logout\\n" | sort | rofi_cmd)

# Start of Code
case "$options" in
"Shutdown")
    systemctl poweroff
    ;;
"Reboot")
    systemctl reboot
    ;;
"Lock")
    betterlockscreen -l
    ;;
"Suspend")
    systemctl suspend
    ;;
"Logout")
    loginctl terminate-session ${XDG_SESSION_ID-}
    ;;
*)
    echo "Invalid option"
    ;;
esac

# End of Code
