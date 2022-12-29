# {{{ rbenv

rbenv() {
  autoload -U colors; colors

  export RBENV_ROOT="${XDG_DATA_HOME:-${HOME}/.local/share}/rbenv"

  if [[ -d "${RBENV_ROOT}/bin" ]]; then
    path=("${RBENV_ROOT}/bin" ${path})
    export PATH
  fi

  if ! command -v rbenv >/dev/null 2>&1; then
    echo "${fg[red]}\uF00D${reset_color} rbenv not found!" >&2
    return 1
  fi

  unset -f rbenv
  eval "$(rbenv init -)"
  echo "${fg[green]}\uF00C${reset_color} rbenv loaded!"

  if [[ $# -ge 1 ]]; then
    echo "${fg[blue]}❯ rbenv $@${reset_color}"
    rbenv "$@"
  fi
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
