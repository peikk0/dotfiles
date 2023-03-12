# {{{ Kubernetes

alias k="kubectl"

kubectx() {
  env \
    KUBECTX_CURRENT_BGCOLOR="$(tput setab 0)" \
    KUBECTX_CURRENT_FGCOLOR="$(tput setaf 6)" \
    kubectx "$@"
}

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
zle     -N              fzf-kubectx-widget
bindkey -M emacs '^K^X' fzf-kubectx-widget
bindkey -M vicmd '^K^X' fzf-kubectx-widget
bindkey -M viins '^K^X' fzf-kubectx-widget

# The following widget works with this SSH configuration:
#
# Host kube-proxy:*
#     CanonicalizeHostname yes
#     ExitOnForwardFailure yes
#     PermitLocalCommand yes
#     RemoteCommand printf '%%b' '\r\e[34m[kube]\e[0m SOCKS5 Proxy via \e[36m%h\e[0m opened! Press Enter to disconnect.'; read
#
# Host kube-proxy:gke_some-project_*
#     Hostname some.bastion.host
#     DynamicForward 1080
#     LocalCommand kubectl config set clusters.$(echo "%n" | cut -d: -f2).proxy-url socks5://localhost:1080 >/dev/null

kube-proxy-widget() {
  autoload -U colors && colors

  local ssh_proxy_host="kube-proxy:$(kubectl config current-context)"

  if [[ -n "${TMUX:-}" ]]; then
    zle redisplay
    tmux split-window -d -v -l 2 "
      printf %b '${fg[blue]}[kube]${reset_color} Opening SOCKS5 proxy ${fg[cyan]}${ssh_proxy_host}${reset_color}...';
      ssh ${(q)ssh_proxy_host}
      "
    return 0
  else
    zle push-line
    BUFFER="ssh ${(q)ssh_proxy_host}"
    zle accept-line
    local ret=$?
  fi

  unset ssh_proxy_host
  zle reset-prompt
  return $ret
}
zle     -N              kube-proxy-widget
bindkey -M emacs '^K^P' kube-proxy-widget
bindkey -M vicmd '^K^P' kube-proxy-widget
bindkey -M viins '^K^P' kube-proxy-widget

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
