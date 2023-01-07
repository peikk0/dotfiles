
# {{{ Recompile ZSH files

# <https://github.com/htr3n/zsh-config/blob/master/zlogin>

# Execute code in the background to not affect the current session
(
  setopt extended_glob

  autoload -U zrecompile

  # Compile zcompdump, if modified, to increase startup speed
  local zcompdumpdir="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"
  local zcompdump="${zcompdumpdir}/zcompdump-${ZSH_VERSION}"
  mkdir -p "${zcompdumpdir}"
  if [[ -s "${zcompdump}" && (! -s "${zcompdump}.zwc" || "${zcompdump}" -nt "${zcompdump}.zwc") ]]; then
    zrecompile -pq "${zcompdump}"
    rm -f "${zcompdump}.zwc.old"
  fi

  # Recompile zsh files
  zrecompile -pq ${ZDOTDIR:-${HOME}}/.profile
  zrecompile -pq ${ZDOTDIR:-${HOME}}/.zlogin
  zrecompile -pq ${ZDOTDIR:-${HOME}}/.zlogout
  zrecompile -pq ${ZDOTDIR:-${HOME}}/.zprofile
  zrecompile -pq ${ZDOTDIR:-${HOME}}/.zshenv
  zrecompile -pq ${ZDOTDIR:-${HOME}}/.zshrc
  rm -f .{zlogin,zlogout,zprofile,zshenv,zshrc}.zwc.old

  for f in "${XDG_CONFIG_HOME:-${HOME}/.config}/sh/inc"/*.sh; do
    zrecompile -pq "${f}"
    rm -f "${f}.zwc.old"
  done

  for f in "${ZDOTDIR:-$HOME}/.zsh/inc"/*.zsh; do
    zrecompile -pq "${f}"
    rm -f "${f}.zwc.old"
  done

  for f in "${ZDOTDIR:-$HOME}/.zsh/plugins"/(^(t|T)est(-data|s|)/)#/*.zsh; do
    zrecompile -pq "${f}"
    rm -f "${f}.zwc.old"
  done

  if [[ -d "${HOME}/.local/opt/fzf/shell" ]]; then
    for f in "${HOME}/.local/opt/fzf/shell"/*.zsh; do
      zrecompile -pq "${f}"
      rm -f "${f}.zwc.old"
    done
  fi
) &!

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
