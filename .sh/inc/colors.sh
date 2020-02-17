# {{{ Base16

if [ -t 1 ] && [ "$-" != "*i*" ]; then
  # Base16 Shell
  BASE16_SCHEME="default-dark"
  BASE16_SHELL="${HOME}/.config/base16-shell/scripts/base16-${BASE16_SCHEME}.sh"
  # shellcheck source=/dev/null
  [ -s "${BASE16_SHELL}" ] && . "${BASE16_SHELL}"
fi

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
