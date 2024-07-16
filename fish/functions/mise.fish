function mise --description "Lazy-load mise"
  if not command -qv mise
    set_color red; echo -n " "
    set_color normal; echo "mise not found"
    return 1
  end

  functions --erase mise
  command mise activate fish | source
  set_color green; echo -n " "
  set_color normal; echo "mise loaded!"

  if test (count $argv) -ge 1
    set_color blue; echo  "❯ mise $argv"
    set_color normal
    mise $argv
  end
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
