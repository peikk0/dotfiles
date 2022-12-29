# {{{ pyenv

pyenv() {
  autoload -U colors; colors

  export PYENV_ROOT="${XDG_DATA_HOME:-${HOME}/.local/share}/pyenv"

  if [[ -d "${PYENV_ROOT}/bin" ]]; then
    path=("${PYENV_ROOT}/bin" ${path})
    export PATH
  fi

  if ! command -v pyenv >/dev/null 2>&1; then
    echo "${fg[red]}\uF00D${reset_color} pyenv not found!" >&2
    return 1
  fi

  unset -f pyenv
  eval "$(pyenv init -)"
  echo "${fg[green]}\uF00C${reset_color} pyenv loaded!"

  if [[ $# -ge 1 ]]; then
    echo "${fg[blue]}❯ pyenv $@${reset_color}"
    pyenv "$@"
  fi
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
