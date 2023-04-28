#!/bin/bash

# Variables
DOTDIR=$HOME/dotfiles/
netcheck=$(/home/oizero/.local/bin/net-checker.sh)

check() {
	paru -Qqe > $DOTDIR/Bin/pkglist.txt
	cd $DOTDIR
	git add -u Bin/pkglist.txt
	git commit -m "Added the latest fetch of packages"
	git push
}

if [ $netcheck = 64 ]; then
	check
else
	dunstify "Error connecting to internet" -u critical
fi
