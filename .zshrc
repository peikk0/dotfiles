# {{{ General settings

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
setopt append_history hist_ignore_all_dups hist_reduce_blanks

# Misc options
setopt auto_list
setopt auto_param_keys
setopt auto_param_slash
setopt autocd
setopt equals
setopt extended_glob
setopt hash_cmds
setopt hash_dirs
setopt numeric_glob_sort
setopt transient_rprompt
unsetopt beep
unsetopt notify

# Color vars
autoload -U colors
colors

# Watch for login/logout
watch=all

# }}}

# {{{ Keybindings

# emacs keybindings, tired of vi mode in shell
bindkey -e

# Fixes from Debian
if [[ "$TERM" != emacs ]]; then
  [[ -z "$terminfo[kdch1]" ]] || bindkey -M emacs "$terminfo[kdch1]" delete-char
  [[ -z "$terminfo[khome]" ]] || bindkey -M emacs "$terminfo[khome]" beginning-of-line
  [[ -z "$terminfo[kend]" ]] || bindkey -M emacs "$terminfo[kend]" end-of-line
  [[ -z "$terminfo[kich1]" ]] || bindkey -M emacs "$terminfo[kich1]" overwrite-mode
  [[ -z "$terminfo[kdch1]" ]] || bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
  [[ -z "$terminfo[khome]" ]] || bindkey -M vicmd "$terminfo[khome]" vi-beginning-of-line
  [[ -z "$terminfo[kend]" ]] || bindkey -M vicmd "$terminfo[kend]" vi-end-of-line
  [[ -z "$terminfo[kich1]" ]] || bindkey -M vicmd "$terminfo[kich1]" overwrite-mode

  # [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" vi-up-line-or-history
  [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
  [[ -z "$terminfo[cuf1]" ]] || bindkey -M viins "$terminfo[cuf1]" vi-forward-char
  # [[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" vi-up-line-or-history
  [[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
  # [[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" vi-down-line-or-history
  [[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" down-line-or-history
  [[ -z "$terminfo[kcuf1]" ]] || bindkey -M viins "$terminfo[kcuf1]" vi-forward-char
  [[ -z "$terminfo[kcub1]" ]] || bindkey -M viins "$terminfo[kcub1]" vi-backward-char

  # ncurses fogyatekos
  # [[ "$terminfo[kcuu1]" == "\eO"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" vi-up-line-or-history
  # [[ "$terminfo[kcud1]" == "\eO"* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" vi-down-line-or-history
  [[ "$terminfo[kcuu1]" == ""* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
  [[ "$terminfo[kcud1]" == ""* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history
  [[ "$terminfo[kcuf1]" == "\eO"* ]] && bindkey -M viins "${terminfo[kcuf1]/O/[}" vi-forward-char
  [[ "$terminfo[kcub1]" == "\eO"* ]] && bindkey -M viins "${terminfo[kcub1]/O/[}" vi-backward-char
  [[ "$terminfo[khome]" == "\eO"* ]] && bindkey -M viins "${terminfo[khome]/O/[}" beginning-of-line
  [[ "$terminfo[kend]" == "\eO"* ]] && bindkey -M viins "${terminfo[kend]/O/[}" end-of-line
  [[ "$terminfo[khome]" == "\eO"* ]] && bindkey -M emacs "${terminfo[khome]/O/[}" beginning-of-line
  [[ "$terminfo[kend]" == "\eO"* ]] && bindkey -M emacs "${terminfo[kend]/O/[}" end-of-line
fi

# URxvt keys
bindkey "\e[2~" overwrite-mode
bindkey "\e[3~" delete-char
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[5~" history-search-backward
bindkey "\e[6~" history-search-forward

# Man
bindkey "\eh" run-help

# Edit cmdline
autoload edit-command-line
zle -N edit-command-line
bindkey "\ee" edit-command-line
bindkey "\ex" execute-named-cmd

# Complete help
bindkey "\ec" _complete_help

# () [] {} ...
# bindkey -s '((' '()\ei'
# bindkey -s '( (' '(   )\ehhi'
# bindkey -s '(((' '(\ea(   ))\ehhhi'
# bindkey -s '{{' '{}\ei'
# bindkey -s '{ {' '{  }\ehi'
# bindkey -s '{{{' '{\ea{   }}\ehhhi' # }}} (quick and ugly folding fix...)
# bindkey -s '[[' '[]\ei'
# bindkey -s '[ [' '[   ]\ehhi'
# bindkey -s '[[[' '[\ea[   ]]\ehhhi'
# bindkey -s "''" "'\ea'\ei"
# bindkey -s '""' '"\ea"\ei'

# }}}

# {{{ Completion

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit
autoload -Uz complist
compinit
zstyle ':completion:*' menu select=5
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*:approximate:::' max-errors 3 numeric
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' original true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:rm:*' ignore-line yes

# }}}

# {{{ Per OS settings

case `uname -s` in
  FreeBSD|Darwin)
    ZCOLORS="no=00:fi=00:di=00;34:ln=00;36:pi=00;32:so=00;35:do=00;35:bd=00;33:cd=00;33:or=05;37;41:mi=05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=00;32:"
    zstyle ':completion:*' list-colors ${(s.:.)ZCOLORS}
    ;;
  Linux)
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    ;;
esac

# }}}

# {{{ Prompts

# Git prompt
if which git >/dev/null 2>&1 && [[ -f "${HOME}/.zsh/git-prompt/zshrc.sh" ]]; then
  . "${HOME}/.zsh/git-prompt/zshrc.sh"
  HAS_GIT_PROMPT=1
fi

# Right prompt with clock
RPS1="  %{$fg_no_bold[yellow]%}%D{%d/%m/%y %H:%M:%S}%{${reset_color}%}"

# Others prompts
PS2="%{$fg_no_bold[yellow]%}%_>%{${reset_color}%} "
PS3="%{$fg_no_bold[yellow]%}?#%{${reset_color}%} "

# }}}

# {{{ title()

# Display the title
function title {
  local t="%m %~ %#"

  case $TERM in
    screen*) # and tmux
      print -nP "\ek$t\e\\"
      print -nP "\e]0;$t\a"
      ;;
    xterm*|rxvt*|stterm*|(E|e)term)
      print -nP "\e]0;$t\a"
      ;;
  esac
}

# }}}

# {{{ precmd()

function precmd {
  # Set window title
  title

  # Color for non-text things
  local _reset_color="%{${reset_color}%}"
  local _misc_color="%{${fg_no_bold[white]}%}"
  local _rcerr_color="%{${fg_no_bold[red]}%}"

  local _host_color="%{${fg_no_bold[cyan]}%}"

  # Change path color given user rights on it
  if [[ -O "${PWD}" ]]; then # owner
    local _path_color="%{${fg_bold[yellow]}%}"
  elif [[ -w "${PWD}" ]]; then # can write
    local _path_color="%{${fg_bold[blue]}%}"
  else # other
    local _path_color="%{${fg_bold[red]}%}"
  fi

  if [[ $UID = 0 ]]; then
    local _sign_color="%{${fg_bold[red]}%}"
  else
    local _sign_color="%{${fg_bold[green]}%}"
  fi

  # Display return code when not 0
  local return_code="%(?..${_misc_color}!${_rcerr_color}%?${_misc_color}! )"

  # Host
  local host="${_host_color}%m"

  # Current path
  local cwd="${_path_color}%48<...<%~"

  # Red # for root, green % for user
  local sign="${_sign_color}%#"

  # Git
  if [[ -n "$HAS_GIT_PROMPT" ]]; then
    local git_status="\$(git_super_status)"
  else
    local git_status=""
  fi

  # Set the prompt
  PS1="${return_code}${host} ${cwd}${git_status} ${sign}${_reset_color} "
}

# }}}

# {{{ run-help-sudo

function run-help-sudo {
  if [ $# -eq 0 ]; then
    man sudo
  else
    man $1
  fi
}

# }}}

# {{{ Local configuration

if [[ -f "$HOME/.zshrc.local" ]]; then
  . "$HOME/.zshrc.local"
fi

# }}}

# {{{ Syntax highlighting

if [[ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  . "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# }}}

: # noop

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
