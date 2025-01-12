# {{{ Basics

# No greeting
set fish_greeting

# Nord theme
fish_config theme choose Nord

# Ensure sane default umask
umask 0022

# Grab OS name for later
set -l os (uname -s)

# }}}

# {{{ Environment

# XDG

set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME {$HOME}/.cache
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME {$HOME}/.config
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME {$HOME}/.local/share
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME {$HOME}/.local/state

# Default path

test $os = 'Darwin'; or set -gx PATH /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin

# Homebrew

if test -x /opt/homebrew/bin/brew || test -x /usr/local/bin/brew
  if test -x /opt/homebrew/bin/brew
    set -gx HOMEBREW_PREFIX /opt/homebrew
  else if test -x /usr/local/bin/brew
    set -gx HOMEBREW_PREFIX /usr/local
  end
  set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
  set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
  set -gx MANPATH $HOMEBREW_PREFIX/share/man $MANPATH
  set -gx INFOPATH $HOMEBREW_PREFIX/share/info $INFOPATH
  fish_add_path --move --path $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
end

# Locale

set -gx LOCALE 'en_NZ.UTF-8'
set -gx LANG $LOCALE
set -gx LC_COLLATE $LOCALE
set -gx LC_CTYPE $LOCALE
set -gx LC_MESSAGES $LOCALE
set -gx LC_MONETARY $LOCALE
set -gx LC_NUMERIC $LOCALE
set -gx LC_TIME $LOCALE
set -gx MM_CHARSET 'UTF-8'

# ncurses / terminfo

set -gx TERMINFO_DIRS /usr/local/share/terminfo:/usr/share/terminfo:$XDG_DATA_HOME/terminfo

# Default editor

set -gx EDITOR vi
set -gx VISUAL vi

if command -qv vim
  set -gx EDITOR vim
  set -gx VISUAL vim
end

# Pager

set -gx PAGER more
if command -qv less
  set -gx PAGER less
  set -gx LESS '-i -M -R --shift 5'
  set -gx LESSKEY $XDG_CONFIG_HOME/less/key
  mkdir -p $XDG_STATE_HOME/less
  set -gx LESSHISTFILE $XDG_STATE_HOME/less/history
  if command -qv lesspipe.sh
    set -gx LESSOPEN '|lesspipe.sh %s'
    command -qv bat; and set -gx LESSCOLORIZER 'bat'
  else if command -qv lesspipe
    set -gx LESSOPEN '|lesspipe %s'
    set -gx LESSCLOSE 'lesspipe %s %s'
  end
end

# Ansible

set -gx ANSIBLE_HOME $XDG_CONFIG_HOME/ansible
set -gx ANSIBLE_CONFIG $ANSIBLE_HOME/ansible.cfg
set -gx ANSIBLE_GALAXY_CACHE_DIR $XDG_CACHE_HOME/ansible/galaxy_cache

# AWS

set -gx AWS_CONFIG_FILE $XDG_CONFIG_HOME/aws/config
set -gx AWS_SHARED_CREDENTIALS_FILE $XDG_CONFIG_HOME/aws/credentials

# Bat

if command -qv bat
  set -gx BAT_THEME 'Nord'
  set -gx MANPAGER "sh -c 'col -bx | bat -l man --paging=always --plain'"
  set -gx MANROFFOPT '-c'
end

# Docker

set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker

# du

set -gx BLOCKSIZE 'K'

# GnuPG

set -gx GNUPGHOME $XDG_CONFIG_HOME/gnupg
set -gx GPG_TTY (tty)

# Google Cloud SDK

for gcloud_path in \
  $HOME/.local/opt/google-cloud-sdk \
  /usr/local/google-cloud-sdk \
  /usr/lib/google-cloud-sdk \
  /opt/google-cloud-sdk \
  $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk

  test -d $gcloud_path; and fish_add_path --move --path $gcloud_path/bin; and break
end

set -gx CLOUDSDK_PYTHON_SITEPACKAGES '1' # For loading the optional Numpy dependency
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN 'True' # For kubectl with GKE

