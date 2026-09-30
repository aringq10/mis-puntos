#!/usr/bin/bash

set -e

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

confirm() {
    read -rp "$1 [y/N] " answer
    [[ "$answer" =~ ^[Yy]$ ]]
}

safe_symlink() {
    local target
    target=$(realpath "$1")
    local link="$2"

    if [ -L "$link" ]; then
        # Existing symlink
        local current
        current=$(readlink "$link")
        read -rp "Symlink '$link' already exists (-> $current). Overwrite? [y/N] " answer
        [[ "$answer" =~ ^[Yy]$ ]] || { echo "Skipped."; return 0; }
        ln -sfn "$target" "$link"
        echo "Replaced symlink: $link -> $target"

    elif [ -d "$link" ]; then
        # Real directory
        read -rp "Directory '$link' exists. Replace it with a symlink? [y/N] " answer
        [[ "$answer" =~ ^[Yy]$ ]] || { echo "Skipped."; return 0; }
        rm -rf "$link"
        ln -s "$target" "$link"
        echo "Replaced directory with symlink: $link -> $target"

    elif [ -e "$link" ]; then
        # Regular file or something else
        read -rp "File '$link' exists. Overwrite with symlink? [y/N] " answer
        [[ "$answer" =~ ^[Yy]$ ]] || { echo "Skipped."; return 0; }
        rm -f "$link"
        ln -s "$target" "$link"
        echo "Replaced file with symlink: $link -> $target"

    else
        # Nothing there
        ln -s "$target" "$link"
        echo "Created symlink: $link -> $target"
    fi
}

if confirm "Bootstrap Neovim?"; then
    safe_symlink ./nvim ~/.config/nvim
fi

if confirm "Bootstrap Yazi?"; then
    safe_symlink ./yazi ~/.config/yazi
fi

if confirm "Bootstrap Kitty?"; then
    safe_symlink ./kitty ~/.config/kitty
fi

if confirm "Bootstrap Bash?"; then
    safe_symlink ./bash/.bashrc ~/.bashrc
    safe_symlink ./bash/.bash_profile ~/.bash_profile
fi
