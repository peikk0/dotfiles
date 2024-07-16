# The following widget works with this SSH configuration:
#
# Host vault-proxy
#     Hostname some.bastion.host
#     CanonicalizeHostname yes
#     DynamicForward 18200
#     ExitOnForwardFailure yes
#     PermitLocalCommand yes
#     RemoteCommand printf '%%b' '\r\e[34m[vault]\e[0m SOCKS5 Proxy via \e[36m%h\e[0m opened! Press Enter to disconnect.'; read

function vault-proxy-widget --description "Spawn a SSH proxy for Vault in a Tmux pane (if possible)"
  if set -q TMUX
    tmux split-window -d -v -l 2 "
      printf %b '$(set_color blue)"'[vault]'"$(set_color yellow) 󱥸 Opening SOCKS5 proxy...$(set_color normal)';
      ssh vault-proxy
      "
    return
  else
    commandline -r "ssh vault-proxy"
    commandline -f execute
  end
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
