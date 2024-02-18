# {{{ rbenv

_rbenv_lazy_load() {
  autoload -U colors; colors

  export RBENV_ROOT="${XDG_DATA_HOME:-${HOME}/.local/share}/rbenv"

  if [[ -d "${RBENV_ROOT}/bin" ]]; then
    path=("${RBENV_ROOT}/bin" ${path})
    export PATH
  fi

  unset -f rbenv
  if ! command -v rbenv >/dev/null 2>&1; then
    echo "${fg[red]}\uF00D${reset_color} rbenv not found!" >&2
    rbenv() { rbenv_lazy_load "$@" }
    return 1
  fi

  eval "$(rbenv init -)"
  echo "${fg[green]}\uF00C${reset_color} rbenv loaded!"

  if [[ $# -ge 1 ]]; then
    echo "${fg[blue]}❯ rbenv $@${reset_color}"
    rbenv "$@"
  fi
}

rbenv() { _rbenv_lazy_load "$@" }

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
