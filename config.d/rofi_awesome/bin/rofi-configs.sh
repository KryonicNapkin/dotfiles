#!/bin/bash
CONFDIR=$HOME/.config
ED="nvim"

declare -a options=(
"alacrity - $CONFDIR/alacritty/alacritty.yml"
"dunst - $CONFDIR/dunst/dunstrc"
"picom - $CONFDIR/picom/picom.conf"
"qtile - $CONFDIR/qtile/config.py"
"awesome - $CONFDIR/awesome/rc.lua"
"awesome-theme - $CONFDIR/awesome/theme.lua"
"autostart - $CONFDIR/qtile/autostart.sh"
"zsh-prompt - $CONFDIR/zsh/zsh-prompt"
"zsh-aliases - $CONFDIR/zsh/zsh-aliases"
"zsh-functions - $CONFDIR/zsh/zsh-functions"
"zsh-exports - $CONFDIR/zsh/zsh-exports"
"README - $HOME/My-dotfiles/README.md"
"fehbg - $HOME/.fehbg"
"xinitrc - $HOME/.xinitrc"
"zshrc - $HOME/.zshrc"
"QUIT"
)

choice=$( printf "%s\n" "${options[@]}" | rofi -dmenu -p Edit -theme ~/.config/rofi_awesome/configs/style-1_configs.rasi) 

if [ "$choice" == "QUIT" ]; then
  echo "Program terminated" && exit 1
elif [ "$choice" ]; then
  config=$(printf "%s\n" "${choice}" | awk '{print $NF}')
  alacritty -e $ED $config 
fi
