#!/bin/bash

# Variables
DOTDIR=$HOME/dotfiles/

check() {
	paru -Qqe > $DOTDIR/Bin/pkglist.txt
	cd $DOTDIR
	git add -u Bin/pkglist.txt
	git commit -m "Added the latest fetch of packages"
	git push
}

if [ "$(ping -w 1 8.8.8.8 | awk 'NR==2{print $1}')" = 64 ]; then
	check
else
	dunstify "Error connecting to internet" -u critical
fi
