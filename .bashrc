ENV="$HOME/.shrc"
export ENV
. $ENV

. "$HOME/.zprofile"

# {{{ Initial check

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

# }}}

# {{{ General settings

# History
HISTFILE=~/.bash_history
HISTFILESIZE=5000
HISTSIZE=5000
HISTCONTROL=ignoredups
shopt -s histappend
shopt -s cmdhist

# Check window size after each command
shopt -s checkwinsize

# }}}

# {{{ Smart completion

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# }}}

# {{{ Prompts

PS2="\[\033[01;35m\]>\[\033[00m\] "
PS3="\[\033[01;35m\]?#\[\033[00m\] "

# }}}

# {{{ title()

# Display the title, and append the command if given in $1
function title {
  t="${USER}@${HOSTNAME%%.*} ${PWD/$HOME/~}"

  case $TERM in
    screen)
      echo -ne "\ek$t\e\\"
      echo -ne "\e]0;$t\a"
      ;;
    xterm*|rxvt*|Eterm|eterm)
      echo -ne "\e]0;$t\a"
      ;;
  esac
}

# }}}

# {{{ precmd()

function precmd {
  # Save return code now
  _rcode=$?

  # Set window title
  title

  # Set used colors
  local _color_reset="\033[00m"
  local _color_red="\033[22;31m"
  local _color_bred="\033[01;31m"
  local _color_bgreen="\033[01;32m"
  local _color_byellow="\033[01;33m"
  local _color_bblue="\033[01;34m"
  local _color_cyan="\033[22;36m"
  local _color_white="\033[22;37m"

  local _reset_color="${_color_reset}"
  local _misc_color="${_color_white}"
  local _rcerr_color="${_color_red}"

  # Change path color given user rights on it
  if [[ -O "${PWD}" ]]; then # owner
    local _path_color="${_color_byellow}"
  elif [[ -w "${PWD}" ]]; then # can write
    local _path_color="${_color_bblue}"
  else # other
    local _path_color="${_color_bred}"
  fi

  # Display return code when not 0
  local _return_code=""
  [[ ${_rcode} != 0 ]] && _return_code="\[${_misc_color}\]!\[${_color_red}\]${_rcode}\[${_misc_color}\]! "

  # Host
  local _host="\[${_color_cyan}\]\h"

  # Current path
  local _cwd="\[${_path_color}\]\w"

  # Red # for root, green $ for user
  if [[ $UID = 0 ]]; then
    local _sign="\[${_color_bred}\]#"
  else
    local _sign="\[${_color_bgreen}\]\$"
  fi

  # Set the prompt
  PS1="${_return_code}${_host} ${_cwd} ${_sign}\[${_color_reset}\] "
}

PROMPT_COMMAND=precmd

# }}}

# vim:filetype=sh:tabstop=8:shiftwidth=2:fdm=marker:
