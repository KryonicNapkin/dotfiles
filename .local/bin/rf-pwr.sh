#!/bin/bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables
# Options
options=$(printf "Shutdown\\nReboot\\nLock\\nSuspend\\nLogout\\n" | sort | $rfdmdpy "Action:")

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
