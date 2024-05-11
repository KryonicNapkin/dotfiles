#!/bin/bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables
seq_output=$(seq -w 1 7999)
prefixed_output=$(echo "$seq_output" | awk '{printf "SCP-%03d\n", $1}')
choice=$(echo "$prefixed_output" | $rfdmdpy "SCP:")
choice2=$(echo "$choice" | sed -e 's/SCP-//g')

# Start of Code
case "$choice" in
"${choice[@]}")
    $BROWSER https://scp-wiki.wikidot.com/scp-"${choice2}"
    ;;
*)
    echo default
    ;;
esac

# End of Code
