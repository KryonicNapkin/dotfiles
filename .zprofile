#
# ~/.zprofile
#

[[ -f ~/.config/zsh/.zshrc ]] && . ~/.config/zsh/.zshrc
source ~/.config/zsh/.zshrc

if [[ "$(tty)" == /dev/tty1 ]]; then
  exec startx
fi
