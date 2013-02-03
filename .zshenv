#!/usr/bin/env zsh
# {{{ Env vars

PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin"
[[ -d /usr/local/kde4 ]] && PATH="$PATH:/usr/local/kde4/sbin:/usr/local/kde4/bin"
[[ -d ~/.rvm ]] && PATH="$HOME/.rvm/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH
#export LC_ALL="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LANG="en_US.UTF-8"
export MM_CHARSET="UTF-8"
export PAGER="less"
export EDITOR="vim"
export VISUAL="vim"
export LESS="-I -M -R --shift 5"
export BLOCKSIZE="K"

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
