#!/usr/bin/env bash

#
# Best effort script to check whenever a plugin pinned by commit has updates.
# plugins.lua must be formatted with stylua before running the script.
#

PLUGINS_DIR="$HOME/.local/share/nvim/site/pack/packer/start"

function check_update() {
    local plugin=$1
    local current_commit=$2
    local last_commit
    local remote_url

    pushd "$PLUGINS_DIR/$plugin" > /dev/null || exit
    last_commit=$(git log -n 1 --pretty=format:"%H" origin/HEAD)
    remote_url=$(git config --get remote.origin.url)
    if [[ "$current_commit" != "$last_commit" ]]; then
        echo -e "Plugin $plugin has a new version $last_commit (the current version is $current_commit)\n\tURL: $remote_url"
    fi

    popd > /dev/null || exit
}

pushd "$HOME/.config/nvim/lua/user" > /dev/null || exit

grep -P "use.*commit" plugins.lua  | cut -f 2,4 -d "\"" | while IFS= read -r line; do
    plugin=$(echo "$line" | cut -f1 -d "\"" | cut -f2 -d "/")
    current_commit=$(echo "$line" | cut -f2 -d "\"")
    check_update "$plugin" "$current_commit"
done

grep -P "^\t*commit" plugins.lua  | cut -f2 -d "\"" | while IFS= read -r current_commit; do
    plugin=$(grep "$current_commit" -B1 plugins.lua | grep -v "$current_commit" | cut -f2 -d "\"" | cut -f2 -d "/")
    check_update "$plugin" "$current_commit"
done

grep -P "^\t*requires.*commit" plugins.lua | cut -f 2,4 -d "\"" | while IFS= read -r line; do
    plugin=$(echo "$line" | cut -f1 -d "\"" | cut -f2 -d "/")
    current_commit=$(echo "$line" | cut -f2 -d "\"")
    check_update "$plugin" "$current_commit"
done

popd > /dev/null || exit
