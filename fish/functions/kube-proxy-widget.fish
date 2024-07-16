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

function kube-proxy-widget --description "Spawn a SSH proxy for kubectl in a Tmux pane (if possible)"
  set -l ssh_proxy_host "kube-proxy:$(kubectl config current-context)"

  if set -q TMUX
    tmux split-window -d -v -l 2 "
      printf %b '$(set_color blue)"'[kube]'"$(set_color yellow) 󱥸 Opening SOCKS5 proxy $(set_color cyan)$ssh_proxy_host$(set_color yellow)...$(set_color normal)';
      ssh $(string escape $ssh_proxy_host)
      "
    return
  else
    commandline -r "ssh $ssh_proxy_host"
    commandline -f execute
  end
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
