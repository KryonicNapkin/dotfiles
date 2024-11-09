#!/usr/bin/env bash

# Variables
$dotdir="$HOME/.dotfiles"
netcheck=$(ping 8.8.8.8; echo $?)

check() {
    pacman -Qqen > $dotdir/.pkgs
    pacman -Qqem > $dotdir/.pkgs_aur
    cd $dotdir
    git add -u .pkgs
    git add -u .pkgs_aur
    git commit -m "Latest fetch of packages"
    git push
}

if [ $netcheck -ne 1 ]; then
    check
else
    echo "Error: Could not connect to the internet"
fi
