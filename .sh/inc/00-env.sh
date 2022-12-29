# shellcheck shell=sh

# {{{ Vars

: "${OS:=$(uname -s)}"
: "${UID:=$(id -u)}"

# }}}
#
# {{{ XDG

XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
export XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME

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

# {{{ ncurses / terminfo

TERMINFO="${XDG_DATA_HOME}/terminfo"
TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/local/share/terminfo:/usr/share/terminfo"
export TERMINFO TERMINFO_DIRS

#}}}

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
  mkdir -p "${XDG_STATE_HOME}/less"
  LESSHISTFILE="${XDG_STATE_HOME}/less/history"; export LESSHISTFILE
  LESS_TERMCAP_mb="$(tput -T "${TERM:-xterm}" setaf 4)"
  LESS_TERMCAP_md="$(tput -T "${TERM:-xterm}" setaf 4)"
  LESS_TERMCAP_me="$(tput -T "${TERM:-xterm}" sgr0)"
  LESS_TERMCAP_so="$(tput -T "${TERM:-xterm}" setaf 5)"
  LESS_TERMCAP_se="$(tput -T "${TERM:-xterm}" sgr0)"
  LESS_TERMCAP_us="$(tput -T "${TERM:-xterm}" setaf 2)"
  LESS_TERMCAP_ue="$(tput -T "${TERM:-xterm}" sgr0)"
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

RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"; export RIPGREP_CONFIG_PATH

# }}}

# {{{ du

BLOCKSIZE="K"; export BLOCKSIZE

# }}}

# {{{ PostgreSQL

PSQLRC="${XDG_CONFIG_HOME}/postgresql/psqlrc"; export PSQLRC

# }}}

# {{{ Ruby / Bundler

BUNDLE_USER_HOME="${XDG_CONFIG_HOME}/bundle"
BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export BUNDLE_USER_HOME BUNDLE_USER_CACHE

# }}}

# {{{ wget

WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"; export WGETRC

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
