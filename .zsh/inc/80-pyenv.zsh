# {{{ pyenv

load_pyenv() {
  PYENV_ROOT="${HOME}/.local/pyenv"
  path=("${PYENV_ROOT}/bin" ${path})
  export PATH PYENV_ROOT

  eval "$(pyenv init -)"
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
