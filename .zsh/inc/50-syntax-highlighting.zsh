# {{{ Syntax highlighting

SYNTAX_HIGHLIGHTING_PLUGIN="${ZDOTDIR:-${HOME}}/.zsh/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "${SYNTAX_HIGHLIGHTING_PLUGIN}" ]]; then
  . "${SYNTAX_HIGHLIGHTING_PLUGIN}"
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
fi
unset SYNTAX_HIGHLIGHTING_PLUGIN

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
