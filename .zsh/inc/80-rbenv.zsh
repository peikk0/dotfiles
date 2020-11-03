# {{{ rbenv

load_rbenv() {
  if [[ -d "${HOME}/.local/rbenv" ]]; then
    RBENV_ROOT="${HOME}/.local/rbenv"
    path=("${RBENV_ROOT}/bin" ${path})
    export PATH RBENV_ROOT
  fi

  if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init -)"
  else
    echo "rbenv not found!" >&2
  fi
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
