# {{{ pyenv

load_pyenv() {
  if [[ -d "${HOME}/.local/pyenv" ]]; then
    PYENV_ROOT="${HOME}/.local/pyenv"
  elif [[ -d "${HOME}/.pyenv" ]]; then
    PYENV_ROOT="${HOME}/.pyenv"
  fi
  if [[ -n "${PYENV_ROOT}" ]]; then
    path=("${PYENV_ROOT}/bin" ${path})
    export PATH PYENV_ROOT
  fi

  if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
  else
    echo "pyenv not found!" >&2
  fi
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
