#!/usr/bin/env bash
set -xe

if [ "$(which paru)" = "/usr/bin/paru" ]; then
  $(paru -S --needed - < pkglist.txt)
else
  $(git clone https://aur.archlinux.org/paru.git)
  $(cd paru && makepkg -sci)
  $(echo -e "DONE")
fi
