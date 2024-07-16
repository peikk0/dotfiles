function goenv --description "Lazy-load goenv"
  set -gx GOENV_ROOT $XDG_DATA_HOME/goenv
  set -gx GOENV_GOPATH_PREFIX $XDG_DATA_DIR/go
  test -d $GOENV_ROOT/bin; and fish_add_path --move --path $GOENV_ROOT/bin

  if not command -qv goenv
    set_color red; echo -n " "
    set_color normal; echo "goenv not found"
    return 1
  end

  functions --erase goenv
  command goenv init - | source
  set_color green; echo -n " "
  set_color normal; echo "goenv loaded!"

  if test (count $argv) -ge 1
    set_color blue; echo  "❯ goenv $argv"; 
    set_color normal
    goenv $argv
  end
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
