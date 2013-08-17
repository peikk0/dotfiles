#!/usr/bin/env zsh

# Only if not root, and keychain is available, and the .keychain directory was created
if [ `id -u` -ne 0 ] && which keychain >/dev/null && [ -d "$HOME/.keychain" ]; then
    keychain --nogui --ignore-missing ~/.ssh/id_rsa
fi
