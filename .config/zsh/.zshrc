zshdir="$HOME/.config/zsh/"
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zap-zsh/vim"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
compinit

source $zshdir/zsh-aliases
source $zshdir/zsh-prompt
source $zshdir/zsh-exports
export EMSDK_QUIET=1
source "$HOME/.emsdk/emsdk_env.sh"

# z (better cd)
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
