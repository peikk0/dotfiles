# {{{ Vi Mode

_vi_mode_plugin="${ZDOTDIR:-${HOME}}/.zsh/plugins/vi-mode/zsh-vi-mode.zsh"
if [[ -f "${_vi_mode_plugin}" ]]; then
  . "${_vi_mode_plugin}"

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
unset _vi_mode_plugin

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
