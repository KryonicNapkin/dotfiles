#!/bin/bash
set -xe

doned() {
  echo "##########################"
  echo "#         DONE           #"
  echo "##########################"
}

abort() {
  echo "##########################"
  echo "#         ABORT          #"
  echo "##########################"
}

update_qtile() {
  echo "##########################"
  echo "# Updating qtile dot dir #"
  echo -e "##########################\n"
  cp -rf ~/.config/qtile ~/My-dotfiles/config.d/
}
update_dunst() {
  echo "##########################"
  echo "# Updating dunst dot dir #"
  echo -e "##########################\n"
  cp -rf ~/.config/zsh ~/My-dotfiles/confid.d/
}

update_alacritty() {
  echo "##############################"
  echo "# Updating alacritty dot dir #"
  echo -e "##############################\n"
  cp -rf ~/.config/alacritty ~/My-dotfiles/confid.d/
}

update_rofi() {
  echo "##########################"
  echo "# Updating rofi dot dir  #"
  echo -e "##########################\n"
  cp -rf ~/.config/rofi ~/My-dotfiles/confid.d/
}

update_zsh() {
  echo "##########################"
  echo "#  Updating zsh dot dir  #"
  echo -e "##########################\n"
  cp -rf ~/.config/zsh ~/My-dotfiles/confid.d/
}

main() {
  while getopts q:d:a:z:r flag
  do
    case "${flag}" in
      q) update_qtile;;
      d) update_dunst;;
      a) update_alacritty;;
      z) update_zsh;;
      r) update_rofi;;
    esac
  done
}
