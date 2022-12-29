# shellcheck shell=bash

# {{{ Umask

umask 0022

# }}}

# {{{ Includes

for file in "${HOME}/.sh/inc"/*.sh; do
  # shellcheck source=/dev/null
  . "${file}"
done

# }}}

# {{{ Initial check

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

# }}}

# {{{ History

mkdir -p "${XDG_STATE_HOME:-${HOME}/.local/state}/bash"
HISTFILE="${XDG_STATE_HOME:-${HOME}/.local/state}/bash/history"
HISTFILESIZE=5000
HISTSIZE=5000
HISTCONTROL=ignoredups
shopt -s histappend
shopt -s cmdhist

# }}}

# vim:filetype=bash:tabstop=2:shiftwidth=2:fdm=marker:
