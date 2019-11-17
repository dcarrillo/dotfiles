#!/usr/bin/env bash

set -e

dotfiles()
{
    echo "[INFO] Installing dot files..."

    rsync --exclude "dconf/" \
        --exclude ".vscode/" \
        --exclude ".git*" \
        --exclude "install.sh" \
        --exclude "LICENSE" \
        --exclude "README.md" \
        -hlav --no-perms . ~

    echo ""
}

dconf_loader()
{
    if ! command -v dconf > /dev/null 2>&1; then
        echo "[WARNING] dconf command not found"
        echo ""
        return 1
    else
        for file in dconf/*; do
            echo "[INFO] Loading $(basename "$file") config..."
            dconf_path=$(grep -E -m1 '^#.+dconf-path=.+$' "$file" | cut -f2 -d "=")
            dconf load "$dconf_path" < "$file"
        done
    fi

    echo ""
}

main()
{
    cd "$(dirname "$0")"

    dotfiles
    dconf_loader

    cd - > /dev/null
}

main

