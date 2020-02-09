#!/usr/bin/env zsh

# Only if not root, and keychain is available, and the .keychain directory was created
if [[ $(id -u) -ne 0 ]] && command -v keychain >/dev/null 2>&1 && [[ -d "${HOME}/.keychain" ]]; then
    keychain --nogui --ignore-missing ~/.ssh/id_rsa ~/.ssh/id_ed25519
fi
