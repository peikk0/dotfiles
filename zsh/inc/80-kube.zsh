# {{{ Kubernetes

alias k="kubectl"

# CTRL-K - kubectx with tmux popup and reformatted context names for GKE
fzf-kubectx-widget() {
  local \
    _italic="$(tput sitm)" \
    _fg_blue="$(tput setaf 4)" \
    _fg_cyan="$(tput setaf 6)" \
    _reset="$(tput sgr0)"
  setopt localoptions pipefail no_aliases 2>/dev/null
  local choice="$(
    _KUBECTX_FORCE_COLOR=1 kubectx \
      | sed -re "s/gke_(.+)_(.+)_(.+)/\\3 ${_fg_blue} ${_italic}\\1:${_fg_cyan}\\2${_reset}/" \
      | fzf-tmux -p 25%,40% --ansi --no-preview --prompt '⎈ '
    )"
  if [[ -z "${choice}" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line
  local context="$(kubectl config get-contexts -o=name | grep -E "^(gke_.+_)?${choice%% *}\$")"
  BUFFER="kubectx ${(q)context}"
  zle accept-line
  local ret=$?
  unset choice context
  zle reset-prompt
  return $ret
}
zle     -N            fzf-kubectx-widget
bindkey -M emacs '^K' fzf-kubectx-widget
bindkey -M vicmd '^K' fzf-kubectx-widget
bindkey -M viins '^K' fzf-kubectx-widget

export KUBECTX_CURRENT_BGCOLOR="$(tput setab 0)"
export KUBECTX_CURRENT_FGCOLOR="$(tput setaf 6)"

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
