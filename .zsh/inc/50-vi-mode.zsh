# {{{ Vi Mode

VI_MODE_PLUGIN="${ZDOTDIR:-${HOME}}/.zsh/plugins/vi-mode/zsh-vi-mode.zsh"
if [[ -f "${VI_MODE_PLUGIN}" ]]; then
  . "${VI_MODE_PLUGIN}"

  ZVM_KEYTIMEOUT=0.25

  ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

  ZVM_INSERT_MODE_CURSOR=${ZVM_CURSOR_BLINKING_UNDERLINE}
  ZVM_NORMAL_MODE_CURSOR=${ZVM_CURSOR_BLOCK}
  ZVM_VISUAL_MODE_CURSOR=${ZVM_CURSOR_BLOCK}
  ZVM_VISUAL_LINE_MODE_CURSOR=${ZVM_CURSOR_BLOCK}

  zvm_after_init_commands=(
    "zvm_bindkey viins '^W' vi-backward-kill-word"
  )
fi
unset VI_MODE_PLUGIN

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
