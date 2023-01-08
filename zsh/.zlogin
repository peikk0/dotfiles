
# {{{ Recompile ZSH files

# <https://github.com/htr3n/zsh-config/blob/master/zlogin>

# Execute code in the background to not affect the current session
(
  setopt extended_glob

  : "${XDG_CACHE_HOME:=${HOME}/.cache}"
  : "${XDG_CONFIG_HOME:=${HOME}/.config}"
  : "${XDG_DATA_HOME:=${HOME}/.local/share}"
  : "${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}"

  autoload -U zrecompile

  # Compile zcompdump, if modified, to increase startup speed
  local zcompdumpdir="${XDG_CACHE_HOME}/zsh"
  local zcompdump="${zcompdumpdir}/zcompdump-${ZSH_VERSION}"
  mkdir -p "${zcompdumpdir}"
  if [[ -s "${zcompdump}" && (! -s "${zcompdump}.zwc" || "${zcompdump}" -nt "${zcompdump}.zwc") ]]; then
    zrecompile -pq "${zcompdump}"
    rm -f "${zcompdump}.zwc.old"
  fi

  # Recompile zsh files
  zrecompile -pq "${ZDOTDIR}/.zlogin"
  zrecompile -pq "${ZDOTDIR}/.zlogout"
  zrecompile -pq "${ZDOTDIR}/.zprofile"
  zrecompile -pq "${ZDOTDIR}/.zshenv"
  zrecompile -pq "${ZDOTDIR}/.zshrc"
  rm -f "${ZDOTDIR}"/.{zlogin,zlogout,zprofile,zshenv,zshrc}.zwc.old

  for f in "${XDG_CONFIG_HOME}/sh/inc"/*.sh; do
    zrecompile -pq "${f}"
    rm -f "${f}.zwc.old"
  done

  for f in "${ZDOTDIR}/inc"/*.zsh; do
    zrecompile -pq "${f}"
    rm -f "${f}.zwc.old"
  done

  zrecompile -pq "${XDG_CACHE_HOME}/zsh/plugins.zsh"
  rm -f "${XDG_CACHE_HOME}/zsh/plugins.zsh.zwc.old"

  for f in "${XDG_DATA_HOME}/zsh/plugins"/(^(t|T)est(-data|s|)/)#/*.zsh; do
    zrecompile -pq "${f}"
    rm -f "${f}.zwc.old"
  done
) &!

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
