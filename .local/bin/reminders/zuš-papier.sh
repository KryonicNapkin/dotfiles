#!/bin/bash

# Debuging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables

# Start of Code
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep dwm)/environ | cut -d= -f2-)
dunstify -u critical -t 10000 "Nezabudni!!" "Práca z výtvarnej. Pozri papiere, ktoré ti dal učiteľ!"

# End of Code
