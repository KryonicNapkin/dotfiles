#!/usr/bin/env bash
# set -xe

# This function install yay for you if you do not have it

YAYCHECK=$(which yay)
PARUCHECK=$(which paru)

abort() {
	echo "######################"
	echo "#    Aboriding...    #"
	echo "######################"
	exit 1
}

yay_install() {
	if [[ "$YAYCHECK" == "yay not found" ]]; then
		cd && git clone https://aur.archlinux.org/yay-bin.git
		cd yay-bin && makepkg -sci
		echo -e "########"
		echo -e "# DONE #"
		echo -e "########\n"
	else
		yay -S --needed - <$HOME/dotfiles/Bin/pkglist.txt
	fi
}

paru_install() {
	if [[ "$PARUCHECK" == "paru not found" ]]; then
		git clone https://aur.archlinux.org/paru.git
		cd paru && makepkg -sci
		echo -e "########"
		echo -e "# DONE #"
		echo -e "########\n"
	else
		paru -S --needed - <$HOME/dotfiles/Bin/pkglist.txt
	fi
}

read -p "What aur helper you want to install the packages with
(p for paru y for yay (paru's installation is longer than yay's)): " aurhelper
case $aurhelper in
y) yay_install ;;
p) paru_install ;;
*) abort ;;
esac

# End of script
