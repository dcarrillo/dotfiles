#!/usr/bin/env bash

killall -q polybar
while pgrep -u "$(id -u)" -x polybar >/dev/null; do sleep 1; done

export TERMINAL_CMD="tilix --profile orange --new-process -e"
WM_CONTROL="$(dirname "$0")/scripts/switch_window_state"
export WM_CONTROL

for monitor in $(polybar --list-monitors | cut -d":" -f1); do
    export MONITOR=$monitor
    polybar top -c ~/.config/polybar/bar.ini >/dev/null  &
done

