#!/bin/bash

# Debuging
set -xe

# Imports

# Variables

# Start of Code
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep "dwm|awesome|qtile")/environ | cut -d= -f2-)
dunstify -u normal -t 3000 "WPM test" "Don't forget to test your wpm score using '~$ wpm'"

# End of Code
