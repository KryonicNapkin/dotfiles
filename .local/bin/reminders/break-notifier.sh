#!/bin/sh

set -xe
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep "dwm|awesome|qtile")/environ | cut -d= -f2-)
dunstify -t 20000 -u normal "Break time" "20-20-20 rule!\n"
