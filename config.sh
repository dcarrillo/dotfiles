#!/usr/bin/env bash

set -e

copy_dotfiles()
{
    echo "[INFO] Installing dot files..."

    rsync --exclude "dconf/" \
        --exclude ".vscode/" \
        --exclude ".git*" \
        --exclude "$(basename "$0")" \
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

dconf_dumper()
{
    if ! command -v dconf > /dev/null 2>&1; then
        echo "[WARNING] dconf command not found"
        echo ""
        return 1
    else
        for file in dconf/*; do
            dconf_conf=$(grep -E -m1 '^#.+dconf-path=.+$' "$file")
            dconf_path=$(echo "$dconf_conf" | cut -f2 -d "=")

            echo "[INFO] Dumping $dconf_path to $(basename "$file")..."
            printf "%s\n\n" "$dconf_conf" > "$file"
            dconf dump "$dconf_path" >> "$file"
        done
    fi

    echo ""
}

main()
{
    cd "$(dirname "$0")"

    case "$1" in
        --dump-dconf)
            dconf_dumper
        ;;
        --install)
            copy_dotfiles
            dconf_loader
        ;;
        --install-dotfiles)
            copy_dotfiles
        ;;
        --install-dconf)
            dconf_loader
        ;;
        **)
            echo "Usage: $0 <--dump-dconf|--install|--install-dotfiles|--install-dconf>"
        ;;
    esac

    cd - > /dev/null
}

main "$1"

