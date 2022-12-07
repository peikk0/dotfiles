# https://github.com/Homebrew/homebrew-bundle

tap 'homebrew/cask'
tap 'homebrew/services'
tap 'starkandwayne/cf'
tap 'koekeishiya/formulae'
tap 'vmware-tanzu/carvel'

brew 'ag'
brew 'asdf'
brew 'awscli'
brew 'bash'
brew 'bat'
brew 'cmake'
brew 'colima'
brew 'coreutils'
brew 'curl'
brew 'docker'
brew 'duf'
brew 'exa'
brew 'fd'
brew 'findutils'
brew 'fzf'
brew 'git'
brew 'git-crypt'
brew 'git-delta'
brew 'git-lfs'
brew 'glab'
brew 'gnu-sed'
brew 'gnu-tar'
brew 'gnupg'
brew 'goenv', args: ['HEAD']
brew 'gpatch'
brew 'graphicsmagick'
brew 'grep'
brew 'helm'
brew 'helmfile'
brew 'htop'
brew 'hub'
brew 'jq'
brew 'jsonnet'
brew 'jsonnet-bundler'
brew 'k9s'
brew 'kind'
brew 'kubernetes-cli'
brew 'kubectx'
brew 'kustomize'
brew 'lesspipe'
brew 'lftp'
brew 'libarchive'
brew 'mas'
brew 'minikube'
brew 'node'
brew 'nvm'
brew 'openssh'
brew 'pinentry'
brew 'pinentry-mac'
brew 'postgresql@14'
brew 'procs'
brew 'pwgen'
brew 'pyenv'
brew 'rbenv'
brew 'ripgrep'
brew 'safe'
brew 'shellcheck'
brew 'sipcalc'
brew 'skhd'
brew 'tanka'
brew 'teleport'
brew 'terraform-docs'
brew 'tfenv'
brew 'tflint'
brew 'tree-sitter'
brew 'tmux'
brew 'vault'
brew 'vendir'
brew 'vim'
brew 'wget'
brew 'xh'
brew 'xsv'
brew 'xz'
brew 'yabai'
brew 'yadm'
brew 'yamllint'
brew 'yarn'
brew 'ykman'
brew 'yq'
brew 'zsh'

cask '1password-cli'

local_brewfile=File.join(ENV['HOME'], '.Brewfile.local')
eval(IO.read(local_brewfile), binding) if File.exist?(local_brewfile)
