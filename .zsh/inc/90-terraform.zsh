# {{{ Terraform

TFENV_ROOT="${HOME}/.local/tfenv"
if [[ -d "${TFENV_ROOT}" ]]; then
  path=("${TFENV_ROOT}/bin" ${path})
  export PATH
fi

if command -v terraform >/dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C $(command -v terraform) terraform
fi

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
