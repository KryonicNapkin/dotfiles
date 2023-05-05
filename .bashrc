#
# ~/.bashrc
#

echo -ne '\e[2 q'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
