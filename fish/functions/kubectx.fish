function kubectx --description "Kubectx with Nord colors"
  set -lx KUBECTX_CURRENT_BGCOLOR (tput setab 0)
  set -lx KUBECTX_CURRENT_FGCOLOR (tput setaf 6)
  command kubectx $argv
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
