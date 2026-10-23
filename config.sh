#!/usr/bin/env bash

set -e

copy_dotfiles()
{
    echo "[INFO] Installing dot files..."

    rsync --exclude ".git*" \
        --exclude "$(basename "$0")" \
        --exclude "LICENSE" \
        --exclude "README.md" "$@" \
        -hlav --no-perms . ~

    echo ""
}

main()
{
    pushd "$(dirname "$0")" > /dev/null

    case "$1" in
        --install)
            shift
            copy_dotfiles "$@"
        ;;
        **)
            echo "Usage: $0 <--install>"
        ;;
    esac

    popd > /dev/null
}

main "$@"

