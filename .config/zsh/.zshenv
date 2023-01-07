# {{{ Skip system files

setopt noglobalrcs

# }}}

# {{{ Includes

: "${XDG_CONFIG_HOME:=${HOME}/.config}"
# shellcheck source=/dev/null
. "${ENV:-${XDG_CONFIG_HOME}/sh/profile}"

# }}}

# {{{ zsh

ZDOTDIR="${XDG_CONFIG_HOME}/zsh"; export ZDOTDIR

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
