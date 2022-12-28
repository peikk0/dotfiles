# {{{ History

HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt append_history extended_history hist_find_no_dups hist_fcntl_lock hist_ignore_dups hist_ignore_space hist_reduce_blanks

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
