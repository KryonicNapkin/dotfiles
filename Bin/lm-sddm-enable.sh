#!/bin/bash
# set -xe

# This script enables my sddm theme and set sddm 
# as your default login manager

enablesddm() {
  sudo systemctl disable $(grep '/usr/bin' /etc/systemd/system/display-manager.service | awk -F / '{print $NF}')
  sudo systemctl enable sddm
  echo "##############################################"
  echo "# Enabled sddm as your default login manager #"
  echo -e "##############################################\n"
}

enablesddm
