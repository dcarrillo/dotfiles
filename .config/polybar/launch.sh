#!/usr/bin/env bash

pkill polybar
pkill -f "task_manager --daemon"
while pgrep -u "$(id -u)" -x polybar >/dev/null; do
    sleep 0.5;
done

export TERMINAL_CMD="tilix --profile orange --new-process -e"
export WM_CONTROL="$(dirname "$0")/scripts/switch_window_state"

~/.config/polybar/scripts/task_manager --generate-config 20

for monitor in $(polybar --list-monitors | cut -d":" -f1); do
    export MONITOR=$monitor
    polybar top -c ~/.config/polybar/bar.ini >/dev/null  &
done

until pgrep -u "$(id -u)" -x polybar >/dev/null; do
    sleep 0.5
done

~/.config/polybar/scripts/task_manager --daemon &