# Kubernetes

set -gx KUBECACHEDIR $XDG_CACHE_HOME/kube
set -gx KUBECONFIG $XDG_CONFIG_HOME/kube/config

# lima

set -gx LIMA_HOME $XDG_DATA_HOME/lima

# npm

set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc

# PostgreSQL

set -gx PSQLRC $XDG_CONFIG_HOME/postgresql/psqlrc

# ripgrep

set -gx RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/config

# Ruby / Bundler

set -gx BUNDLE_USER_HOME $XDG_CONFIG_HOME/bundle
set -gx BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle

# Rust

set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup

fish_add_path --move --path $CARGO_HOME/bin

# sh

set -gx ENV $XDG_CONFIG_HOME/sh/profile

# Teleport

set -gx TELEPORT_HOME $XDG_CONFIG_HOME/teleport

# Terraform
set -gx CHECKPOINT_DISABLE 'true'
set -gx TF_CLI_CONFIG_FILE $XDG_CONFIG_HOME/terraform/terraformrc

# TFLint
set -gx TFLINT_PLUGIN_DIR $XDG_CACHE_HOME/tflint/plugins

# Vault
set -gx VAULT_CONFIG $XDG_CONFIG_HOME/vault/config

# Vim

set -gx VIMINIT 'set shell=/bin/sh | if has("nvim") | let $MYVIMRC="${XDG_CONFIG_HOME}/nvim/init.vim" | else | let $MYVIMRC="${XDG_CONFIG_HOME}/vim/vimrc" | endif | source ${MYVIMRC}'

# Wget

set -gx WGETRC $XDG_CONFIG_HOME/wget/wgetrc

# X11

set -gx XINITRC $XDG_CONFIG_HOME/X11/xinitrc
set -gx XSERVERRC $XDG_CONFIG_HOME/X11/xserverrc

# Local path

fish_add_path --move --path $HOME/.local/bin

# }}}

# {{{ Abbreviations / Aliases

if status is-interactive

  # ls / eza

  set -l dircolors $XDG_CONFIG_HOME/dircolors/nord
  switch $os
  case 'FreeBSD' 'Darwin'
    command -qv gdircolors; and gdircolors -c $dircolors | source
    set -gx LSCOLORS 'exgxfxcxcxdxdxhbadacec'
    alias ls='ls -G'
    if test $os = 'FreeBSD'
      alias ll="ls -h -l -D '%F %T'"
    else
      alias ll='ls -h -l -T'
    end
  case 'Linux'
    command -qv dircolors; and dircolors -c $dircolors | source
    alias ls='ls --color=auto -N'
    alias ll="ls -h -l --time-style='+%F %T'"
  end
  set -el dircolors

  if command -qv eza
    alias eza 'eza --group-directories-first --hyperlink --icons=auto'
    alias ls 'eza'
    alias ll 'eza -l -g --time-style=long-iso'
    alias l 'eza -F -a'
    alias la 'eza -aa'
  else
    alias l='ls -A -F'
    alias la='ls -a'
  end

  # bash

  alias bash='bash --init-file $XDG_CONFIG_HOME/bash/bashrc'

  # git

  abbr -a g git
  abbr -a gp git pull
  abbr -a gpu git push --set-upstream
  abbr -a gf git fetch
  abbr -a gfp git fetch --prune

  # grep

  if command -qv bsdgrep
    alias grep='bsdgrep --color=auto'
  else
    alias grep='grep --color=auto'
  end
  alias egrep='grep -E'
  alias fgrep='grep -F'

  # homebrew

  command -qv brew; and alias bb='brew bundle --file $XDG_CONFIG_HOME/homebrew/Brewfile'

  # kubectl
  command -qv kubectl; and abbr -a k kubectl

  # ripgrep

  command -qv rg; and alias rgd='rg --json --context 2 $argv | delta'

  # tar

  command -qv bsdtar; and alias tar='bsdtar'

  # vim

  test $EDITOR = 'vim'; and abbr -a vi vim

  # yadm

  command -qv yadm; and abbr y yadm

