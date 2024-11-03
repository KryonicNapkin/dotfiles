#!/usr/bin/env bash
#
# set -xe
#
dir="$HOME/Programming/Arduino"

port=$(echo $AVR_PORT)
fqbn=$(echo $AVR_FQBN)

options=$(ls $dir | tr -d ' ')
sketch=$(printf "${options}\\n" | sort | dmenu -p "Select sketch to upload: ")

cmp_cmd="arduino-cli compile --fqbn $fqbn $dir/$sketch/$sketch.ino"
run_cmd="arduino-cli upload -p $port -b $fqbn $dir/$sketch"

if [[ -n "$1" && "$1" == "--debug" ]]; then
    $cmp_cmd &> "$dir"/"$sketch"/debug-compile.txt
    $run_cmd &> "$dir"/"$sketch"/debug-upload.txt
else 
    $cmp_cmd &> /dev/null
    $run_cmd &> /dev/null
fi
