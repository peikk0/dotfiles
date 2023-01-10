# {{{ Kubernetes

alias k="kubectl"

kx() {
  local _italic="$(tput sitm)"
  local _fg_blue="$(tput setaf 4)"
  local _fg_magenta="$(tput setaf 5)"
  local _fg_cyan="$(tput setaf 6)"
  local _reset="$(tput sgr0)"
  # kubectx with tmux popup and shorter context names for GKE
  local choice="$(_KUBECTX_FORCE_COLOR=1 kubectx | sed -re "s/gke_(.+)_(.+)_(.+)/\\3 ${_italic}${_fg_blue}[GKE:${_fg_cyan}\\1${_fg_blue}:${_fg_magenta}\\2${_fg_blue}]${_reset}/" | fzf-tmux -p 25%,50% --ansi --no-preview)"
  kubectx "$(kubectl config get-contexts -o=name | grep -E "^(gke_.+_)?${choice%% *}\$")"
}

export KUBECTX_CURRENT_BGCOLOR="$(tput setab 0)"
export KUBECTX_CURRENT_FGCOLOR="$(tput setaf 6)"

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
