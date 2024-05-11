#!/bin/sh
# This is a script that will automate backing up my Drawings folder

devpath="/dev/sda1" 
mountpath="/mnt"

backup() {
	printf "Pripájam $devpath na $mountpath\n"
	sudo mount $devpath $mountpath
	printf "Hotovo\n\n"
	printf "Mažem Drawingsový priečinok z USB kľúča.\n"
	sudo rm -rf $mountpath/Drawings
	printf "Hotovo\n\n"
	printf "Kopírujem Drawingsový priečinok z PC na USB kľúč.\n"
	sudo cp -rf ~/Drawings $mountpath/
	printf "Hotovo\n\n"
	cd ~
	printf "Odpájam $devpath od PC\n"
	sudo umount $devpath
	printf "Hotovo!\n"
	printf "Keď prestane blikať červené svetielko, vyberte USB kľúč z PC.\n"
}

main() {
	printf "\033[1;31mZisti, či máš ten správny USB klúč zasunutý do PC (Ten si nápisom BACKUP) a má označenie /dev/sda. Keď áno, tak stlač y. Keď chceš zrušiť program stlač n. \033[0m"
	while read -p "[y/n/l] " choice; do 
		case $choice in
			'y')
				backup
				break
				;;
			'l')
				printf "%s\n" "------------------------------ Output of lsblk ------------------------------"
				lsblk -f
				printf "\033[1;31mZisti, či máš ten správny USB klúč zasunutý do PC (Ten si nápisom BACKUP) a má označenie /dev/sda. Keď áno, tak stlač y. Keď chceš zrušiť program stlač n. \033[0m"
				;;
			'n')
				exit
				;;
			*)
				printf "Zlá voľba\n"
				;;
		esac
	done
}

main
