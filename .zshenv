# {{{ Skip system files

setopt noglobalrcs

# }}}

# {{{ Umask

umask 0022

# }}}

# {{{ Includes

for file in "${ZDOTDIR:-${HOME}}/.sh/inc"/*.sh; do
  # shellcheck source=/dev/null
  . "${file}"
done

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
