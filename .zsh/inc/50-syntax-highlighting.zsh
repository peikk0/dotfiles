# {{{ Syntax highlighting

_syntax_highlighting_plugin="${ZDOTDIR:-${HOME}}/.zsh/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "${_syntax_highlighting_plugin}" ]]; then
  . "${_syntax_highlighting_plugin}"
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

  typeset -A ZSH_HIGHLIGHT_STYLES
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
  ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[function]='fg=green'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[command]='fg=green'
  ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=green'
  ZSH_HIGHLIGHT_STYLES[path]='none'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
  ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta'
  ZSH_HIGHLIGHT_STYLES[redirection]='fg=cyan'
fi
unset _syntax_highlighting_plugin

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
