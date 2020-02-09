# {{{ General settings

# History
HISTFILE="${HOME}/.zsh_history"
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

# }}}

# {{{ Keybindings

# emacs keybindings, tired of vi mode in shell
bindkey -e

# Fixes from Debian
if [[ "${TERM}" != emacs ]]; then
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
  # [[ "$terminfo[kcuu1]" == ""* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
  # [[ "$terminfo[kcud1]" == ""* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history
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

case $(uname -s) in
  FreeBSD|Darwin)
    ZCOLORS="no=00:fi=00:di=00;34:ln=00;36:pi=00;32:so=00;35:do=00;35:bd=00;33:cd=00;33:or=05;37;41:mi=05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=00;32:"
    zstyle ':completion:*' list-colors ${(s.:.)ZCOLORS}
    ;;
  Linux)
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    ;;
esac

# }}}

# {{{ title()

# Display the title
function update_title {
  local t="%m %~ %#"

  case ${TERM} in
    screen*) # and tmux
      print -nP "\ek$t\e\\"
      print -nP "\e]0;$t\a"
      ;;
    xterm*|rxvt*|stterm*|(E|e)term)
      print -nP "\e]0;$t\a"
      ;;
  esac
}

autoload -U add-zsh-hook
add-zsh-hook precmd update_title

# }}}

# {{{ Prompts

function simple_prompt {
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

  if [[ ${UID} = 0 ]]; then
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

  # Set the prompt
  PS1="${return_code}${host} ${cwd} ${sign}${_reset_color} "

  # Right prompt with clock
  RPS1="  %{$fg_no_bold[yellow]%}%D{%d/%m/%y %H:%M:%S}%{${reset_color}%}"

  # Others prompts
  PS2="%{$fg_no_bold[yellow]%}%_>%{${reset_color}%} "
  PS3="%{$fg_no_bold[yellow]%}?#%{${reset_color}%} "
}

typeset -g POWERLEVEL="10k"
typeset -g POWERLEVEL9K_THEME="${HOME}/.zsh/powerlevel${POWERLEVEL}/powerlevel${POWERLEVEL}.zsh-theme"

