# {{{ History

HISTFILE="${ZDOTDIR:-${HOME}}/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
setopt append_history hist_ignore_all_dups hist_reduce_blanks

# }}}

# {{{ Misc

# Misc options
setopt auto_list
setopt auto_param_keys
setopt auto_param_slash
setopt autocd
setopt equals
setopt extended_glob
setopt hash_cmds
setopt hash_dirs
setopt numeric_glob_sort
unsetopt beep
unsetopt notify

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
