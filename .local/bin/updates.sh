#!/bin/sh

UPDATES="$(checkupdates | wc -l)"
notify-send -t 3000 "UPDATES" "Number of updates: $UPDATES"
