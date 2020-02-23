# {{{ Powerlevel10k prompt

typeset -g POWERLEVEL="10k"
typeset -g POWERLEVEL9K_THEME="${ZDOTDIR:-${HOME}}/.zsh/plugins/powerlevel${POWERLEVEL}/powerlevel${POWERLEVEL}.zsh-theme"

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

if [[ -f "${POWERLEVEL9K_THEME}" ]]; then
  setup_powerlevel9k
fi

# }}}

