# {{{ Includes

for file in "${ZDOTDIR}/inc"/*.zsh; do
  # shellcheck source=/dev/null
  . "${file}"
done

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
