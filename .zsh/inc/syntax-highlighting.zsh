# {{{ Syntax highlighting

if [[ -f "${ZDOTDIR:-${HOME}}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  . "${ZDOTDIR:-${HOME}}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
fi

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
