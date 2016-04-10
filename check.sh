#!/bin/sh

set -e

check() {
    echo -n "$1: "
    if type $1 >/dev/null 2>/dev/null; then
        echo "$(eval "${1}_version")"
    else
        echo "NOT FOUND"
    fi
}

bash_version() {
    bash --version | head -n1 | awk '{ print $4 }'
}

git_version() {
    git --version | awk '{ print $3 }'
}

hg_version() {
    hg --version | head -n1 | sed -ne 's/^.\+ (version \([0-9.]\+\))$/\1/p'
}

i3_version() {
    i3 --version | awk '{ print $3 }'
}

python_version() {
    python --version 2>&1 | awk '{ print $2 }'
}

perl_version() {
    perl --version | head -n2 | tail -n1 | sed -ne 's/^.\+ (v\([0-9.]\+\)) .\+$/\1/p'
}

ruby_version() {
    ruby --version | awk '{ print $2 }'
}

screen_version() {
    screen --version | awk '{ print $3 }'
}

tmux_version() {
    tmux -V | awk '{ print $2 }'
}

vim_version() {
    vim --version | head -n1 | awk '{ print $5 }'
}

zsh_version() {
    zsh --version | awk '{ print $2 }'
}

check bash
check git
check hg
check i3
check perl
check python
check ruby
check screen
check tmux
check vim
check zsh

exit 0
