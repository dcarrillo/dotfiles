#!/usr/bin/env bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export TERMINAL_CMD="tilix --profile orange --new-process -e"
export WM_CONTROL="$(dirname $0)/scripts/switch_window_state"

for monitor in $(polybar --list-monitors | cut -d":" -f1); do
    export MONITOR=$monitor
    polybar top -c ~/.config/polybar/bar.ini >/dev/null  &
done

