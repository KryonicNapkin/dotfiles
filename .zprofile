#
# ~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc
source ~/.zshrc

if [[ "$(tty)" == /dev/tty1 ]]; then
  exec startx
fi
