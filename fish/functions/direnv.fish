function direnv --description "Lazy-load direnv"
  if not command -qv direnv
    set_color red; echo -n " "
    set_color normal; echo "direnv not found"
    return 1
  end

  functions --erase direnv
  command direnv hook fish | source
  set_color green; echo -n " "
  set_color normal; echo "direnv loaded!"

  if test (count $argv) -ge 1
    set_color blue; echo  "❯ direnv $argv"
    set_color normal
    direnv $argv
  end
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
