#!/bin/sh

polybar-msg cmd quit >/dev/null 2>&1
nohup polybar > "${XDG_CACHE_HOME:-${HOME}/.cache}/polybar.log" 2>&1 &
exit $?
