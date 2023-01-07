# {{{ Terminal title update hook

function update_terminal_title {
  local t="%m %~ %#"

  case "${TERM}" in
    screen*|tmux*)
      print -nP "\ek${t}\e\\"
      print -nP "\e]0;${t}\e\\"
      ;;
    xterm*|rxvt*|stterm*|(E|e)term)
      print -nP "\e]0;${t}\e\\"
      ;;
  esac
}

autoload -U add-zsh-hook
add-zsh-hook precmd update_terminal_title

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
