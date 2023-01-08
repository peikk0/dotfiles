# {{{ Antidote

_antidote="${XDG_DATA_DIR:-${HOME}/.local/share}/zsh/antidote/antidote.zsh"
if [[ -f "${_antidote}" ]]; then
  . "${_antidote}"

  export ANTIDOTE_HOME="${XDG_DATA_DIR:-${HOME}/.local/share}/zsh/plugins"

  local antidote_bundle_file="${XDG_CONFIG_DIR:-${HOME}/.config}/zsh/plugins.txt"
  local antidote_static_file="${XDG_CACHE_DIR:-${HOME}/.cache}/zsh/plugins.zsh"

  zstyle :antidote:bundle use-friendly-names 'yes'
  zstyle :antidote:bundle file "${antidote_bundle_file}"
  zstyle :antidote:static file "${antidote_static_file}"

  antidote load

  unset antidote_bundle_file antidote_static_file
fi
unset _antidote

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
