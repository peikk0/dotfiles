# {{{ Vault

export VAULT_CONFIG="${XDG_CONFIG_HOME}/vault/config"
export VAULT_PROXY_ADDR="socks5://localhost:18200"
# export VAULT_ADDR="https://vault.host"

typeset -a VAULT_HOSTS

# https://github.com/starkandwayne/safe
if command -v safe >/dev/null; then
  alias safe="HTTPS_PROXY=\"\${VAULT_PROXY_ADDR}\" safe"
fi

vault-target-widget() {
  choice="$(fzf-tmux -p 25%,40% --ansi --no-preview --border-label "Vault Address" <<<${(F)VAULT_HOSTS})"

  if [[ -z "${choice}" ]]; then
    zle redisplay
    return 0
  fi

  zle push-line
  BUFFER="export VAULT_ADDR='https://${choice}'"
  zle accept-line
  local ret=$?
  unset choice
  zle reset-prompt
  return $ret
}
zle     -N              vault-target-widget
bindkey -M emacs '^V^T' vault-target-widget
bindkey -M vicmd '^V^T' vault-target-widget
bindkey -M viins '^V^T' vault-target-widget

vault-login-widget() {
  autoload -U colors && colors
  role="${1:-user}"

  if [[ -z "${VAULT_ADDR:-}" ]]; then
      zle redisplay
      return 0
  fi

  if [[ -n "${TMUX:-}" ]]; then
    zle redisplay
    tmux display-popup -E -h 20 "
      printf %b '${fg[blue]}[vault]${reset_color} Logging into Vault at ${fg[cyan]}${VAULT_ADDR}${reset_color} with role ${fg[magenta]}${role}${reset_color}...\n';
      vault login -no-print -address '${VAULT_ADDR}' -method oidc role='${role}' || read
      "
    return 0
  else
    zle push-line
    echo "${fg[blue]}[vault]${reset_color} Logging into Vault at ${fg[cyan]}${VAULT_ADDR}${reset_color} with role ${fg[magenta]}${role}${reset_color}...";
    BUFFER="vault login -no-print -method oidc role='${role}'"
    zle accept-line
    local ret=$?
  fi

  zle reset-prompt
  return $ret
}
zle     -N              vault-login-widget
bindkey -M emacs '^V^L' vault-login-widget
bindkey -M vicmd '^V^L' vault-login-widget
bindkey -M viins '^V^L' vault-login-widget

vault-login-widget-admin() {
  vault-login-widget admin
}
zle     -N              vault-login-widget-admin
bindkey -M emacs '^V^K' vault-login-widget-admin
bindkey -M vicmd '^V^K' vault-login-widget-admin
bindkey -M viins '^V^K' vault-login-widget-admin

# The following widget works with this SSH configuration:
#
# Host vault-proxy
#     Hostname some.bastion.host
#     CanonicalizeHostname yes
#     DynamicForward 18200
#     ExitOnForwardFailure yes
#     PermitLocalCommand yes
#     RemoteCommand printf '%%b' '\r\e[34m[vault]\e[0m SOCKS5 Proxy via \e[36m%h\e[0m opened! Press Enter to disconnect.'; read

vault-proxy-widget() {
  autoload -U colors && colors

  if [[ -n "${TMUX:-}" ]]; then
    zle redisplay
    tmux split-window -d -v -l 2 "
      printf %b '${fg[blue]}[vault]${fg[yellow]} 󱥸 Opening SOCKS5 proxy...${reset_color}';
      ssh vault-proxy
      "
    return 0
  else
    zle push-line
    BUFFER="ssh vault-proxy"
    zle accept-line
    local ret=$?
  fi

  zle reset-prompt
  return $ret
}
zle     -N              vault-proxy-widget
bindkey -M emacs '^V^P' vault-proxy-widget
bindkey -M vicmd '^V^P' vault-proxy-widget
bindkey -M viins '^V^P' vault-proxy-widget

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
