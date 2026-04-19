export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS='-FRXi'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'

shopt -s histappend checkwinsize globstar nocaseglob cdspell dirspell autocd
set -o noclobber

path_add() { case ":$PATH:" in *":$1:"*) ;; *) export PATH="$1:$PATH" ;; esac; }

path_add "$HOME/.local/bin"
path_add "$HOME/.cargo/bin"
