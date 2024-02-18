# {{{ goenv

_goenv_lazy_load() {
  autoload -U colors; colors

  export GOENV_ROOT="${XDG_DATA_HOME:-${HOME}/.local/share}/goenv"
  export GOENV_GOPATH_PREFIX="${XDG_DATA_DIR:-${HOME}/.local/share}/go"

  if [[ -d "${GOENV_ROOT}/bin" ]]; then
    path=("${GOENV_ROOT}/bin" ${path})
    export PATH
  fi

  unset -f goenv
  if ! command -v goenv >/dev/null 2>&1; then
    echo "${fg[red]}\uF00D${reset_color} goenv not found!" >&2
    goenv() { goenv_lazy_load "$@" }
    return 1
  fi

  eval "$(goenv init -)"
  echo "${fg[green]}\uF00C${reset_color} goenv loaded!"

  if [[ $# -ge 1 ]]; then
    echo "${fg[blue]}❯ goenv $@${reset_color}"
    goenv "$@"
  fi
}

goenv() { _goenv_lazy_load "$@" }

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
