# {{{ Aliases

# ls / eza

: "${OS:=$(uname -s)}"
local dir_colors="$(antidote path nordtheme/dircolors)/src/dir_colors"
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

if command -v eza >/dev/null 2>&1; then
  alias eza="eza --group-directories-first --icons"
  alias ls="eza"
  alias ll="eza -l -g --time-style=long-iso"
  alias l="eza -F -a"
  alias la="eza -aa"
fi

# bash

alias bash='bash --init-file "${XDG_CONFIG_HOME}/bash/bashrc"'

# git

alias g="git"
alias gp="git pull"
alias gpu="git push -u"
alias gf="git fetch"
alias gfp="git fetch --prune"

# grep

if command -v bsdgrep >/dev/null 2>&1; then
  alias grep="bsdgrep --color=auto"
else
  alias grep="grep --color=auto"
fi
alias egrep="grep -E"
alias fgrep="grep -F"

# homebrew

if [[ "${OS}" = "Darwin" ]]; then
  alias bb='brew bundle --file "${XDG_CONFIG_HOME}/homebrew/Brewfile"'
fi

# tar

if command -v bsdtar >/dev/null 2>&1; then
  alias tar="bsdtar"
fi

# vim

if [[ "${EDITOR}" = "vim" ]]; then
  alias vi="vim"
fi

# yaml

alias y="yadm"

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
