#!/bin/bash

# Debuging
# set -xe

# Imports

# Variables
. ~/.local/share/univ/vars

# Start of Code
$rfdpy -show run -run-shell-command '{terminal} -e zsh -ic "{cmd} && {read}"'

# End of code
