#!/bin/sh
PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin"
[ -d /usr/local/kde4 ] && PATH="$PATH:/usr/local/kde4/sbin:/usr/local/kde4/bin"
[ -d ~/.rvm ] && PATH="$HOME/.rvm/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"; export PATH

#LC_ALL="en_US.UTF-8"; export LC_ALL
LC_COLLATE="en_US.UTF-8"; export LC_COLLATE
LC_CTYPE="en_US.UTF-8"; export LC_CTYPE
LC_MESSAGES="en_US.UTF-8"; export LC_MESSAGES
LC_MONETARY="en_US.UTF-8"; export LC_MONETARY
LC_NUMERIC="en_US.UTF-8"; export LC_NUMERIC
LC_TIME="en_US.UTF-8"; export LC_TIME
LANG="en_US.UTF-8"; export LANG
MM_CHARSET="UTF-8"; export MM_CHARSET
PAGER="less"; export PAGER
EDITOR="vim"; export EDITOR
VISUAL="vim"; export VISUAL
LESS="-I -M -R --shift 5"; export LESS
BLOCKSIZE="K"; export BLOCKSIZE

# Only if not root, and keychain is available, and the .keychain directory was created
if [ `id -u` -ne 0 ] && which keychain >/dev/null && [ -d ~/.keychain ]; then
    keychain --nogui --noask --quiet
    if [ -f ~/.keychain/`hostname`-sh ]; then
        . ~/.keychain/`hostname`-sh
    fi
    if [ -f ~/.keychain/`hostname`-sh-gpg ]; then
        . ~/.keychain/`hostname`-sh-gpg
    fi
fi
