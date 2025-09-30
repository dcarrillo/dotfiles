#!/usr/bin/env bash

POLYBAR_PATH=~/.config/polybar

[ -f $POLYBAR_PATH/bar.env ] && . $POLYBAR_PATH/bar.env

export TERMINAL_CMD=${TERMINAL_CMD:-"kitty --class=info --override='foreground=#c69026' "}
export BROWSER_CMD=${BROWSER_CMD:-"firefox"}
export WM_CONTROL=${WM_CONTROL:-"$POLYBAR_PATH/scripts/switch_window_state"}
export ROFI_THEME=${ROFI_THEME:-orange}

function wait_for_polybar
{
    condition=1
    if [ "$1" = "stopped" ]; then
        condition=0
    fi

    while [ "$(pgrep -u "$(id -u)" -x polybar >/dev/null)" = $condition ]; do
        sleep 1
    done
}

function kill_polybar
{
    pkill polybar
    wait_for_polybar stopped
}

function compile_src
{
    pushd $POLYBAR_PATH/scripts/src/polytasks > /dev/null || return
    echo "Compiling polytasks..."
    go build -buildvcs=false -ldflags="-s -w" -o $POLYBAR_PATH/scripts/polytasks .
    popd > /dev/null || return
}

function launch_polybar
{
    compile_src
    for monitor in $(polybar --list-monitors | cut -d":" -f1); do
        export MONITOR=$monitor
        polybar top -c $POLYBAR_PATH/bar.ini >/dev/null  &
    done
    wait_for_polybar started
}

kill_polybar
launch_polybar
