# {{{ Syntax highlighting

_syntax_highlighting_plugin="${ZDOTDIR:-${HOME}}/.zsh/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "${_syntax_highlighting_plugin}" ]]; then
  . "${_syntax_highlighting_plugin}"
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
unset _syntax_highlighting_plugin

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
