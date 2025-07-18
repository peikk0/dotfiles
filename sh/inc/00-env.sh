# shellcheck shell=sh

# {{{ XDG

: "${XDG_CACHE_HOME:=${HOME}/.cache}"
: "${XDG_CONFIG_HOME:=${HOME}/.config}"
: "${XDG_DATA_HOME:=${HOME}/.local/share}"
: "${XDG_STATE_HOME:=${HOME}/.local/state}"
export XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME

# }}}

# {{{ Path

if [ "$(uname -s)" != "Darwin" ]; then
  PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
fi

# OSX
if [ -x /usr/libexec/path_helper ]; then
  eval "$(/usr/libexec/path_helper -s)"
fi

# Homebrew
if [ -x /opt/homebrew/bin/brew ] || [ -x /usr/local/bin/brew ]; then
  if [ -x /opt/homebrew/bin/brew ]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  elif [ -x /usr/local/bin/brew ]; then
    HOMEBREW_PREFIX="/usr/local"
  fi
  HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
  HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
  PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}"
  MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:"
  INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"
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

TERMINFO_DIRS="/usr/local/share/terminfo:/usr/share/terminfo:${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS

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
  LESS="-i -M -R --shift 5"
  LESSKEY="${XDG_CONFIG_HOME}/less/key"
  mkdir -p "${XDG_STATE_HOME}/less"
  LESSHISTFILE="${XDG_STATE_HOME}/less/history"
  export LESS LESSKEY LESSHISTFILE
  if command -v lesspipe.sh >/dev/null 2>&1; then
    LESSOPEN='|lesspipe.sh %s'
    export LESSOPEN
    if command -v bat >/dev/null; then
      LESSCOLORIZER='bat'
      export LESSCOLORIZER
    fi
  elif command -v lesspipe >/dev/null 2>&1; then
    eval "$(lesspipe)"
  fi
fi
export PAGER

# }}}

# {{{ Ansible

ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
ANSIBLE_CONFIG="${ANSIBLE_HOME}/ansible.cfg"
ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"
export ANSIBLE_CONFIG ANSIBLE_HOME ANSIBLE_GALAXY_CACHE_DIR

# }}}

# {{{ AWS

AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE AWS_SHARED_CREDENTIALS_FILE

# }}}

# {{{ Bat

if command -v bat >/dev/null 2>&1; then
  BAT_THEME="Nord"
  # shellcheck disable=SC2089
  MANPAGER="sh -c 'col -bx | bat -l man --paging=always --plain'"
  MANROFFOPT="-c"
  # shellcheck disable=SC2090
  export BAT_THEME MANPAGER MANROFFOPT
fi

# }}}

# {{{ Docker

DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export DOCKER_CONFIG

# }}}

# {{{ du

BLOCKSIZE="K"
export BLOCKSIZE

# }}}

# {{{ GnuPG

GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export GNUPGHOME

# }}}

# {{{ Kubernetes

KUBECACHEDIR="${XDG_CACHE_HOME}/kube"
KUBECONFIG="${XDG_CONFIG_HOME}/kube/config"
export KUBECACHEDIR KUBECONFIG

# }}}

# {{{ lima

LIMA_HOME="${XDG_DATA_HOME}/lima"
export LIMA_HOME

# }}}

# {{{ npm

NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NPM_CONFIG_USERCONFIG

# }}}

# {{{ PostgreSQL

PSQLRC="${XDG_CONFIG_HOME}/postgresql/psqlrc"
export PSQLRC

# }}}

# {{{ ripgrep

RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"
export RIPGREP_CONFIG_PATH

# }}}

# {{{ Ruby / Bundler

BUNDLE_USER_HOME="${XDG_CONFIG_HOME}/bundle"
BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export BUNDLE_USER_HOME BUNDLE_USER_CACHE

# }}}

# {{{ Rust

CARGO_HOME="${XDG_DATA_HOME}/cargo"
RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME RUSTUP_HOME

PATH="${CARGO_HOME}/bin:${PATH}"
export PATH

# }}}

# {{{ sh

ENV="${XDG_CONFIG_HOME}/sh/profile"
export ENV

# }}}

# {{{ Wget

WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export WGETRC

# }}}

# {{{ X11

XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export XINITRC XSERVERRC

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
