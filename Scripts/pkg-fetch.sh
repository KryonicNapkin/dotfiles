#!/bin/bash

# Variables
DOTS=$HOME/My-dotfiles/

check() {
  paru -Qe | awk '{print $1}' > $DOTS/Bin/pkglist.txt
  cd $DOTS    
  git add -u Bin/pkglist.txt 
  git commit -m "Added the latest fetch of packages"
  git push git@github.com:coevoe/My-dotfiles.git 
}

if [ "$(ping -w 1 8.8.8.8 | awk '{print $1}' | head -n 2 | tail -n 1)" = 64 ]; then
  check
else
  dunstify "Error connecting to internet" -u critical
fi
