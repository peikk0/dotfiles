# {{{ Vi

bindkey -v

# }}}

# {{{ Fixes from Debian

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

# }}}

# {{{ URxvt keys

bindkey "\e[2~" overwrite-mode
bindkey "\e[3~" delete-char
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[5~" history-search-backward
bindkey "\e[6~" history-search-forward

# }}}

# {{{ Man

bindkey "\eh" run-help

function run-help-sudo {
  if [[ $# -eq 0 ]]; then
    man sudo
  else
    man $1
  fi
}

# }}}

# {{{ Edit command line

autoload edit-command-line
zle -N edit-command-line
bindkey "\ee" edit-command-line
bindkey "\ex" execute-named-cmd

# }}}

# {{{ () [] {} ...

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

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
