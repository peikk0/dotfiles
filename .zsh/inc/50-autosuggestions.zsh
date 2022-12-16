# {{{ Autosuggestions

_autosuggestions_plugin="${ZDOTDIR:-${HOME}}/.zsh/plugins/autosuggestions/zsh-autosuggestions.zsh"
if [[ -f "${_autosuggestions_plugin}" ]]; then
  . "${_autosuggestions_plugin}"
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=1
fi
unset _autosuggestions_plugin

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
