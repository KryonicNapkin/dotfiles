#
# ~/.zprofile
#

[[ -f $ZDOTDIR/.zshrc ]] && . $ZDOTDIR/.zshrc
source $ZDOTDIR/.zshrc

if [[ "$(tty)" == /dev/tty1 ]]; then
  exec startx
fi
