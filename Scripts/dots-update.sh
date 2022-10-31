#!/bin/bash
#set -xe

# Variables 
CONFIG=$HOME/.config/
DOTDIR=$HOME/My-dotfiles/

doned() {
  echo "##########################"
  echo "#         DONE           #"
  echo -e "##########################\n"
}

update_qtile() {
  echo "##########################"
  echo "# Updating qtile dot dir #"
  echo -e "##########################\n"
  cp -rf $CONFIG/qtile/ $DOTDIR/config.d/
  doned
}
update_dunst() {
  echo "##########################"
  echo "# Updating dunst dot dir #"
  echo -e "##########################\n"
  cp -rf $CONFIG/dunst/ $DOTDIR/config.d/
  doned
}

update_picom() {
  echo "###########################"
  echo "# Updating picom dot dir  #"
  echo -e "###########################\n"
  cp -rf $CONFIG/picom $DOTDIR/config.d/
  doned
}

update_alacritty() {
  echo "##############################"
  echo "# Updating alacritty dot dir #"
  echo -e "##############################\n"
  cp -rf $CONFIG/alacritty/*.yml $DOTDIR/config.d/alacritty
  doned
}

update_rofi() {
  echo "##########################"
  echo "# Updating rofi dot dir  #"
  echo -e "##########################\n"
  cp -rf $CONFIG/rofi $DOTDIR/config.d/
  doned
}

update_zsh() {
  echo "##########################"
  echo "#  Updating zsh dot dir  #"
  echo -e "##########################\n"
  cp -rf $CONFIG/zsh $DOTDIR/config.d/
  doned
}

while getopts "qdparzw" option; do  
  case "${option}" in
    q ) 
      update_qtile
      ;;
    d ) 
      update_dunst
      ;;
    p ) 
      update_picom
      ;;
    a ) 
      update_alacritty
      ;;
    r ) 
      update_rofi
      ;;
    z ) 
      update_zsh
      ;;
    w ) 
      update_qtile; update_dunst; update_picom; update_alacritty; update_rofi; update_zsh;
      ;;
    ? ) 
     echo "Invalid option $1"; exit 1
     ;; 
  esac
done
