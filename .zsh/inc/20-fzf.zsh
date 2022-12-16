# {{{ FZF

_fzf_git_plugin="${ZDOTDIR:-${HOME}}/.zsh/plugins/fzf-git/fzf-git.sh"
_fzf_tab_plugin="${ZDOTDIR:-${HOME}}/.zsh/plugins/fzf-tab/fzf-tab.zsh"
_forgit_plugin="${ZDOTDIR:-${HOME}}/.zsh/plugins/forgit/forgit.plugin.zsh"

FZF_TMUX=1
FZF_TMUX_OPTS="-p"

if command -v rg >/dev/null 2>&1; then
  FZF_DEFAULT_COMMAND=$'rg --files --hidden --glob \'!.git\''
elif command -v fd >/dev/null 2>&1; then
  FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'
fi
export FZF_DEFAULT_COMMAND

if [[ -f "${HOME}/.local/fzf/shell/completion.zsh" ]]; then
  . "${HOME}/.local/fzf/shell/completion.zsh"
fi

if [[ -f "${HOME}/.local/fzf/shell/key-bindings.zsh" ]]; then
  . "${HOME}/.local/fzf/shell/key-bindings.zsh"

  if [[ -v FZF_DEFAULT_COMMAND ]]; then
    FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
  fi
fi

if [[ -f "${_fzf_git_plugin}" ]]; then
  . "${_fzf_git_plugin}"
fi

if [[ -f "${_fzf_tab_plugin}" ]]; then
  . "${_fzf_tab_plugin}"

  # disable sort when completing `git checkout`
  zstyle ':completion:*:git-checkout:*' sort false
  # set descriptions format to enable group support
  zstyle ':completion:*:descriptions' format '[%d]'
  # preview directory's content with exa when completing cd
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always --group-directories-first --icons ${realpath}'
fi

if [[ -f "${_forgit_plugin}" ]]; then
  . "${_forgit_plugin}"
fi

unset _fzf_git_plugin _fzf_tab_plugin _forgit_plugin

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
