# {{{ OSC 7 (advise the terminal of the current working directory)

# From https://codeberg.org/dnkl/foot/wiki#zsh

function osc7 {
  local LC_ALL=C
  export LC_ALL

  setopt localoptions extendedglob
  input=( ${(s::)PWD} )
  uri=${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-\/])/%${(l:2::0:)$(([##16]#match))}}
  print -n "\e]7;file://${HOSTNAME}${uri}\e\\"
}

autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd osc7

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
