#!/usr/bin/env bash
# set -xe

# This function install yay for you if you do not have it 

abort() {
  echo "######################"
  echo "#    Aboriding...    #"
  echo "######################"
  exit 1
}

yay_install() {
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin && makepkg -sci
  echo -e "########"
  echo -e "# DONE #"
  echo -e "########\n"
  YayInstall
}

paru_install() {
  git clone https://aur.archlinux.org/paru.git
  cd paru && makepkg -sci
  echo -e "########"
  echo -e "# DONE #"
  echo -e "########\n"
  Install
}

ParuInstall() {
  paru -S --needed - < $HOME/My-dotfiles/Bin/pkglist.txt
}

YayInstall() {
  yay -S --needed - < $HOME/My-dotfiles/Bin/pkglist.txt
}

# This function run an if loop to check if you have installed 
# paru and if not it run "Paruinstlall" function to install paru
# When installing paru is done it run "Install" function described 
# earlier in this file 

read -p "What aur helper you want to install the packages with \
(p for paru y for yay (paru's installation is long)): " aurhelper
case $aurhelper in 
  y ) yay_install;;
  p ) paru_install;;
  * ) abort;;
esac

# End of script
