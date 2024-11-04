#!/usr/bin/env bash
# set -xe
#
# TODO :    1. Check for aur package manager 
#           2. Install the aur package manager of choice
#           3. Install all the necessary config files
#           4. Install GTK and Qt themes
#           5. Set up default services (i.e. cups, ufw and others)
# Script for the installation of my configuration 

# 1. Check for aur package manager 
yaych=$(which yay; echo $?)
paruch=$(which paru; echo $?)
netcheck=$(ping 8.8.8.8; echo $?)

yayinstall() {
    if [[ $(which git; echo $?) -ne 0 ]]; then
        echo "git is not installed"
        echo "This install script is going to install it for you"
        echo "Installing git..."
        pacman -Syu git
        echo "Done";
    else
        cd ~ && git clone https://aur.archlinux.org/yay-bin.git
        cd yay-bin 
        echo "Installing yay..";
        makepkg -sci 
        echo "Done";
    fi
}
paruinstall() {
    if [[ $(which git; echo $?) -ne 0 ]]; then
        echo "git is not installed"
        echo "This install script is going to install it for you"
        echo "Installing git..."
        pacman -Syu git
        echo "Done";
    else
        cd ~ && git clone https://aur.archlinux.org/paru-bin.git
        cd paru-bin 
        echo "Installing paru..";
        makepkg -sci 
        echo "Done";
    fi
}
echo "Type the whole word out"
read -p "Choose an AUR package manager (paru or yay):" aurmngr
if [[ $aurmngr == "yay" && $yaych -ne 0 && $netcheck -e 0 ]]; then
    yayinstall;
elif [[ $aurmngr == "paru" && $paruch -ne 0 && $netcheck -e 0 ]]; then
    paruinstall;
elif [[ $netcheck -ne 0 ]]; then
    echo "To run this script you must be connected to internet"
    return 1;
elif [[ $aurmngr != "paru" && $aurmngr != "yay" ]]; then
else 
    echo "You have already installed AUR package manager"
    echo "Continuing..."
fi
