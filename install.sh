#!/usr/bin/env bash

set -e

function dotfiles()
{
    echo "[INFO] Installing dot files..."

    rsync --exclude "dconf/" \
        --exclude ".vscode/" \
        --exclude "install.sh" \
        --exclude "LICENSE" \
        --exclude "README.md" \
        -hla --no-perms . ~

    echo ""
}

function dconf_loader()
{
    local file
    local dconf_path

    if ! which dconf > /dev/null 2>&1; then
        echo "[WARNING] dconf command not found"
        echo ""
        return 1
    else
        for file in dconf/*; do
            echo -e "[INFO] Loading $(basename $file) config..."
            dconf_path=$(egrep -m1 '^#.+dconf-path=.+$' $file | cut -f2 -d "=")
            dconf load $dconf_path < $file
        done
    fi

    echo ""
}

function main()
{
    cd $(dirname $0)

    dotfiles
    dconf_loader

    cd - > /dev/null
}

main

