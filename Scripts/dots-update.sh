#!/bin/bash
#set -xe

# Variables
config=$HOME/.config/
dotdir=$HOME/dotfiles/
scriptd=$HOME/.local/

# Actual code
doned() {
    echo "##########################"
    echo "#         DONE           #"
    echo -e "##########################\n"
}

# WMs
awesome() {
    echo "########################"
    echo "# Updating awesome dir #"
    echo -e "########################\n"
    rm -rf $dotdir/config/awesome
    cp -rf $config/awesome/ $dotdir/config/
    doned
}

dwm() {
    echo "######################"
    echo "#  Updating dwm dir  #"
    echo -e "######################\n"
    rm -rf $dotdir/config/dwm
    rsync -av $config/dwm/ $dotdir/config/dwm --exclude=config.def.h.orig --exclude=config.h --exclude=config.def.h.rej --exclude=dwm.o --exclude=dwm --exclude=drw.o --exclude=dwm.c.orig --exclude=dwm.c.rej --exclude=util.o
    doned
}

qtile() {
    echo "######################"
    echo "# Updating qtile dir #"
    echo -e "######################\n"
    rm -rf $dotdir/config/qtile
    rsync -av $config/qtile/ $dotdir/config/qtile --exclude=__pycache__ --exclude=scripts/__pycache__
    doned
}

# CONFIG dirs
alacritty() {
    echo "##########################"
    echo "# Updating alacritty dir #"
    echo -e "##########################\n"
    rm -rf $dotdir/config/alacritty
    rsync -av $config/alacritty/ $dotdir/config/alacritty --exclude=alacritty.yml
    doned
}

dunst() {
    echo "######################"
    echo "# Updating dunst dir #"
    echo -e "######################\n"
    rm -rf $dotdir/config/dunst
    rsync -av $config/dunst/ $dotdir/config/dunst --exclude=dunstrc
    doned
}

fehbg() {
    echo "######################"
    echo "#  Updating feh dir  #"
    echo -e "######################\n"
    rm -rf $dotdir/config/feh
    rsync -av $config/feh/ $dotdir/config/feh --exclude=fehbg
    doned
}

localshr() {
    echo "############################"
    echo "# Updating local share dir #"
    echo -e "############################\n"
    rsync -av $scriptd/share/univ $dotdir/local/share/
}

localbin() {
    echo "##########################"
    echo "# Updating local bin dir #"
    echo -e "##########################\n"
    rsync -av $scriptd/bin/ $dotdir/local/bin --exclude=reminders --exclude=dmypy --exclude=mypy --exclude=mypyc --exclude=qemantra --exclude=stubgen --exclude=stubtest --exclude=wpm --exclude=prep.sh
}

nvim() {
    echo "#######################"
    echo "#  Updating nvim dir  #"
    echo -e "#######################\n"
    rm -rf $dotdir/config/nvim
    cp -r $config/nvim/ $dotdir/config/
    doned
}

picom() {
    echo "##############################"
    echo "#     Updating picom dir     #"
    echo -e "##############################\n"
    rm -rf $dotdir/config/picom
    rsync -av $config/picom/ $dotdir/config/picom --exclude=picom.conf
    doned
}

rofi() {
    echo "#############################"
    echo "#     Updating rofi dir     #"
    echo -e "#############################\n"
    rm -rf $dotdir/config/rofi
    rsync -av $config/rofi/ $dotdir/config/rofi
    doned
}

zsh() {
    echo "######################"
    echo "#  Updating zsh dir  #"
    echo -e "######################\n"
    rm -rf $dotdir/config/zsh
    rsync -av $config/zsh/ $dotdir/config/zsh --exclude=.zcompdump --exclude=.zsh_history
    cp -rf $HOME/.zprofile $dotdir/
    doned
}

# HOME dir
bash() {
    echo "##########################"
    echo "#     Updating bash      #"
    echo -e "##########################\n"
    cp -rf $HOME/.bashrc $dotdir/
    cp -rf $HOME/.bash_profile $dotdir/
    doned
}

X11() {
    echo "#############################"
    echo "#    Updating X11 files     #"
    echo -e "#############################\n"
    cp -rf $HOME/.xinitrc $dotdir/
    cp -rf $HOME/.Xresources $dotdir/
    doned
}

while getopts "abcdeflnpqrsxwz" option; do
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
    s)
        localshr
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
        localshr
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
