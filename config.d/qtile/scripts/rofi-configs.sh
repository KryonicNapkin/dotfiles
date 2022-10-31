#!/bin/bash
CONFDIR=$HOME/.config
ED="lvim"

declare -a options=(
"alacrity - $CONFDIR/alacritty/alacritty.yml"
"qtile - $CONFDIR/qtile/config.py"
"autostart - $CONFDIR/qtile/autostart.sh"
"zshrc - $HOME/.zshrc"
"zsh-prompt - $CONFDIR/zsh/zsh-prompt"
"zsh-aliases - $CONFDIR/zsh/zsh-aliases"
"zsh-functions - $CONFDIR/zsh/zsh-functions"
"zsh-exports - $CONFDIR/zsh/zsh-exports"
"README.md - $HOME/My-dotfiles/README.md"
"dunst - $CONFDIR/dunst/dunstrc"
"quit"
)

choice=$( printf "%s\n" "${options[@]}" | rofi -dmenu -p Edit -theme ~/.config/rofi/launchers/type-4/style-1_configs.rasi) 

if [ "$choice" == "quit" ]; then
  echo "Program terminated" && exit 1
elif [ "$choice" ]; then
  config=$(printf "%s\n" "${choice}" | awk '{print $NF}')
  alacritty -e $ED $config 
fi
