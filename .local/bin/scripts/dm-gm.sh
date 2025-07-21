#!/usr/bin/env bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables
# Options
options=$(printf "Reset\\nLevel 1\\nLevel 2\\n" | sort | $dmdpy "Choose a level:")

# Start of Code
case "$options" in
"Reset")
    $scriptd/scripts/misc/gamemode -l0
    ;;
"Level 1")
    $scriptd/scripts/misc/gamemode -l1
    ;;
"Level 2")
    $scriptd/scripts/misc/gamemode -l2
    ;;
*)
    echo "Invalid option"
    ;;
esac

# End of Code

