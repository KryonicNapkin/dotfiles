#!/bin/bash
# set -xe

dotscheck() {
  echo -e "##############################"
  echo -e "### CONFIG DIRECTORY FILES ###"
  echo -e "##############################\n"
  echo -e "### Qtile dot dir ###"
  diff -rq ~/.config/qtile/ ~/My-dotfiles/config.d/qtile/
  echo -e "\n### Dunst dot dir ###"
  diff -rq ~/.config/dunst/ ~/My-dotfiles/config.d/dunst/
  echo -e "\n### zsh dot dir ###"
  diff -rq ~/.config/zsh/ ~/My-dotfiles/config.d/zsh/
  echo -e "\n### alacritty dot dir ###"
  diff -rq ~/.config/alacritty/ ~/My-dotfiles/config.d/alacritty/
  echo -e "\n### rofi dot dir ###"
  diff -rq ~/.config/rofi/ ~/My-dotfiles/config.d/rofi/
  echo -e "#######################################################################################\n"
  echo -e "############################"
  echo -e "### HOME DIRECTORY FILES ###"
  echo -e "############################\n"
  echo -e "### .zshrc file ###\n"
  diff -rq ~/.zshrc ~/My-dotfiles/.zshrc
  echo -e "### .bashrc file ###\n"
  diff -rq ~/.bashrc ~/My-dotfiles/.bashrc
  echo -e "### .fehbg file ###\n"
  diff -rq ~/.fehbg ~/My-dotfiles/.fehbg
  echo -e "### .xinitrc file ###\n"
  diff -rq ~/.xinitrc ~/My-dotfiles/.xinitrc
  echo -e "#######################################################################################\n"
  echo -e "############################"
  echo -e "### /USR DIRECTORY FILES ###"
  echo -e "############################\n"
  echo -e "### sddm conf dir (/usr/share) ###\n"
  diff -rq /usr/share/sddm ~/My-dotfiles/usr.d/sddm
  echo -e "### sddm conf dir (/usr/lib/) ###\n"
  diff -rq /usr/lib/sddm/sddm.conf.d ~/My-dotfiles/usr.d/sddm.conf.d
  echo -e "#######################################################################################\n"
  echo -e "############################"
  echo -e "### /ETC DIRECTORY FILES ###"
  echo -e "############################\n"
  echo -e "### plymouth conf dir (/etc) ###\n"
  diff -rq /etc/plymouth ~/My-dotfiles/etc.d/plymouth
}

dotscheck > dotcheck-report_$(date +%d-%m-%Y_%H:%M).txt 
less dotcheck-report_$(date +%d-%m-%Y_%H:%M).txt
rm ~/My-dotfiles/Scripts/*.txt
