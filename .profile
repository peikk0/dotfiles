# {{{ Umask

umask 0022

# }}}

# {{{ Includes

for file in "${HOME}/.sh/inc"/*.sh; do
  # shellcheck source=/dev/null
  . "${file}"
done

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
