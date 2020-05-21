# {{{ Syntax highlighting

SYNTAX_HIGHLIGHTING_PLUGIN="${ZDOTDIR:-${HOME}}/.zsh/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "${SYNTAX_HIGHLIGHTING_PLUGIN}" ]]; then
  . "${SYNTAX_HIGHLIGHTING_PLUGIN}"
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

  typeset -A ZSH_HIGHLIGHT_STYLES
  ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=white,bold'
  ZSH_HIGHLIGHT_STYLES[redirection]='fg=white,bold'
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=white,bold'
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=white,bold'
fi
unset SYNTAX_HIGHLIGHTING_PLUGIN

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
