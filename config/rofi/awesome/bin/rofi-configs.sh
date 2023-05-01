#!/bin/bash

# Variables
dotdir=$HOME/dotfiles
confdif=$HOME/.config
scriptd=$HOME/.local/bin
arofidir=$HOME/.config/rofi/awesome/bin
drofidir=$HOME/.config/rofi/dwm/bin
qrofidir=$HOME/.config/rofi/qtile/bin
alcdir=$HOME/.config/alacritty
awmdir=$HOME/.config/awesome
dstdir=$HOME/.config/dunst
dwmdir=$HOME/.config/dwm
fehdir=$HOME/.config/feh
pcmdir=$HOME/.config/picom
qtldir=$HOME/.config/qtile
zshdir=$HOME/.config/zsh
bindir=$HOME/.local/bin
ed="nvim"

# Code
declare -a options=(
"alacrity_a.yml - $alcdir/alacritty_a.yml"
"alacrity_d.yml - $alcdir/alacritty_d.yml"
"alacrity_q.yml - $alcdir/alacritty_q.yml"
"alacrity_scratchpad.yml - $alcdir/alacritty_scratchpad.yml"
"launcher_bin_a.sh - $arofidir/launcher_bin.sh"
"launcher_bin_d.sh - $drofidir/launcher_bin.sh"
"launcher_bin_q.sh - $qrofidir/launcher_bin.sh"
"rofi-wiki_a.sh - $arofidir/rofi-wiki.sh"
"rofi-wiki_d.sh - $drofidir/rofi-wiki.sh"
"rofi-wiki_q.sh - $qrofidir/rofi-wiki.sh"
"launcher_a.sh - $arofidir/launcher.sh"
"launcher_d.sh - $drofidir/launcher.sh"
"launcher_q.sh - $qrofidir/launcher.sh"
"powermenu_a.sh - $arofidir/powermenu.sh"
"powermenu_d.sh - $drofidir/powermenu.sh"
"powermenu_q.sh - $qrofidir/powermenu.sh"
"rofi-configs_a.sh - $arofidir/rofi-configs.sh"
"rofi-configs_d.sh - $drofidir/rofi-configs.sh"
"rofi-configs_q.sh - $qrofidir/rofi-configs.sh"
"rofi-emoji_a.sh - $arofidir/rofi-emoji.sh"
"rofi-emoji_d.sh - $drofidir/rofi-emoji.sh"
"rofi-emoji_q.sh - $qrofidir/rofi-emoji.sh"
"rofi-calc_a.sh - $arofidir/rofi-calc.sh"
"rofi-calc_d.sh - $drofidir/rofi-calc.sh"
"rofi-calc_q.sh - $qrofidir/rofi-calc.sh"
"screenshot_a.sh - $arofidir/screenshot.sh"
"screenshot_d.sh - $drofidir/screenshot.sh"
"screenshot_q.sh - $qrofidir/screenshot.sh"
"quicklinks_a.sh - $arofidir/quicklinks.sh"
"quicklinks_d.sh - $drofidir/quicklinks.sh"
"quicklinks_q.sh - $qrofidir/quicklinks.sh"
"dunstrc_a.sh - $dstdir/dunstrc_a"
"dunstrc_d.sh - $dstdir/dunstrc_d"
"dunstrc_q.sh - $dstdir/dunstrc_q"
"picom_a.conf - $pcmdir/picom_a.conf"
"picom_d.conf - $pcmdir/picom_d.conf"
"picom_q.conf - $pcmdir/picom_q.conf"
"break-notifier.sh - $scriptd/break-notifier.sh"
"dunst-close.sh - $scriptd/dunst-close.sh"
"dwm-audio.sh - $scriptd/dwm-audio.sh"
"dwm-back.sh- $scriptd/dwm-back.sh"
"dwm-bat.sh $scriptd/dwm-bat.sh"
"dwm-cpu.sh $scriptd/dwm-cpu.sh"
"dwm-date.sh- $scriptd/dwm-date.sh"
"dwm-disk.sh- $scriptd/dwm-disk.sh"
"dwm-krnl.sh- $scriptd/dwm-krnl.sh"
"dwm-mem.sh $scriptd/dwm-mem.sh"
"dwm-temp.sh- $scriptd/dwm-temp.sh"
"dwm-xkb.sh $scriptd/dwm-xkb.sh"
"mice-mute.sh - $scriptd/mice-mute.sh"
"net-checker.sh - $scriptd/net-checker.sh"
"prep_a.sh - $scriptd/prep_a.sh"
"prep_d.sh - $scriptd/prep_d.sh"
"prep_q.sh - $scriptd/prep_q.sh"
"updates.sh - $scriptd/updates.sh"
"xprop-info.sh - $scriptd/xprop-info.sh"
"dwm.c - $dwmdir/dwm.c"
"config.def.h - $dwmdir/config.def.h"
"rc.lua - $awmdir/rc.lua"
"theme.lua - $awmdir/theme.lua"
"config.py - $qtldir/config.py"
"zshrc - $HOME/.zshrc"
"zprofile - $HOME/.zprofile"
"zsh-prompt - $zshdir/zsh-prompt"
"zsh-aliases - $zshdir/zsh-aliases"
"zsh-functions - $zshdir/zsh-functions"
"zsh-exports - $zshdir/zsh-exports"
"README.md - $dotdir/README.md"
"pkg-fetch.sh - $dotdir/Scripts/pkg-fetch.sh"
"dots-check.sh - $dotdir/Scripts/dots-check.sh"
"dots-update.sh - $dotdir/Scripts/dots-update.sh"
"fehbg_a - $fehdir/fehbg_a"
"fehbg_d - $fehdir/fehbg_a"
"fehbg_q - $fehdir/fehbg_a"
"Xresources = $HOME/.Xresources"
"xinitrc_a - $HOME/.xinitrc_a"
"xinitrc_d - $HOME/.xinitrc_d"
"xinitrc_q - $HOME/.xinitrc_q"
"bashrc - $HOME/.bashrc"
"bash_profile - $HOME/.bash_profile"
"QUIT"
)

choice=$(printf "%s\n" "${options[@]}" | sort | rofi -dmenu -p Edit -theme ~/.config/rofi/configs/ed_config.rasi)

if [ "$choice" == "QUIT" ]; then
  echo "Program terminated" && exit 1
elif [ "$choice" ]; then
  config=$(printf "%s\n" "${choice}" | awk '{print $NF}')
  alacritty -e $ed $config
fi
