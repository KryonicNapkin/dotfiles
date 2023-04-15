#!/bin/bash
# set -xe

# This script enables my sddm theme and set sddm
# as your default login manager

abort() {
  echo "###########"
  echo "# ABORTED #"
  echo -e "###########\n"
  exit 1
}

enablesddm() {
  sudo systemctl disable $(grep '/usr/bin' /etc/systemd/system/display-manager.service | awk -F / '{print $NF}')
  sudo systemctl enable sddm
  echo "##############################################"
  echo "# Enabled sddm as your default login manager #"
  echo -e "##############################################\n"
  while true; do
    read -p "Do you want to install theme too?: [yn]" choice1
    case "$choice1" in
      y) enablesddmtheme; break;;
      n) abort ;;
      *) echo "Please choice y or n:"
    esac
  done
}

enablesddmtheme() {
  sudo cp -rf ~/dotfiles/usr/share/sddm /usr/share/
  sudo cp -rf ~/dotfiles/usr/lib/sddm/sddm.conf.d /usr/lib/sddm/
  echo "###############################################"
  echo "# Enabled sugar-dark theme as your sddm theme #"
  echo -e "###############################################\n"
}

main() {
  while true; do
  read -p "Do you want to enable sddm as your default login manager? [yn]: " choice
    case "$choice" in
      y) enablesddm;
      break;;
      n) abort;;
      *) echo "Please choice y or n:"
    esac
  done
}

main
