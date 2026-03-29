#!/usr/bin/env bash

xrandr_info=$(xrandr --query | sed -nre 's/^([A-Z0-9-]+) connected primary ([0-9]+)x([0-9]+)\+.+$/\1 \2 \3/p')
read -r monitor width height <<<"${xrandr_info}"

export MONITOR="${monitor}"
export BAR_WIDTH=$(( width - 16 ))

polybar-msg cmd quit >/dev/null 2>&1
nohup polybar > "${XDG_CACHE_HOME:-${HOME}/.cache}/polybar.log" 2>&1 &
exit $?
