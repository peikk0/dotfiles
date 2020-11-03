# {{{ goenv

load_goenv() {
  if [[ -d "${HOME}/.local/goenv" ]]; then
    GOENV_ROOT="${HOME}/.local/goenv"
    path=("${GOENV_ROOT}/bin" ${path})
    export PATH GOENV_ROOT
  fi

  if command -v goenv >/dev/null 2>&1; then
    eval "$(goenv init -)"
  else
    echo "goenv not found!" >&2
  fi
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
