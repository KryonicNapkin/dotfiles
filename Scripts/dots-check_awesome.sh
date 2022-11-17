#!/bin/bash
# set -xe

dotscheck() {
  echo -e "##############################"
  echo -e "### AwesomeWM DIRECTORY FILES ###" 
  echo -e "##############################\n" 

  echo -e "### Awesome dot dir ###" 
  diff -rq ~/.config/awesome/ ~/My-dotfiles/config.d/awesome/

  echo -e "\n### rofi.awesome dot dir ###"
  diff -rq ~/.config/rofi.awesome/ ~/My-dotfiles/config.d/rofi.awesome/

  echo -e "\n### picom dot dir ###"
  diff -rq ~/.config/picom.awesome/ ~/My-dotfiles/config.d/picom.awesome/
  echo -e "#######################################################################################\n"
}

dotscheck > dotcheck-report_awesomewm_$(date +%d-%m-%Y_%H:%M).txt 
less dotcheck-report_awesomewm_$(date +%d-%m-%Y_%H:%M).txt
rm ~/My-dotfiles/Scripts/*.txt
