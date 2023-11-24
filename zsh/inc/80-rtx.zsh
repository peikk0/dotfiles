# {{{ rtx

rtx_lazy_load() {
  autoload -U colors; colors

  unset -f rtx
  if ! command -v rtx >/dev/null 2>&1; then
    echo "${fg[red]}\uF00D${reset_color} rtx not found!" >&2
    rtx() { rtx_lazy_load "$@" }
    return 1
  fi

  eval "$(rtx activate zsh)"
  echo "${fg[green]}\uF00C${reset_color} rtx loaded!"

  if [[ $# -ge 1 ]]; then
    echo "${fg[blue]}❯ rtx $@${reset_color}"
    rtx "$@"
  fi
}

rtx() { rtx_lazy_load "$@" }

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
