#!/usr/bin/env bash

cd $(dirname $0)

echo "Installing dot files..."

rsync --exclude "dconf/" \
      --exclude ".vscode/" \
      --exclude "install.sh" \
      --exclude "LICENSE" \
      --exclude "README.md" \
      -hla --no-perms . ~

echo ""

if which dconf >/dev/null 2>&1; then
    echo -e "[INFO] Loading tilix config..."
    dconf load /com/gexperts/Tilix/ < dconf/tilix.ini
else
    echo "[WARNING] dconf command not found"
fi

echo ""

cd - > /dev/null

