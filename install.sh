#!/usr/bin/env bash
# set -xe
#
# TODO :    1. Install all the packages
#           2. link all the necessary config files
#           3. Install GTK and Qt themes
#           4. Set up default services (i.e. cups, ufw and others)
# Script for the installation of my configuration 

# 1. Check for aur package manager 
dotdir="$HOME/.dotfiles"
yaych=$(which yay; echo $?)
paruch=$(which paru; echo $?)
netcheck=$(ping 8.8.8.8; echo $?)

yay_install() {
    if [[ $(which git; echo $?) -ne 0 ]]; then
        echo "git is not installed"
        echo "This install script is going to install it for you"
        echo "Installing git..."
        pacman -Syu git
        echo "Done";
    fi
    cd ~ && git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin 
    echo "Installing yay..";
    makepkg -sci 
    echo "Done";
}

paru_install() {
    if [[ $(which git; echo $?) -ne 0 ]]; then
        echo "git is not installed"
        echo "This install script is going to install it for you"
        echo "Installing git..."
        pacman -Syu git
        echo "Done";
    fi
    cd ~ && git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin 
    echo "Installing paru..";
    makepkg -sci 
    echo "Done";
}

pkgs_install() {
    if [[ $1 == "yay" ]]; then
        if [[ $yaych -ne 0 ]]; then
            yay_install
        fi
        pacman -S --needed - < "$dotdir/.pkgs"
        yay -S --needed - < "$dotdir/.pkgs_aur"
    elif [[ $1 == "paru" ]]; then
        if [[ $paruch -ne 0 ]]; then
            paru_install
        fi
        pacman -S --needed - < "$dotdir/.pkgs"
        paru -S --needed - < "$dotdir/.pkgs_aur"
    fi
}

link_files() {
    echo "Started linking files..."
    echo "Linking files in the home directory"
    ln -s "$dotdir/.bash_profile" ~/.bash_profile
    ln -s "$dotdir/.bashrc" ~/.bashrc
    ln -s "$dotdir/.fehbg" ~/.fehbg
    ln -s "$dotdir/.gitconfig" ~/.gitconfig
    ln -s "$dotdir/.gtkrc-2.0.mine" ~/.gtkrc-2.0.mine
    ln -s "$dotdir/.profile" ~/.profile
    ln -s "$dotdir/.xinitrc" ~/.xinitrc
    ln -s "$dotdir/.Xresource" ~/.Xresources
    ln -s "$dotdir/.zprofile" ~/.zprofile
    echo "DONE"

    echo "Linking files in the .local/bin directory"
    ln -s "$dotdir/.local/bin/prep.sh" ~/.local/bin/prep.sh
    ln -sd "$dotdir/.local/bin/scripts" ~/.local/bin/scripts
    ln -sd "$dotdir/.local/bin/utils" ~/.local/bin/utils
    echo "DONE"

    echo "Linking files in the .local/share directory"
    ln -sd "$dotdir/.local/share/dracula-wallpapers" ~/.local/share/wallpapers/dracula-wallpapers
    ln -sd "$dotdir/.local/share/onedark-wallpapers" ~/.local/share/wallpapers/onedark-wallpapers
    echo "DONE"

    echo "Linking files in the .config directory"
    ln -s "$dotdir/.config/picom.conf" ~/.config/picom.conf
    ln -s "$dotdir/.config/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
    ln -s "$dotdir/.config/alacritty/alacritty_scratchpad.toml" ~/.config/alacritty/alacritty_scratchpad.toml
    ln -s "$dotdir/.config/betterlockscreen/betterlockscreenrc" ~/.config/betterlockscreen/betterlockscreenrc
    ln -s "$dotdir/.config/betterlockscreen/betterlockscreenrc" ~/.config/betterlockscreen/betterlockscreenrc
    ln -sd "$dotdir/.config/dmenu" ~/.config/
    ln -s "$dotdir/.config/gtk-3.0/settings.ini" ~/.config/gtk-3.0/settings.ini
    if [[ ! -d "~/.config/nvim" ]]; then
        mkdir ~/.config/nvim
    fi
    ln -sd "$dotdir/.config/nvim" ~/.config/
    if [[ ! -d "~/.config/qtile" ]]; then
        mkdir ~/.config/qtile
    fi
    ln -s "$dotdir/.config/qtile/config.py" ~/.config/qtile/config.py 
    if [[ ! -d "~/.config/wired" ]]; then
        mkdir ~/.config/wired
    fi
    ln -s "$dotdir/.config/wired/wired.ron" ~/.config/wired/wired.ron 
    if [[ ! -d "~/.config/zsh" ]]; then
        mkdir ~/.config/zsh
    fi
    ln -s "$dotdir/.config/zsh/zsh-aliases" ~/.config/zsh/zsh-aliases
    ln -s "$dotdir/.config/zsh/.zshev" ~/.config/zsh/.zshenv
    ln -s "$dotdir/.config/zsh/zsh-exports" ~/.config/zsh/zsh-exports
    ln -s "$dotdir/.config/zsh/zsh-prompt" ~/.config/zsh/zsh-prompt
    ln -s "$dotdir/.config/zsh/.zshrc" ~/.config/zsh/.zshrc
    if [[ $1 == "also-old" ]]; then
        echo "Linking old software..."
        if [[ ! -d "~/.config/dunst" ]]; then
            mkdir ~/.config/dunst
        fi
        ln -s "$dotdir/.config/.back_dunst" ~/.config/dunst/dunstrc
        ln -sd "$dotdir/.config/.back_dwm" ~/.config/dwm
        if [[ ! -d "~/.config/rofi" ]]; then
            mkdir ~/.config/rofi
        fi
        ln -s "$dotdir/.config/.back_rofi/dmenu.rasi" ~/.config/rofi/dmenu.rasi
        ln -s "$dotdir/.config/.back_rofi/dracula.rasi" ~/.config/rofi/dracula.rasi
        ln -s "$dotdir/.config/.back_rofi/onedark.rasi" ~/.config/rofi/onedark.rasi
    fi
    echo "DONE"

    echo "Enabling higher vm map count to 2147483642"
    ln -s "$dotdir/etc/sysctl.d/99-sysctl.conf"
    echo "DONE"
}

start_services() {
    echo "Enabling printer service..."
    sudo systemctl enable cups.service
    echo "Done"
    echo "Enabling firewall (ufw) service..."
    sudo systemctl enable ufw.service
    echo "Done"
    if [[ -d "/sys/class/power_supply/BAT*" ]]; then
        echo "Enabling laptop battery management service..."
        sudo systemctl enable tlp.service
        echo "Done"
    fi
    echo "Enabling cronie service..."
    sudo systemctl enable cronie.service
    echo "DONE"
}

main() {
    echo -e "Disclamer! This script will delete your current system configuration!"
    echo "This script will install KryonicNapkin's dotfiles and system configuration"
    echo "onto your computer"

    read -p "Which AUR helper do you prefer to use to install packages (yay/paru)? [y/p]: " confirm
    case $confirm in
    y) pkgs_install "yay" ;;
    p) pkgs_install "paru" ;;
    *) exit 1 ;;
    esac

    echo "LINK FILES"
    read -p "Do you want to link the old config files of .back_dwm, .back_dunst and .back_rofi? [y/n]: " choice
    case $choice in
    y) link_files also-old ;;
    n) link_files ;;
    *) exit 1 ;;
    esac

    echo "SETTING UP SERVICES"
    read -p "Do you want to set up automatic services? [y/n]: " choice
    case $choice in
    y) start_services ;;
    n) exit 0 ;;
    *) exit 1 ;;
    esac
}

main