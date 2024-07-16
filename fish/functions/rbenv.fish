function rbenv --description "Lazy-load rbenv"
  set -gx RBENV_ROOT $XDG_DATA_HOME/rbenv
  test -d $RBENV_ROOT/bin; and fish_add_path --move --path $RBENV_ROOT/bin

  if not command -qv rbenv
    set_color red; echo -n " "
    set_color normal; echo "rbenv not found"
    return 1
  end

  functions --erase rbenv
  command rbenv init - | source
  set_color green; echo -n " "
  set_color normal; echo "rbenv loaded!"

  if test (count $argv) -ge 1
    set_color blue; echo  "❯ rbenv $argv"; 
    set_color normal
    rbenv $argv
  end
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