setup_powerlevel9k() {
  prompt_aws_assume_role() {
    [[ "${AWS_ACCESS_KEY_ID:0:4}" = 'ASIA' ]] || return
    local icon='SUDO_ICON'
    if [[ -n "${AWS_SESSION_EXPIRATION}" ]] && [[ "${AWS_SESSION_EXPIRATION}" -lt "$(date +%s)" ]]; then
      icon='FAIL_ICON'
    fi
    if [[ "${POWERLEVEL}" = "10k" ]]; then
      p10k segment -b 'red' -f 'white' -r -i "${icon}"
    else
      "$1_prompt_segment" "$0" "$2" 'white' "${color}" "${icon}"
    fi
  }

  typeset -g POWERLEVEL9K_MODE="nerdfont-complete"
  typeset -g POWERLEVEL9K_IGNORE_TERM_COLORS=true

  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0C6'
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=$'\uE0C6'
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0C7'
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=$'\uE0C7'

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # Line 1
    os_icon
    context
    dir
    dir_writable
    vcs
    goenv
    pyenv
    rbenv
    gcloud
    google_app_cred
    aws
    aws_assume_role_joined
    # Line 2
    newline
    prompt_char
  )
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    # Line 1
    status
    command_execution_time
    background_jobs
    vim_shell
    time
    date_joined
    # Line 2
    newline
  )

  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT='always'

  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_{FIRST_SEGMENT_START,LAST_SEGMENT_END}_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=

  typeset -g POWERLEVEL9K_AWS{,_ASSUME_ROLE}_SHOW_ON_COMMAND='aws|awless|terraform'
  typeset -g POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcs'
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_SHOW_ON_COMMAND='terraform'
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc'
  typeset -g POWERLEVEL9K_VCS_SHOW_ON_COMMAND='git|git-*|hub'

  typeset -g POWERLEVEL9K_GOENV_SHOW_ON_COMMAND='go|goenv|gofmt|golangci-lint'
  typeset -g POWERLEVEL9K_PYENV_SHOW_ON_COMMAND='ipython|ipython3*|pip|pip3*|python|python3*|pip|pip3*|pipenv|pyenv|*.py'
  typeset -g POWERLEVEL9K_RBENV_SHOW_ON_COMMAND='bundle|gem|irb|pry|rbenv|ruby|*.rb'

  typeset -g POWERLEVEL9K_GOENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_GOENV_PROMPT_ALWAYS_SHOW=true

  typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=true

  typeset -g POWERLEVEL9K_RBENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=true

  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  local anchor_files=(
    .bzr
    .citc
    .git
    .hg
    .node-version
    .python-version
    .ruby-version
    .shorten_folder_marker
    .svn
    .terraform
    CVS
    Cargo.toml
    composer.json
    go.mod
    package.json
  )
  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY='truncate_to_unique'

  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2

  typeset -g POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S}"
  typeset -g POWERLEVEL9K_DATE_FORMAT="%D{%Y-%m-%d}"

  typeset -g DEFAULT_USER="pierre"

  # icons
  typeset -g POWERLEVEL9K_GCLOUD_ICON=$'\uE7B2'

  # base16 colors

  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND='018'
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND='021'

  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,REMOTE}_BACKGROUND='green'
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,REMOTE}_FOREGROUND='018'
  typeset -g POWERLEVEL9K_CONTEXT_{ROOT,SUDO,REMOTE_SUDO}_BACKGROUND='red'
  typeset -g POWERLEVEL9K_CONTEXT_{ROOT,SUDO,REMOTE_SUDO}_FOREGROUND='021'

  typeset -g POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER,DEFAULT,ETC}_BACKGROUND='019'
  typeset -g POWERLEVEL9K_DIR_HOME{,_SUBFOLDER}_FOREGROUND='blue'
  typeset -g POWERLEVEL9K_DIR_{DEFAULT,ETC}_FOREGROUND='021'

  typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='red'
  typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='016'

  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_FOREGROUND='green'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VI{INS,CMD,VIS,OWR}_FOREGROUND='green'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VI{INS,CMD,VIS,OWR}_FOREGROUND='red'

  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='teal'
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='016'
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_FOREGROUND='018'

  typeset -g POWERLEVEL9K_AWS_BACKGROUND='red'
  typeset -g POWERLEVEL9K_AWS_FOREGROUND='021'

  typeset -g POWERLEVEL9K_GCLOUD_BACKGROUND='032'
  typeset -g POWERLEVEL9K_GCLOUD_FOREGROUND='white'

  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_BACKGROUND='white'
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_FOREGROUND='032'

  typeset -g POWERLEVEL9K_GOENV_BACKGROUND='cyan'
  typeset -g POWERLEVEL9K_GOENV_FOREGROUND='018'
  typeset -g POWERLEVEL9K_PYENV_BACKGROUND='blue'
  typeset -g POWERLEVEL9K_PYENV_FOREGROUND='018'
  typeset -g POWERLEVEL9K_RBENV_BACKGROUND='red'
  typeset -g POWERLEVEL9K_RBENV_FOREGROUND='018'

  typeset -g POWERLEVEL9K_STATUS_{ERROR,OK}_BACKGROUND='018'
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='red'
  typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND='green'

  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='red'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='021'

  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='017'
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='021'

  typeset -g POWERLEVEL9K_{DATE,TIME}_BACKGROUND='019'
  typeset -g POWERLEVEL9K_{DATE,TIME}_FOREGROUND='020'

  . "${POWERLEVEL9K_THEME}"

  if [[ "${POWERLEVEL}" = "10k" ]] && [[ -r "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    . "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
}

if [[ -e "${POWERLEVEL9K_THEME}" ]]; then
  setup_powerlevel9k
else
  add-zsh-hook precmd simple_prompt
fi

# }}}

# {{{ run-help-sudo

function run-help-sudo {
  if [[ $# -eq 0 ]]; then
    man sudo
  else
    man $1
  fi
}

# }}}

# {{{ Local configuration

if [[ -f "${HOME}/.zshrc.local" ]]; then
  . "${HOME}/.zshrc.local"
fi

# }}}

# {{{ Syntax highlighting

if [[ -f "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  . "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
fi

# }}}

: # noop

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
