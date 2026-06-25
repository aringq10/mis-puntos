[ -f /usr/share/bash-completion/completions/git ] && \
    source /usr/share/bash-completion/completions/git

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'

alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# alias rm='rm -i'
alias rm='echo "This is not the command you are looking for."; false'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ..='cd ..'

alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'
alias gb='git branch -a'
alias gco='git checkout'
__git_complete gco _git_checkout
alias gcm='git commit -m'
alias gp='git pull'
alias gP='git push'

alias please='sudo $(fc -ln -1)'
alias path='echo -e "${PATH//:/\\n}"'
alias ports='ss -tulnp'
alias reload='. ~/.bashrc'

alias claude='claude; reset'
alias ssh='kitten ssh'
