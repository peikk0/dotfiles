# {{{ Kubernetes

alias k="kubectl"

kubectx() {
  env \
    KUBECTX_CURRENT_BGCOLOR="$(tput setab 0)" \
    KUBECTX_CURRENT_FGCOLOR="$(tput setaf 6)" \
    kubectx "$@"
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
