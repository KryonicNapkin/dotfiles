#!/bin/bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables
win="$(wmctrl -l | sort | $rfdmdpy "$@" | cut -d ' ' -f 1)"

# Start of Code
[ "$win" ] && wmctrl -ia "$win" &

# End of Code
