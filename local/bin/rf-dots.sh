#!/bin/bash

# Debugging
# set -xe

# Imports
. ~/.local/share/univ/vars

# Variables
ed="nvim"

# Start of Code
declare -a options=(
    "alacrity_a.yml - $alattyd/alacritty_a.yml"
    "alacrity_d.yml - $alattyd/alacritty_d.yml"
    "alacrity_q.yml - $alattyd/alacritty_q.yml"
    "alacrity_scratchpad.yml - $alattyd//alacritty_scratchpad.yml"
    "template - $shared/univ/template"
    "vars - $shared/univ/vars"
    "dunstrc_a.sh - $dunstd/dunstrc_a"
    "dunstrc_d.sh - $dunstd/dunstrc_d"
    "dunstrc_q.sh - $dunstd/dunstrc_q"
    "picom_a.conf - $picomd/picom_a.conf"
    "picom_d.conf - $picomd/picom_d.conf"
    "picom_q.conf - $picomd/picom_q.conf"
    "break-notifier.sh - $scriptd/break-notifier.sh"
    "dunst-close.sh - $scriptd/dunst-close.sh"
    "dmenu.rasi - $rofid/dmenu.rasi"
    "onedark.rasi - $rofid/onedark.rasi"
    "dracula.rasi - $rofid/dracula.rasi"
    "rf-bin.sh - $scriptd/rf-bin.sh"
    "rf-clip.sh - $scriptd/rf-clip.sh"
    "rf-dots.sh - $scriptd/rf-dots.sh"
    "rf-man.sh - $scriptd/dm-man.sh"
    "rf-pkginf.sh - $scriptd/dm-pkginf.sh"
    "rf-pwr.sh - $scriptd/dm-pwr.sh"
    "rf-qkl.sh - $scriptd/dm-qkl.sh"
    "rf-run.sh - $scriptd/dm-run.sh"
    "rf-scpwiki.sh - $scriptd/dm-scpwiki.sh"
    "rf-scrt.sh - $scriptd/dm-scrt.sh"
    "rf-wiki.sh - $scriptd/dm-wiki.sh"
    "rf-win.sh - $scriptd/dm-win.sh"
    "rf-wmch.sh - $scriptd/dm-wmch.sh"
    "dm-bin.sh - $scriptd/dm-bin.sh"
    "dm-clip.sh - $scriptd/dm-clip.sh"
    "dm-dots.sh - $scriptd/dm-dots.sh"
    "dm-man.sh - $scriptd/dm-man.sh"
    "dm-pkginf.sh - $scriptd/dm-pkginf.sh"
    "dm-pwr.sh - $scriptd/dm-pwr.sh"
    "dm-qkl.sh - $scriptd/dm-qkl.sh"
    "dm-run.sh - $scriptd/dm-run.sh"
    "dm-scpwiki.sh - $scriptd/dm-scpwiki.sh"
    "dm-scrt.sh - $scriptd/dm-scrt.sh"
    "dm-wiki.sh - $scriptd/dm-wiki.sh"
    "dm-win.sh - $scriptd/dm-win.sh"
    "dm-wmch.sh - $scriptd/dm-wmch.sh"
    "dwm-audio.sh - $scriptd/dwm-audio.sh"
    "dwm-back.sh - $scriptd/dwm-back.sh"
    "dwm-bat.sh - $scriptd/dwm-bat.sh"
    "dwm-cpu.sh - $scriptd/dwm-cpu.sh"
    "dwm-date.sh - $scriptd/dwm-date.sh"
    "dwm-disk.sh - $scriptd/dwm-disk.sh"
    "dwm-krnl.sh - $scriptd/dwm-krnl.sh"
    "dwm-mem.sh - $scriptd/dwm-mem.sh"
    "dwm-temp.sh - $scriptd/dwm-temp.sh"
    "dwm-xkb.sh - $scriptd/dwm-xkb.sh"
    "mice-mute.sh - $scriptd/mice-mute.sh"
    "net-checker.sh - $scriptd/net-checker.sh"
    "prep_a.sh - $scriptd/prep_a.sh"
    "prep_d.sh - $scriptd/prep_d.sh"
    "prep_q.sh - $scriptd/prep_q.sh"
    "updates.sh - $scriptd/updates.sh"
    "xprop-info.sh - $scriptd/xprop-info.sh"
    "dwm.c - $dwmdir/dwm.c"
    "config.def.h - $dwmdir/config.def.h"
    "rc.lua - $awesomed/rc.lua"
    "theme.lua - $awesomed/theme.lua"
    "config.py - $qtiled/config.py"
    "zshrc - $zshdir/.zshrc"
    "zprofile - $HOME/.zprofile"
    "zsh-prompt - $zshdir/zsh-prompt"
    "zsh-aliases - $zshdir/zsh-aliases"
    "zsh-functions - $zshdir/zsh-functions"
    "zsh-exports - $zshdir/zsh-exports"
    "README.md - $dotsdir/README.md"
    "pkg-fetch.sh - $dotsdir/Scripts/pkg-fetch.sh"
    "dots-check.sh - $dotsdir/Scripts/dots-check.sh"
    "dots-update.sh - $dotsdir/Scripts/dots-update.sh"
    "fehbg_a - $fehbgd/fehbg_a"
    "fehbg_d - $fehbgd/fehbg_a"
    "fehbg_q - $fehbgd/fehbg_a"
    "Xresources - $HOME/.Xresources"
    "xinitrc - $HOME/.xinitrc"
    "bashrc - $HOME/.bashrc"
    "bash_profile - $HOME/.bash_profile"
    "QUIT"
)

choice=$(printf "%s\n" "${options[@]}" | sort | $rfdmdpy "Edit:")

if [ "$choice" == "QUIT" ]; then
    echo "Program terminated" && exit 1
elif [ "$choice" ]; then
    config=$(printf "%s\n" "${choice}" | awk '{print $NF}')
    alacritty -e $ed $config
fi
