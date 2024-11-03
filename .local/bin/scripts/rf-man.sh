#!/bin/bash

# Debuging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables

# Start of Code
man -k . | awk '{$3="-"; print $0}' | $rfdmdpy 'Search man pages:' | awk '{print $2, $1}' | tr -d '()' | xargs alacritty -e man

# End of Code
