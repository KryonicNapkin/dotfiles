#!/usr/bin/env bash
set -xe

# This function install paru for you if you do not have it 

Paruinstlall() {
  git clone https://aur.archlinux.org/paru.git
  cd paru && makepkg -sci
  echo -e "########"
  echo -e "# DONE #"
  echo -e "########\n"
  Install
}

# This function install all my packages on to your system

Install() {
  paru -S --needed - < $HOME/My-dotfiles/Bin/pkglist.txt
}

# This function run an if loop to check if you have installed 
# paru and if not it run "Paruinstlall" function to install paru
# When installing paru is done it run "Install" function described 
# earlier in this file 

if [ "$(which paru)" = "/usr/bin/paru" ]; then
  Install
else
  Paruinstlall
fi

# End of script
