#!/usr/bin/env zsh

# {{{ Interactive keychain on login

# Only if not root, and keychain is available, and the .keychain directory was created
if [[ $UID != 0 ]] && which keychain >/dev/null && [[ -d ~/.keychain ]]; then
    keychain --nogui --ignore-missing ~/.ssh/id_rsa
fi

# }}}
