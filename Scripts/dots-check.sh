#!/bin/bash
# set -xe

CONFIGDIR=/home/oizero/.config

dotscheck() {
	echo -e "##############################"
	echo -e "### CONFIG DIRECTORY FILES ###"
	echo -e "##############################\n"

	echo -e "\n### Awesome dot dir ###"
	diff -rq $CONFIGDIR/awesome/ ~/My-dotfiles/config.d/awesome/

	echo -e "### Rofi AwesomeWM dot dir ###"
	diff -rq $CONFIGDIR/rofi_awesome/ ~/My-dotfiles/config.d/rofi_awesome/

	echo -e "\n### Picom AwesomeWM dot dir ###"
	diff -rq $CONFIGDIR/picom_awesome/ ~/My-dotfiles/config.d/picom_awesome/

	echo -e "### Qtile dot dir ###"
	diff -rq $CONFIGDIR/qtile/ ~/My-dotfiles/config.d/qtile/

	echo -e "### Rofi Qtile dot dir ###"
	diff -rq $CONFIGDIR/rofi/ ~/My-dotfiles/config.d/rofi/

	echo -e "\n### Picom Qtile dot dir ###"
	diff -rq $CONFIGDIR/picom/ ~/My-dotfiles/config.d/picom/

	echo -e "\n### Dunst dot dir ###"
	diff -rq $CONFIGDIR/dunst/ ~/My-dotfiles/config.d/dunst/

	echo -e "\n### zsh dot dir ###"
	diff -rq $CONFIGDIR/zsh/ ~/My-dotfiles/config.d/zsh/

	echo -e "\n### alacritty dot dir ###"
	diff -rq $CONFIGDIR/alacritty/ ~/My-dotfiles/config.d/alacritty/

	echo -e "#######################################################################################\n"

	echo -e "############################"
	echo -e "### HOME DIRECTORY FILES ###"
	echo -e "############################\n"

	echo -e "### .Xresources file ###\n"
	diff -rq ~/.Xresources ~/My-dotfiles/.Xresources

	echo -e "### .bashrc file ###\n"
	diff -rq ~/.bashrc ~/My-dotfiles/.bashrc

	echo -e "### .bash_profile file ###\n"
	diff -rq ~/.bash_profile ~/My-dotfiles/.bash_profile

	echo -e "### .fehbg file ###\n"
	diff -rq ~/.fehbg ~/My-dotfiles/.fehbg

	echo -e "### .xinitrc file ###\n"
	diff -rq ~/.xinitrc ~/My-dotfiles/.xinitrc

	echo -e "### .zprofile file ###\n"
	diff -rq ~/.zprofile ~/My-dotfiles/.zprofile

	echo -e "#######################################################################################\n"

	echo -e "############################"
	echo -e "### /USR DIRECTORY FILES ###"
	echo -e "############################\n"

	echo -e "### sddm conf dir (/usr/share) ###\n"
	diff -rq /usr/share/sddm ~/My-dotfiles/usr.d/share/sddm

	echo -e "### sddm conf dir (/usr/lib/) ###\n"
	diff -rq /usr/lib/sddm/sddm.conf.d ~/My-dotfiles/usr.d/lib/sddm/sddm.conf.d

}

dotscheck >dotcheck-report_$(date +%d-%m-%Y_%H:%M).txt
less dotcheck-report_$(date +%d-%m-%Y_%H:%M).txt
rm ~/My-dotfiles/Scripts/*.txt
