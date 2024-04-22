#!/usr/bin/env bash

[ -f ~/.config/polybar/bar.env ] && . ~/.config/polybar/bar.env

export TERMINAL_CMD=${TERMINAL_CMD:-"kitty --class=info --override='foreground=#c69026' "}
export BROWSER_CMD=${BROWSER_CMD:-"firefox"}
export WM_CONTROL=${WM_CONTROL:-"~/.config/polybar/scripts/switch_window_state"}
export ROFI_THEME=${ROFI_THEME:-orange}

function wait_for_polybar
{
    condition=1
    if [ "$1" = "stopped" ]; then
        condition=0
    fi

    while [ "$(pgrep -u "$(id -u)" -x polybar >/dev/null)" = $condition ]; do
        sleep 0.2
    done
}

function kill_polybar
{
    pkill polybar
    wait_for_polybar stopped
}

function launch_polybar
{
    for monitor in $(polybar --list-monitors | cut -d":" -f1); do
        export MONITOR=$monitor
        polybar top -c ~/.config/polybar/bar.ini >/dev/null  &
    done
    wait_for_polybar started
}

kill_polybar
launch_polybar
