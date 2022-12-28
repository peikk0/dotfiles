# {{{ Vars

: "${OS:=$(uname -s)}"
: "${UID:=$(id -u)}"

# }}}
#
# {{{ XDG

XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CACHE_HOME XDG_CONFIG_HOME

# }}}

# {{{ Path

if [ "${OS}" != "Darwin" ]; then
  PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
fi

# OSX
if [ -x /usr/libexec/path_helper ]; then
  eval "$(/usr/libexec/path_helper -s)"
fi

# Homebrew
if [ -x /opt/homebrew/bin/brew ] || [ -x /usr/local/bin/brew ]; then
  if [ -x /opt/homebrew/bin/brew ]; then
    HOMEBREW_PREFIX="/opt/homebrew";
  elif [ -x /usr/local/bin/brew ]; then
    HOMEBREW_PREFIX="/usr/local";
  fi
  HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
  HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";
  PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
  MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
  INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";
  export HOMEBREW_PREFIX HOMEBREW_CELLAR HOMEBREW_REPOSITORY PATH MANPATH INFOPATH
fi

PATH="${HOME}/.local/bin:${PATH}"
export PATH

# }}}

# {{{ Locale

LOCALE="en_NZ.UTF-8"
LANG="${LOCALE}"
# LC_ALL="${LOCALE}"
LC_COLLATE="${LOCALE}"
LC_CTYPE="${LOCALE}"
LC_MESSAGES="${LOCALE}"
LC_MONETARY="${LOCALE}"
LC_NUMERIC="${LOCALE}"
LC_TIME="${LOCALE}"
MM_CHARSET="UTF-8"
export LANG LC_COLLATE LC_CTYPE LC_MESSAGES LC_MONETARY LC_NUMERIC LC_TIME MM_CHARSET

# }}}

# {{{ Editor

EDITOR="vi"
VISUAL="vi"
if command -v vim >/dev/null 2>&1; then
  EDITOR="vim"
  VISUAL="vim"
fi
export EDITOR VISUAL

# }}}

# {{{ Pager

PAGER="more"
if command -v less >/dev/null 2>&1; then
  PAGER="less"
  LESS="-i -M -R --shift 5"; export LESS
  LESSHISTFILE="${XDG_CACHE_HOME}/less_history"; export LESSHISTFILE
  LESS_TERMCAP_mb=$'\e[1;34m'  # begin bold
  LESS_TERMCAP_md=$'\e[1;34m'  # begin blink
  LESS_TERMCAP_me=$'\e[0m'     # reset bold/blink
  LESS_TERMCAP_so=$'\e[01;35m' # begin reverse video
  LESS_TERMCAP_se=$'\e[0m'     # reset reverse video
  LESS_TERMCAP_us=$'\e[1;32m'  # begin underline
  LESS_TERMCAP_ue=$'\e[0m'     # reset underline
  export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_so \
    LESS_TERMCAP_se LESS_TERMCAP_us LESS_TERMCAP_ue
  if command -v lesspipe.sh >/dev/null 2>&1; then
    LESSOPEN='|lesspipe.sh %s'; export LESSOPEN
  elif command -v lesspipe >/dev/null 2>&1; then
    eval "$(lesspipe)"
  fi
fi
export PAGER

# }}}

# {{{ Bat

BAT_THEME="Nord"; export BAT_THEME

# }}}

# {{{ ripgrep

RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/config"; export RIPGREP_CONFIG_PATH

# }}}

# {{{ Du

BLOCKSIZE="K"; export BLOCKSIZE

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
