# {{{ Terminal title update hook

# Display the title
function update_title {
  local t="%m %~ %#"

  case "${TERM}" in
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

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
