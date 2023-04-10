#!/bin/bash
#set -xe

# Variables
CONFIG=$HOME/.config/
DOTDIR=$HOME/My-dotfiles/

# Actual code
doned() {
	echo "##########################"
	echo "#         DONE           #"
	echo -e "##########################\n"
}

# WMs
awesome() {
	echo "##########################"
	echo "# Updating awesome dot dir #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config/awesome
	cp -rf $CONFIG/awesome/ $DOTDIR/config/
	doned
}

qtile() {
	echo "##########################"
	echo "# Updating qtile dot dir #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config/qtile
    rsync -av $CONFIG/qtile/ $DOTDIR/config/qtile --exclude=__pycache__
	doned
}

dwm() {
	echo "##########################"
	echo "#  Updating dwm dot dir  #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config/dwm
    cp -rf $CONFIG/dwm/ $DOTDIR/config/
	doned
}

# CONFIG dirs
alacritty() {
	echo "##############################"
	echo "# Updating alacritty dot dir #"
	echo -e "##############################\n"
    rm -rf $DOTDIR/config/alacritty
	cp -rf $CONFIG/alacritty/ $DOTDIR/config/
	doned
}

dunst() {
	echo "##########################"
	echo "# Updating dunst dot dir #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config/dunst
	cp -rf $CONFIG/dunst/ $DOTDIR/config/
	doned
}

fehbg() {
	echo "##########################"
	echo "#  Updating feh dot dir  #"
	echo -e "##########################\n"
	rm -rf $DOTDIR/config/feh
	cp -rf $CONFIG/feh/ $DOTDIR/config/
	doned
}

picom() {
	echo "##################################"
	echo "#     Updating picom dot dir     #"
	echo -e "##################################\n"
    rm -rf $DOTDIR/config/picom
	cp -rf $CONFIG/picom $DOTDIR/config/
	doned
}

rofi() {
	echo "#################################"
	echo "#     Updating rofi dot dir     #"
	echo -e "#################################\n"
    rm -rf $DOTDIR/config/rofi
	cp -rf $CONFIG/rofi $DOTDIR/config/
	doned
}

zsh() {
	echo "##########################"
	echo "#  Updating zsh dot dir  #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config/zsh
	rsync -av $CONFIG/zsh $DOTDIR/config/ --exclude '.zcompdump' --exclude '.zsh_history'
	cp -rf $HOME/.zprofile $DOTDIR/
	cp -rf $HOME/.zshrc $DOTDIR/
	doned
}

# HOME dir
bash() {
	echo "##########################"
	echo "#     Updating bash      #"
	echo -e "##########################\n"
	cp -rf $HOME/.bashrc $DOTDIR/
	cp -rf $HOME/.bash_profile $DOTDIR/
	doned
}

X11() {
	echo "#############################"
	echo "#    Updating X11 files     #"
	echo -e "#############################\n"
	cp -rf $HOME/.xinitrc_a $DOTDIR/
	cp -rf $HOME/.xinitrc_d $DOTDIR/
	cp -rf $HOME/.xinitrc_q $DOTDIR/
	cp -rf $HOME/.Xresources $DOTDIR/
	doned
}

while getopts "abdeflpqrxwz" option; do
	case "${option}" in
	a)
		awesome
		;;
	w)
		dwm
		;;
	q)
		qtile
		;;
	l)
		alacritty
		;;
	d)
		dunst
		;;
	f)
		fehbg
		;;
	p)
		picom
		;;
	r)
		rofi
		;;
	z)
	    zsh
		;;
	b)
		bash
		;;
	x)
		X11
		;;
	e)
        awesome
        dwm
		qtile
		alacritty
		dunst
		fehbg
		picom
		rofi
		zsh
		bash
		X11
		;;
	?)
		echo "Invalid option $1"
		exit 1
		;;
	esac
done
