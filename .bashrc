#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[t@m][\W] -> '

export QT_QPA_PLATFORMTHEME=qt5ct
export ZDOTDIR=$HOME/.config/zsh/
export BROWSER='brave'
export EDITOR='lvim'
. "$HOME/.cargo/env"
