# {{{ FZF

FZF_TMUX=1
FZF_TMUX_OPTS="-p"

if command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND=$'rg --files --hidden --glob \'!.git\''
elif command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'
fi

# https://github.com/junegunn/fzf/wiki/Color-schemes#nord
local fzf_colors=(
  --color 'fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C'
  --color 'pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B,border:#4C566A,label:#81A1C1'
)
export FZF_DEFAULT_OPTS="${(j: :)fzf_colors} --layout=reverse"
if [[ -v FZF_DEFAULT_COMMAND ]]; then
  FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always --group-directories-first --icons ${realpath}'

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
