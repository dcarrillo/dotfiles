#!/usr/bin/env bash

[ -f ~/.config/polybar/bar.env ] && . ~/.config/polybar/bar.env

export TERMINAL_CMD=${TERMINAL_CMD:-"tilix --profile orange --new-process -e"}
export WM_CONTROL=${WM_CONTROL:-"~/.config/polybar/scripts/switch_window_state"}
export TASKMANAGER_MAX_TASKS=${TASKMANAGER_MAX_TASKS:-20}

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
    pkill -f "task_manager --daemon"
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
~/.config/polybar/scripts/task_manager --generate-config "$TASKMANAGER_MAX_TASKS"
launch_polybar
~/.config/polybar/scripts/task_manager --daemon &
