# {{{ mise

mise_lazy_load() {
  autoload -U colors; colors

  unset -f mise
  if ! command -v mise >/dev/null 2>&1; then
    echo "${fg[red]}\uF00D${reset_color} mise not found!" >&2
    mise() { mise_lazy_load "$@" }
    return 1
  fi

  eval "$(mise activate zsh)"
  echo "${fg[green]}\uF00C${reset_color} mise loaded!"

  if [[ $# -ge 1 ]]; then
    echo "${fg[blue]}❯ mise $@${reset_color}"
    mise "$@"
  fi
}

mise() { mise_lazy_load "$@" }

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
