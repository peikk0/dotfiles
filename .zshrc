# {{{ Includes

for file in "${ZDOTDIR:-${HOME}}/.zsh/inc"/*.zsh; do
  # shellcheck source=/dev/null
  . "${file}"
done

# }}}

# {{{ Local configuration

if [[ -f "${ZDOTDIR:-${HOME}}/.zshrc.local" ]]; then
  . "${ZDOTDIR:-${HOME}}/.zshrc.local"
fi

# }}}

: # noop

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
