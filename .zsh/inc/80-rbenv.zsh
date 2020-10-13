# {{{ rbenv

load_rbenv() {
  RBENV_ROOT="${HOME}/.local/rbenv"
  path=("${RBENV_ROOT}/bin" ${path})
  export PATH RBENV_ROOT

  eval "$(rbenv init -)"
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
