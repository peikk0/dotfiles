function pyenv --description "Lazy-load pyenv"
  set -gx PYENV_ROOT $XDG_DATA_HOME/pyenv
  test -d $PYENV_ROOT/bin; and fish_add_path --move --path $PYENV_ROOT/bin

  if not command -qv pyenv
    set_color red; echo -n " "
    set_color normal; echo "pyenv not found"
    return 1
  end

  functions --erase pyenv
  command pyenv init - | source
  set_color green; echo -n " "
  set_color normal; echo "pyenv loaded!"

  if test (count $argv) -ge 1
    set_color blue; echo  "❯ pyenv $argv"; 
    set_color normal
    pyenv $argv
  end
end

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
