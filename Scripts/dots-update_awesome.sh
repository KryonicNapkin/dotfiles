#!/bin/bash
#set -xe

# Variables 
CONFIG=$HOME/.config
DOTDIR=$HOME/My-dotfiles

doned() {
  echo "##########################"
  echo "#         DONE           #"
  echo -e "##########################\n"
}

update_awesome() {
  echo "##############################"
  echo "# Updating awesomewm dot dir #"
  echo -e "##############################\n"
  cp -rf $CONFIG/awesome/ $DOTDIR/config.d/
  doned
}
update_picom.awesome() {
  echo "##################################"
  echo "# Updating picom.awesome dot dir #"
  echo -e "##################################\n"
  cp -rf $CONFIG/picom.awesome/ $DOTDIR/config.d/
  doned
}

update_rofi.awesome() {
  echo "##################################"
  echo "# Updating rofi.awesome dot dir  #"
  echo -e "##################################\n"
  cp -rf $CONFIG/rofi.awesome $DOTDIR/config.d/
  doned
}

while getopts "aprw" option; do  
  case "${option}" in
    a ) 
      update_awesome
      ;;
    p ) 
      update_picom.awesome
      ;;
    r ) 
      update_rofi.awesome
      ;;
    w ) 
      update_picom.awesome; update_awesome; update_rofi.awesome;
      ;;
    ? ) 
     echo "Invalid option $1"; exit 1
     ;; 
  esac
done
