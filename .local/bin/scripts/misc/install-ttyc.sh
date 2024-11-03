#!/bin/bash
# This script installs tty-clock program (TTY clock)

install() {
	git clone https://github.com/xorg62/tty-clock ~/gits/tty-clock
	cd ~/gits/tty-clock
	sudo make install
}

checkinstalled() {
	ttyc=$(which tty-clock)
	if [[ -n $ttyc ]]; then
		printf "\n"
		printf "%s\n" "You have tty-clock already installed!"
		exit
	fi
}

main() {
	checkinstalled
	printf "%s\n" "Installing tty-clock program"
	install
	printf "%s\n" "Done installing"
}

main
