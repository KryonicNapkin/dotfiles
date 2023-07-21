#!/bin/bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables

# Start of Code
win="$(lsw | sort | $dmdpy "Window list:" "$@" | cut -d ' ' -f 1)"
[ "$win" ] && wmctrl -ia "$win" &

# End of Code
