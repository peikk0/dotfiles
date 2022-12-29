# {{{ goenv

goenv() {
  autoload -U colors; colors

  export GOENV_ROOT="${XDG_DATA_HOME:-${HOME}/.local/share}/goenv"

  if [[ -d "${GOENV_ROOT}/bin" ]]; then
    path=("${GOENV_ROOT}/bin" ${path})
    export PATH
  fi

  if ! command -v goenv >/dev/null 2>&1; then
    echo "${fg[red]}\uF00D${reset_color} goenv not found!" >&2
    return 1
  fi

  unset -f goenv
  eval "$(goenv init -)"
  echo "${fg[green]}\uF00C${reset_color} goenv loaded!"

  if [[ $# -ge 1 ]]; then
    echo "${fg[blue]}❯ goenv $@${reset_color}"
    goenv "$@"
  fi
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
