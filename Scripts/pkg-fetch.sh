#!/bin/bash
set -xe

if [ "$(ping -w 1 8.8.8.8 | awk '{print $1}' | head -n 2 | tail -n 1)" = 64 ]; then
  paru -Qe | awk '{print $1}' > ../Bin/pkglist.txt
  cd ..
  git add -u .
  git commit -m "Added the latest fetch of packages"
  git push git@github.com:coevoe/My-dotfiles.git 
else
  echo "Error connecting to internet"
fi
