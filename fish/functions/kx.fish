function kube_contexts --description "Returns all kubectl contexts with current context at the top"
  set -l current_context (kubectl config current-context)
  echo $current_context
  kubectl config get-contexts -o name | string match -e -v $current_context
end

function kx --description "fzf wrapper for kubectx"
  set -l preview '
    string match -q -r \'^gke_\' {}; and string replace -r \'^gke_(.+)_(.+)_(.+)$\' "$(set_color blue)󱇶  GKE Cluster: $(set_color cyan)\\$3\n$(set_color blue)   GCP Project: $(set_color cyan)\\$1\n$(set_color blue)   Location: $(set_color cyan)\\$2" {}
    string match -q -r \'^arn:aws:eks:\' {}; and string replace -r \'^arn:aws:eks:(.+):(.+):cluster/(.+)$\' "$(set_color blue)  EKS Cluster: $(set_color cyan)\\$3\n$(set_color blue)   AWS Account ID: $(set_color cyan)\\$2\n$(set_color blue)   Location: $(set_color cyan)\\$1" {}
    string match -q -r \'^.+\.teleport\.gitlab\.net-:\' {}; and string replace -r \'^(.+\.teleport\.gitlab\.net)-(.+)$\' "$(set_color blue)  Teleport: $(set_color cyan)\\$2\n$(set_color blue)   Proxy: $(set_color cyan)\\$1" {}
  '
  set -l context (kube_contexts | fzf --tmux center,25%,40% --no-preview --prompt ' ' --preview $preview --preview-window bottom,3)
  test -z $context; and return
  kubectx $context
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
