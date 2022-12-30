# {{{ Aliases

: "${OS:=$(uname -s)}"
local dir_colors="${XDG_CONFIG_HOME:-${HOME}/.config}/nord-dircolors/src/dir_colors"
case "${OS}" in
  FreeBSD|Darwin)
    if command -v gdircolors >/dev/null 2>&1 && [ -f "${dir_colors}" ]; then
      eval "$(gdircolors -b "${dir_colors}")"
    fi
    LSCOLORS="exgxfxcxcxdxdxhbadacec"; export LSCOLORS
    alias ls="ls -G"
    if [[ "${OS}" = "FreeBSD" ]]; then
      alias ll="ls -h -l -D '%F %T'"
    else
      alias ll="ls -h -l -T"
    fi
    ;;
  Linux)
    if command -v dircolors >/dev/null 2>&1 && [ -f "${dir_colors}" ]; then
      eval "$(dircolors -b "${dir_colors}")"
    fi
    alias ls="ls --color=auto -N"
    alias ll="ls -h -l --time-style='+%F %T'"
    ;;
esac
unset dir_colors

alias l="ls -A -F"
alias la="ls -a"

if command -v exa >/dev/null 2>&1; then
  alias exa="exa --group-directories-first --icons"
  alias ls="exa"
  alias ll="exa -l -g --time-style=long-iso"
  alias l="exa -F -a"
  alias la="exa -aa"
fi

if command -v bsdtar >/dev/null 2>&1; then
  alias tar="bsdtar"
fi

if command -v bsdgrep >/dev/null 2>&1; then
  alias grep="bsdgrep --color=auto"
else
  alias grep="grep --color=auto"
fi
alias egrep="grep -E --color=auto"
alias fgrep="grep -F --color=auto"

if [[ "${EDITOR}" = "vim" ]]; then
  alias vi="vim"
fi

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
