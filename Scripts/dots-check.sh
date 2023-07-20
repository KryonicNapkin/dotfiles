#!/bin/bash
# set -xe

CONFDIR=$HOME/.config
DOTDIR=$HOME/dotfiles

dotscheck() {
    echo -e "##############################"
    echo -e "### CONFIG DIRECTORY FILES ###"
    echo -e "##############################"

    echo -e "\n### AwesomeWM dir ###"
    diff -rq $CONFDIR/awesome/ $DOTDIR/config/awesome/

    echo -e "\n### Qtile dir ###"
    diff -rq $CONFDIR/qtile/ $DOTDIR/config/qtile/

    echo -e "\n### DWM dir ###"
    diff -rq $CONFDIR/dwm/ $DOTDIR/config/dwm/

    echo -e "\n### Dunst dir ###"
    diff -rq $CONFDIR/dunst/ $DOTDIR/config/dunst/

    echo -e "\n### zsh dir ###"
    diff -rq $CONFDIR/zsh/ $DOTDIR/config/zsh/

    echo -e "\n### alacritty dir ###"
    diff -rq $CONFDIR/alacritty/ $DOTDIR/config/alacritty/

    echo -e "\n### feh dir ###"
    diff -rq $CONFDIR/feh/ $DOTDIR/config/feh/

    echo -e "\n### nvim dir ###"
    diff -rq $CONFDIR/nvim/ $DOTDIR/config/nvim/

    echo -e "###################################################################\n"

    echo -e "############################"
    echo -e "### HOME DIRECTORY FILES ###"
    echo -e "############################"

    echo -e "\n### .Xresources file ###"
    diff -rq ~/.Xresources $DOTDIR/.Xresources

    echo -e "\n### .bashrc file ###n"
    diff -rq ~/.bashrc $DOTDIR/.bashrc

    echo -e "\n### .bash_profile file ###"
    diff -rq ~/.bash_profile $DOTDIR/.bash_profile

    echo -e "\n### .xinitrc files ###"
    diff -rq ~/.xinitrc $DOTDIR/.xinitrc

    echo -e "\n### .zprofile file ###"
    diff -rq ~/.zprofile $DOTDIR/.zprofile

    echo -e "###################################################################\n"

    echo -e "############################"
    echo -e "### /USR DIRECTORY FILES ###"
    echo -e "############################"

    echo -e "\n### sddm conf dir (/usr/share) ###"
    diff -rq /usr/share/sddm $DOTDIR/usr/share/sddm

    echo -e "\n### sddm conf dir (/usr/lib/) ###"
    diff -rq /usr/lib/sddm/sddm.conf.d $DOTDIR/usr/lib/sddm/sddm.conf.d

    echo -e "##############################"
    echo -e "### .local DIRECTORY FILES ###"
    echo -e "##############################"

    echo -e "\n### bin dir (~/.local/bin) ###"
    diff -rq ~/.local/bin $DOTDIR/local/bin

    echo -e "\n### share dir (~/.local/share) ###"
    diff -rq ~/.local/share/univ $DOTDIR/local/share/univ
}

dotscheck >dotcheck-report_$(date +%d-%m-%Y_%H:%M).txt
less dotcheck-report_$(date +%d-%m-%Y_%H:%M).txt
rm $DOTDIR/Scripts/*.txt
