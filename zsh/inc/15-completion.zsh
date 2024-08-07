# {{{ Completion

typeset -aU fpath
for d in /usr/{,local/}share/zsh/site-functions ${HOME}/.config/zsh/completions; do
  [[ -d "${d}" ]] && fpath=(${d} ${fpath})
done

autoload -Uz compinit
autoload -Uz complist

zcompdumpdir="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"
zcompdump="${zcompdumpdir}/zcompdump-${ZSH_VERSION}"
mkdir -p "${zcompdumpdir}"
compinit -d "${zcompdump}"

zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompcache"
zstyle ':completion:*' known-hosts-files "${HOME}/.ssh/known_hosts" "${XDG_CACHE_HOME:-${HOME}/.cache}/ssh_known_hosts"
zstyle ':completion:*' menu select=5
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*:approximate:::' max-errors 3 numeric
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' original true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:rm:*' ignore-line yes

if [[ -n "${LS_COLORS}" ]]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
else
  ZCOLORS="no=00:fi=00:di=00;34:ln=00;36:pi=00;32:so=00;35:do=00;35:bd=00;33:cd=00;33:or=05;37;41:mi=05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=00;32:"
  zstyle ':completion:*' list-colors ${(s.:.)ZCOLORS}
  unset ZCOLORS
fi

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
