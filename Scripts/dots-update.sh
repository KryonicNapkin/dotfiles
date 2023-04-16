#!/bin/bash
#set -xe

# Variables
CONFIG=$HOME/.config/
DOTDIR=$HOME/dotfiles/
BINDIR=$HOME/.local/

# Actual code
doned()
{
	echo "##########################"
	echo "#         DONE           #"
	echo -e "##########################\n"
}

# WMs
awesome()
{
	echo "########################"
	echo "# Updating awesome dir #"
	echo -e "########################\n"
    rm -rf $DOTDIR/config/awesome
	cp -rf $CONFIG/awesome/ $DOTDIR/config/
	doned
}

dwm()
{
	echo "######################"
	echo "#  Updating dwm dir  #"
	echo -e "######################\n"
    rm -rf $DOTDIR/config/dwm
    cp -rf $CONFIG/dwm/ $DOTDIR/config/
	doned
}

qtile()
{
	echo "######################"
	echo "# Updating qtile dir #"
	echo -e "######################\n"
    rm -rf $DOTDIR/config/qtile
    rsync -av $CONFIG/qtile/ $DOTDIR/config/qtile --exclude=__pycache__
	doned
}

# CONFIG dirs
alacritty()
{
	echo "##########################"
	echo "# Updating alacritty dir #"
	echo -e "##########################\n"
    rm -rf $DOTDIR/config/alacritty
	cp -rf $CONFIG/alacritty/ $DOTDIR/config/
	doned
}

dunst()
{
	echo "######################"
	echo "# Updating dunst dir #"
	echo -e "######################\n"
    rm -rf $DOTDIR/config/dunst
	cp -rf $CONFIG/dunst/ $DOTDIR/config/
	doned
}

fehbg()
{
	echo "######################"
	echo "#  Updating feh dir  #"
	echo -e "######################\n"
	rm -rf $DOTDIR/config/feh
	cp -rf $CONFIG/feh/ $DOTDIR/config/
	doned
}

localbin()
{
	echo "##########################"
	echo "# Updating local bin dir #"
	echo -e "##########################\n"
    rsync -av $BINDIR/bin/ $DOTDIR/local/bin --exclude=dmypy --exclude=mypy --exclude=mypyc --exclude=qemantra --exclude=stubgen --exclude=stubtest --exclude=wpm
}

nvim()
{
	echo "#######################"
	echo "#  Updating nvim dir  #"
	echo -e "#######################\n"
    rm -rf $DOTDIR/config/nvim
    cp -r $CONFIG/nvim/ $DOTDIR/config/
    doned
}

picom()
{
	echo "##############################"
	echo "#     Updating picom dir     #"
	echo -e "##############################\n"
    rm -rf $DOTDIR/config/picom
	cp -rf $CONFIG/picom $DOTDIR/config/
	doned
}

rofi()
{
	echo "#############################"
	echo "#     Updating rofi dir     #"
	echo -e "#############################\n"
    rm -rf $DOTDIR/config/rofi
	cp -rf $CONFIG/rofi $DOTDIR/config/
	doned
}

zsh()
{
	echo "######################"
	echo "#  Updating zsh dir  #"
	echo -e "######################\n"
    rm -rf $DOTDIR/config/zsh
	rsync -av $CONFIG/zsh $DOTDIR/config/ --exclude '.zcompdump' --exclude '.zsh_history'
	cp -rf $HOME/.zprofile $DOTDIR/
	cp -rf $HOME/.zshrc $DOTDIR/
	doned
}

# HOME dir
bash()
{
	echo "##########################"
	echo "#     Updating bash      #"
	echo -e "##########################\n"
	cp -rf $HOME/.bashrc $DOTDIR/
	cp -rf $HOME/.bash_profile $DOTDIR/
	doned
}

X11()
{
	echo "#############################"
	echo "#    Updating X11 files     #"
	echo -e "#############################\n"
	cp -rf $HOME/.xinitrc_a $DOTDIR/
	cp -rf $HOME/.xinitrc_d $DOTDIR/
	cp -rf $HOME/.xinitrc_q $DOTDIR/
	cp -rf $HOME/.Xresources $DOTDIR/
	doned
}

while getopts "abcdeflnpqrxwz" option; do
	case "${option}" in
	a)
		awesome
		;;
	b)
		bash
		;;
    c)
        localbin
        ;;
	d)
		dunst
		;;
	f)
		fehbg
		;;
	l)
		alacritty
		;;
    n)
        nvim
        ;;
	p)
		picom
		;;
	q)
		qtile
		;;
	r)
		rofi
		;;
	x)
		X11
		;;
	w)
		dwm
		;;
	z)
	    zsh
		;;
	e)
		alacritty
        awesome
		bash
        dwm
		dunst
		fehbg
        localbin
		picom
		rofi
		qtile
		X11
		zsh
		;;
	?)
		echo "Invalid option $1"
		exit 1
		;;
	esac
done
