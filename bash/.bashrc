[ -z "$PS1" ] && return

for f in "$HOME"/.config/bash/*.sh; do
    [ -r "$f" ] && . "$f"
done
unset f
