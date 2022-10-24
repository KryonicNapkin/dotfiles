#!/bin/bash
set -xe

check() {
  paru -Qe | awk '{print $1}' > ~/My-dotfiles/Bin/pkglist.txt
  cd ~/My-dotfiles/    
  git add -u .
  git commit -m "Added the latest fetch of packages"
  git push git@github.com:coevoe/My-dotfiles.git 
}

if [ "$(ping -w 1 8.8.8.8 | awk '{print $1}' | head -n 2 | tail -n 1)" = 64 ]; then
  check
else
  echo "Error connecting to internet"
fi

rm ~/stdou_test.txt
rm ~/pkglist.txt
