#!/usr/bin/env zsh

# {{{ Env vars

PATH="/usr/local/bin:/usr/local/sbin:/usr/games:/usr/bin:/usr/sbin:/bin:/sbin"
[[ -d /usr/local/kde4 ]] && PATH="/usr/local/kde4/bin:/usr/local/kde4/sbin:$PATH"
[[ -d ~/.rvm ]] && PATH="$HOME/.rvm/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH

LOCALE="en_US.UTF-8"
LANG="$LOCALE"
# LC_ALL="$LOCALE"
LC_COLLATE="$LOCALE"
LC_CTYPE="$LOCALE"
LC_MESSAGES="$LOCALE"
LC_MONETARY="$LOCALE"
LC_NUMERIC="$LOCALE"
LC_TIME="$LOCALE"
MM_CHARSET="UTF-8"

EDITOR="vim"
VISUAL="vim"
PAGER="less"
LESS="-I -M -R --shift 5"
BLOCKSIZE="K"

export LANG LC_COLLATE LC_CTYPE LC_MESSAGES LC_MONETARY LC_NUMERIC LC_TIME MM_CHARSET EDITOR VISUAL PAGER LESS BLOCKSIZE

# }}}

# {{{ Keychain

# Only if not root, and keychain is available, and the .keychain directory was created
if [[ $UID != 0 ]] && which keychain >/dev/null && [[ -d ~/.keychain ]]; then
    keychain --nogui --noask --quiet
    if [[ -f ~/.keychain/`hostname`-sh ]]; then
        . ~/.keychain/`hostname`-sh
    fi
    if [[ -f ~/.keychain/`hostname`-sh-gpg ]]; then
        . ~/.keychain/`hostname`-sh-gpg
    fi
fi

# }}}
