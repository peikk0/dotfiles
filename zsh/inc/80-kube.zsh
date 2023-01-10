# {{{ Kubernetes

alias k="kubectl"

kx() {
  # kubectx with tmux popup and shorter context names for GKE
  local choice="$(_KUBECTX_FORCE_COLOR=1 kubectx | sed -re 's/gke_(.+)_(.+)_(.+)/\3 [GKE:\1:\2]/' | fzf-tmux -p 25%,50% --ansi --no-preview)"
  kubectx "$(kubectl config get-contexts -o=name | grep -E "^(gke_.+_)?${choice%% *}\$")"
}

export KUBECTX_CURRENT_BGCOLOR="$(tput setab 0)"
export KUBECTX_CURRENT_FGCOLOR="$(tput setaf 6)"

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
