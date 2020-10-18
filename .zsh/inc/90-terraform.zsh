# {{{ Terraform

TFENV_ROOT="${HOME}/.local/tfenv"
if [[ -d "${TFENV_ROOT}" ]]; then
  path=("${TFENV_ROOT}/bin" ${path})
  export PATH

  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "${TFENV_ROOT}/bin/terraform" terraform
fi

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
