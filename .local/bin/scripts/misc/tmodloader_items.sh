#!/usr/bin/env bash
set -xe
filename="wanted_items.txt"
path="/home/oizero/Games/tModLoader"
alacritty -e nvim "$path"/"$filename"
