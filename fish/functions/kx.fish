function kx --description "fzf wrapper for kubectx"
  set -lx _KUBECTX_FORCE_COLOR 1

  set -l choice (
    kubectx \
      | sed -r -e "s/gke_(.+)_(.+)_(.+)/\\3 $(set_color blue)󱇶  $(set_color -i blue)\\1:$(set_color cyan)\\2$(set_color normal)/" \
               -e "s/arn:aws:eks:(.+):(.+):cluster\\/(.+)/\\3 $(set_color blue)  $(set_color -i blue)\\2:$(set_color cyan)\\1$(set_color normal)/" \
               -e "s/(.+\.teleport\.gitlab\.net)-(.+)/\\2 $(set_color blue)  $(set_color -i blue)\\1$(set_color normal)/" \
      | fzf-tmux -p 25%,40% --ansi --no-preview --prompt '⎈ '
    )

  if test -z $choice
    commandline -f repaint
    return
  end

  set -l context
  if string match -q '*󱇶*' $choice
    set context (kubectl config get-contexts -o=name | string match -r "^gke_.+_$(string split -f1 ' ' $choice)\$")
  else if string match -q '**' $choice
    set context (kubectl config get-contexts -o=name | string match -r "^.+\.teleport\.gitlab\.net-$(string split -f1 ' ' $choice)\$")
  else if string match -q '**' $choice
    set context (kubectl config get-contexts -o=name | string match -r "^arn:aws:eks:.+:cluster/$(string split -f1 ' ' $choice)\$")
  else
    set context (string split -f1 ' ' $choice)
  end

  kubectx $context
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