end

# }}}

# {{{ Keybindings / Vi mode

if status is-interactive

  # Don't touch the default cursor
  function fish_vi_cursor; end

  # Default VI keybindings
  fish_vi_key_bindings

  # Switch to normal mode with jj
  bind -M insert -m default jj cancel repaint-mode
  # Edit in vim with vv
  bind -M default vv edit_command_buffer

  set -g fish_sequence_key_delay_ms 200

  # Custom widgets
  bind -M default \ck\cp kube-proxy-widget
  bind -M insert  \ck\cp kube-proxy-widget
  bind -M default \cv\cl vault-login-widget
  bind -M insert  \cv\cl vault-login-widget
  bind -M default \cv\ck 'vault-login-widget admin'
  bind -M insert  \cv\ck 'vault-login-widget admin'
  bind -M default \cv\cp vault-proxy-widget
  bind -M insert  \cv\cp vault-proxy-widget

end

# }}}

# {{{ OSC 7 (advise the terminal of the current working directory)

if status is-interactive

  # From https://codeberg.org/dnkl/foot/wiki#fish

  function update_cwd_osc --on-variable PWD --description 'Notify terminals when $PWD changes'
    if status --is-command-substitution || set -q INSIDE_EMACS
      return
    end
    printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
  end

  update_cwd_osc # Run once since we might have inherited PWD from a parent shell

end

# }}}

# {{{ Terminal title

if status is-interactive

  # https://fishshell.com/docs/current/cmds/fish_title.html

  function fish_title
    set -q argv[1]; or set argv fish
    # Looks like "hostname ~/d/fish ❯ git log"
    # or /e/apt: fish
    set title (fish_prompt_pwd_dir_length=1 prompt_pwd) "❯ $argv[1]"
    echo $title

    # Update screen/tmux title
    switch $TERM
    case 'screen*' 'tmux*'
      echo -ne "\\ek$title\\e\\" >/dev/tty
    end
  end

end

# }}}

# {{{ FZF

if command -qv fzf

  # Nord theme: https://github.com/junegunn/fzf/wiki/Color-schemes#nord
  set -gx FZF_DEFAULT_OPTS_FILE $XDG_CONFIG_HOME/fzf/fzfrc

  set -gx FORGIT_FZF_DEFAULT_OPTS '--tmux'
  set -gx FORGIT_LOG_FORMAT '%C(blue)%h%C(auto)%d%C(reset) %s %C(italic brightblack)(%cr)%reset'
  command -qv eza; and set -gx FORGIT_DIR_VIEW 'eza --tree --color=always --group-directories-first --icons'

  if command -qv fd
    set -gx FZF_DEFAULT_COMMAND 'fd --type file --hidden --exclude .git --strip-cwd-prefix'
  else if command -qv rg
    set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob !.git'
  end

  if status is-interactive

    fzf --fish | source

    set -q FZF_DEFAULT_COMMAND; and set -g FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    command -qv fd; and set -g FZF_ALT_C_COMMAND 'fd --type directory --hidden --exclude .git --strip-cwd-prefix'
    command -qv eza; and set -g FZF_ALT_C_OPTS "--preview 'eza -1 --color=always --group-directories-first --icons {}'"

  end

end

# }}}

# {{{ Starship

if status is-interactive && command -qv starship

  set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/config.toml

  # https://starship.rs/

  starship init fish | source
  enable_transience

  # Workaround for https://github.com/starship/starship/issues/560#issuecomment-2409922650
  function starship_transient_prompt_func
    tput cuu1
    starship module character
  end

  function prompt_newline --on-event fish_postexec
    echo
  end

  alias clear "command clear; commandline -f clear-screen"

end

# }}}

# {{{ Zoxide

if status is-interactive && command -qv zoxide

  zoxide init fish | source

end

# }}}

# {{{ Local config

test -f $__fish_config_dir/local.fish; and source $__fish_config_dir/local.fish

# }}}

# vim:filetype=fish:tabstop=2:shiftwidth=2:fdm=marker:
