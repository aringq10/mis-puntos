mkcd() {
    mkdir -p -- "$1" && cd -- "$1" || return
}

extract() {
    [ -f "$1" ] || { echo "extract: '$1' is not a file" >&2; return 1; }
    case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz)   tar xzf "$1" ;;
        *.tar.xz|*.txz)   tar xJf "$1" ;;
        *.tar)            tar xf  "$1" ;;
        *.bz2)            bunzip2 "$1" ;;
        *.gz)             gunzip  "$1" ;;
        *.zip)            unzip   "$1" ;;
        *.7z)             7z x    "$1" ;;
        *.rar)            unrar x "$1" ;;
        *) echo "extract: unknown format '$1'" >&2; return 1 ;;
    esac
}

up() {
    local n=${1:-1} p=""
    while [ "$n" -gt 0 ]; do p="../$p"; n=$((n-1)); done
    cd "$p" || return
}

ff() { find . -type f -iname "*$1*"; }
fd() { find . -type d -iname "*$1*"; }

backup() {
    cp -a -- "$1" "$1.bak.$(date +%Y%m%d-%H%M%S)"
}

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

