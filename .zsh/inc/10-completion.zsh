# {{{ Completion

typeset -aU fpath
for d in /usr/{,local/}share/zsh/site-functions ${HOME}/.zsh/completion; do
  [[ -d "${d}" ]] && fpath=(${d} ${fpath})
done

autoload -Uz compinit
autoload -Uz complist

compinit

zstyle ':completion:*' menu select=5
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*:approximate:::' max-errors 3 numeric
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' original true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:rm:*' ignore-line yes

: "${OS:=$(uname -s)}"
case "${OS}" in
  FreeBSD|Darwin)
    ZCOLORS="no=00:fi=00:di=00;34:ln=00;36:pi=00;32:so=00;35:do=00;35:bd=00;33:cd=00;33:or=05;37;41:mi=05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=00;32:"
    zstyle ':completion:*' list-colors ${(s.:.)ZCOLORS}
    ;;
  Linux)
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    ;;
esac

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
