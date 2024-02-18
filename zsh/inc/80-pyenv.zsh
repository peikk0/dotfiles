# {{{ pyenv

_pyenv_lazy_load() {
  autoload -U colors; colors

  export PYENV_ROOT="${XDG_DATA_HOME:-${HOME}/.local/share}/pyenv"

  if [[ -d "${PYENV_ROOT}/bin" ]]; then
    path=("${PYENV_ROOT}/bin" ${path})
    export PATH
  fi

  unset -f pyenv
  if ! command -v pyenv >/dev/null 2>&1; then
    echo "${fg[red]}\uF00D${reset_color} pyenv not found!" >&2
    pyenv() { pyenv_lazy_load "$@" }
    return 1
  fi

  eval "$(pyenv init -)"
  echo "${fg[green]}\uF00C${reset_color} pyenv loaded!"

  if [[ $# -ge 1 ]]; then
    echo "${fg[blue]}❯ pyenv $@${reset_color}"
    pyenv "$@"
  fi
}

pyenv() { _pyenv_lazy_load "$@" }

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
