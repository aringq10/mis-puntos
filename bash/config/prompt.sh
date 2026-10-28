PROMPT_COMMAND='__last_exit=$?; '"${PROMPT_COMMAND:-}"

# last cmd exit code
__prompt_exit() {
    [ "${__last_exit:-0}" -ne 0 ] && printf ' [%d]' "$__last_exit"
}

C_ERR='\[\e[31m\]'
TC="243" # text
UC="45"  # user
HC="45"  # host
PC="220" # path
RS="\[\e[m\]"
TC="\[\e[38;5;${TC}m\]"
UC="\[\e[38;5;${UC}m\]"
HC="\[\e[38;5;${HC}m\]"
PC="\[\e[38;5;${PC}m\]"

PS1="${UC}\\u${TC}@${HC}\\H ${TC}[${PC}\\w${TC}]${C_ERR}\$(__prompt_exit)${RS}\\n$ "

unset TC UC HC PC RS C_ERR
