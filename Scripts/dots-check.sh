#!/bin/bash
# set -xe

dotscheck() {
  echo -e "##############################"
  echo -e "### CONFIG DIRECTORY FILES ###"
  echo -e "##############################\n"
  echo -e "### Qtile dot dir ###\n"
  diff -q ~/.config/qtile/ ~/My-dotfiles/config.d/qtile/
  echo -e "\n### Dunst dot dir ###"
  diff -q ~/.config/dunst/ ~/My-dotfiles/config.d/dunst/
  echo -e "\n### zsh dot dir ###"
  diff -q ~/.config/zsh/ ~/My-dotfiles/config.d/zsh/
  echo -e "\n### alacritty dot dir ###"
  diff -q ~/.config/alacritty/ ~/My-dotfiles/config.d/alacritty/
  echo -e "\n### rofi dot dir ###"
  diff -q ~/.config/rofi/ ~/My-dotfiles/config.d/rofi/
  echo -e "#######################################################################################\n"
  echo -e "############################"
  echo -e "### HOME DIRECTORY FILES ###"
  echo -e "############################\n"
  echo -e "### .zshrc file ###\n"
  diff -q ~/.zshrc ~/My-dotfiles/.zshrc
  echo -e "### .bashrc file ###\n"
  diff -q ~/.bashrc ~/My-dotfiles/.bashrc
  echo -e "### .fehbg file ###\n"
  diff -q ~/.fehbg ~/My-dotfiles/.fehbg
}

dotscheck
