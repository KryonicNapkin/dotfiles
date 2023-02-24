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

update_awesome() {
	echo "##########################"
	echo "# Updating awesome dot dir #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config.d/awesome
	cp -rf $CONFIG/awesome/ $DOTDIR/config.d/
	doned
}

update_picom_awesome() {
	echo "##################################"
	echo "# Updating picom_awesome dot dir #"
	echo -e "##################################\n"
	cp -rf $CONFIG/picom_awesome $DOTDIR/config.d/
	doned
}

update_rofi_awesome() {
	echo "#################################"
	echo "# Updating rofi_awesome dot dir #"
	echo -e "#################################\n"
    rm -rf $DOTDIR/config.d/rofi_awesome
	cp -rf $CONFIG/rofi_awesome $DOTDIR/config.d/
	doned
}

update_qtile() {
	echo "##########################"
	echo "# Updating qtile dot dir #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config.d/qtile
    cp -rrf $CONFIG/qtile/ $DOTDIR/config.d/
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
	cp -rf $CONFIG/alacritty/alacritty.yml $DOTDIR/config.d/alacritty
	doned
}

update_rofi() {
	echo "##########################"
	echo "# Updating rofi dot dir  #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config.d/rofi
	cp -rf $CONFIG/rofi $DOTDIR/config.d/
	doned
}

update_zsh() {
	echo "##########################"
	echo "#  Updating zsh dot dir  #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config.d/zsh
	cp -rf $CONFIG/zsh $DOTDIR/config.d/
	cp -rf $HOME/.zprofile $DOTDIR/
	doned
}

update_fehbg() {
	echo "##########################"
	echo "#     Updating fehbg     #"
	echo -e "##########################\n"
	cp -rf $HOME/.fehbg $DOTDIR/
	cp -rf $HOME/.fehbg_qtile $DOTDIR/
	doned
}

update_bash() {
	echo "##########################"
	echo "#     Updating bash      #"
	echo -e "##########################\n"
	cp -rf $HOME/.bashrc $DOTDIR/
	cp -rf $HOME/.bash_profile $DOTDIR/
	doned
}

update_x() {
	echo "#############################"
	echo "#    Updating Xorg files    #"
	echo -e "#############################\n"
	cp -rf $HOME/.xinitrc $DOTDIR/
	cp -rf $HOME/.Xresources $DOTDIR/
	doned
}

while getopts "qxdplarzefb" option; do
	case "${option}" in
	q)
		update_qtile
		;;
	d)
		update_dunst
		;;
	p)
		update_picom
		update_picom_awesome
		;;
	a)
		update_awesome
		;;
	l)
		update_alacritty
		;;
	r)
		update_rofi
		update_rofi_awesome
		;;
	z)
		update_zsh
		;;
	f)
		update_fehbg
		;;
	x)
		update_x
		;;
	b)
		update_bash
		;;
	e)
		update_qtile
		update_dunst
		update_picom
		update_picom_awesome
        update_awesome
		update_alacritty
		update_rofi
		update_rofi_awesome
		update_zsh
		update_fehbg
		update_x
		update_bash
		;;
	?)
		echo "Invalid option $1"
		exit 1
		;;
	esac
done
