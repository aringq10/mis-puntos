[ -z "$PS1" ] && return

BASH_CONFIG_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/config"

for f in "$BASH_CONFIG_DIR"/*.sh; do
    [ -r "$f" ] && . "$f"
done
unset f
