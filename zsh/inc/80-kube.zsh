# {{{ Kubernetes

alias k="kubectl"

kx() {
  local \
    _italic="$(tput sitm)" \
    _fg_blue="$(tput setaf 4)" \
    _fg_cyan="$(tput setaf 6)" \
    _reset="$(tput sgr0)"
  # kubectx with tmux popup and reformatted context names for GKE
  local choice="$(
    _KUBECTX_FORCE_COLOR=1 kubectx \
      | sed -re "s/gke_(.+)_(.+)_(.+)/\\3 ${_fg_blue} ${_italic}\\1:${_fg_cyan}\\2${_reset}/" \
      | fzf-tmux -p 25%,50% --ansi --no-preview --prompt '⎈ '
    )"
  kubectx "$(kubectl config get-contexts -o=name | grep -E "^(gke_.+_)?${choice%% *}\$")"
}

export KUBECTX_CURRENT_BGCOLOR="$(tput setab 0)"
export KUBECTX_CURRENT_FGCOLOR="$(tput setaf 6)"

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
