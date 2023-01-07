# {{{ Skip system files

setopt noglobalrcs

# }}}

# {{{ Includes

# shellcheck source=/dev/null
. "${HOME}/.profile"

# }}}

# {{{ zsh

ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"; export ZDOTDIR

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
