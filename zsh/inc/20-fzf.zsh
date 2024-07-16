# {{{ FZF

FZF_TMUX=1
FZF_TMUX_OPTS="-p"

# Nord theme: https://github.com/junegunn/fzf/wiki/Color-schemes#nord
export FZF_DEFAULT_OPTS_FILE="${XDG_CONFIG_HOME}/fzf/fzfrc"

if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git --strip-cwd-prefix'
  export FZF_ALT_C_COMMAND='fd --type directory --hidden --exclude .git --strip-cwd-prefix'
elif command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND=$'rg --files --hidden --glob \'!.git\''
fi
if [[ -v FZF_DEFAULT_COMMAND ]]; then
  FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --group-directories-first --icons ${realpath}'

edit-dotfiles() {
  yadm_workdir="$(yadm rev-parse --show-toplevel)"

  dotfile="$(
    yadm ls-files |
      fzf-tmux -p 75%,75% --ansi --border-label 'Edit dotfiles' \
          --preview-window 'right:60%' --preview "bat --color=always --style=plain ${(q)yadm_workdir}/{}"
  )"

  if [[ -z "${dotfile}" ]]; then
    zle redisplay
    return 0
  fi

  zle push-line
  BUFFER="${EDITOR} ${(q)yadm_workdir}/${(q)dotfile}"
  zle accept-line
  local ret=$?

  unset dotfile
  zle reset-prompt
  return "${ret}"
}

zle     -N            edit-dotfiles
bindkey -M emacs '^Ed' edit-dotfiles
bindkey -M vicmd '^Ed' edit-dotfiles
bindkey -M viins '^Ed' edit-dotfiles

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
