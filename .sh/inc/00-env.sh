# {{{ Vars

: "${OS:=$(uname -s)}"
: "${UID:=$(id -u)}"

# }}}

# {{{ Path

[ -n "${PATH}" ] || PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# OSX
if [ -x /usr/libexec/path_helper ]; then
    eval "$(/usr/libexec/path_helper -s)"
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
  LESS="-I -M -R --shift 5"; export LESS
  if command -v lesspipe >/dev/null 2>&1; then
    eval "$(lesspipe)"
  elif command -v lesspipe.sh >/dev/null 2>&1; then
    LESSOPEN='|lesspipe.sh %s'; export LESSOPEN
    LESS_ADVANCED_PREPROCESSOR=1; export LESS_ADVANCED_PREPROCESSOR
  fi
fi
export PAGER

# }}}

# {{{ Du

BLOCKSIZE="K"; export BLOCKSIZE

# }}}

# {{{ Homebrew

if [ "${OS}" = "Darwin" ]; then
  # shellcheck source=/dev/null
  HOMEBREW_BUNDLE_FILE="${HOME}/.config/brew/Brewfile"
  export HOMEBREW_BUNDLE_FILE
fi

# }}}

# vim:filetype=sh:tabstop=2:shiftwidth=2:fdm=marker:
