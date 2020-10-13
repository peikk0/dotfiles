# {{{ goenv

load_goenv() {
  GOENV_ROOT="${HOME}/.local/goenv"
  path=("${GOENV_ROOT}/bin" ${path})
  export PATH GOENV_ROOT

  eval "$(goenv init -)"
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
