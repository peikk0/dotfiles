# https://github.com/Homebrew/homebrew-bundle

tap 'homebrew/cask'

brew 'ag'
brew 'curl'
brew 'exa'
brew 'fzf'
brew 'git'
brew 'gnupg'
brew 'hub'
brew 'jq'
brew 'lesspipe'
brew 'lftp'
brew 'libarchive'
brew 'mas'
brew 'pinentry'
brew 'pinentry-mac'
brew 'ripgrep'
brew 'tmux'
brew 'vim'
brew 'yadm'
brew 'zsh'

local_brewfile=File.join(ENV['HOME'], '.Brewfile.local')
eval(IO.read(local_brewfile), binding) if File.exist?(local_brewfile)
