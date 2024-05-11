#!/bin/bash

set -xe
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep "dwm|awesome|qtile")/environ | cut -d= -f2-)
dunstify -t 15000 -u normal "Hello" "This is test"
