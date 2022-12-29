# {{{ Recompile ZSH files

# <https://github.com/htr3n/zsh-config/blob/master/zlogin>

# Execute code in the background to not affect the current session
(
    autoload -U zrecompile

    # Compile zcompdump, if modified, to increase startup speed
    local zcompdumpdir="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"
    local zcompdump="${zcompdumpdir}/zcompdump-${ZSH_VERSION}"
    mkdir -p "${zcompdumpdir}"
    if [[ -s "${zcompdump}" && (! -s "${zcompdump}.zwc" || "${zcompdump}" -nt "${zcompdump}.zwc") ]]; then
        zrecompile -pq "${zcompdump}"
    fi

    # Recompile zsh files
    zrecompile -pq ${ZDOTDIR:-${HOME}}/.zlogin
    zrecompile -pq ${ZDOTDIR:-${HOME}}/.zlogout
    zrecompile -pq ${ZDOTDIR:-${HOME}}/.zprofile
    zrecompile -pq ${ZDOTDIR:-${HOME}}/.zshenv
    zrecompile -pq ${ZDOTDIR:-${HOME}}/.zshrc

    for f in "${ZDOTDIR:-$HOME}/.sh/inc"/*.sh; do
        zrecompile -pq "${f}"
    done

    for f in "${ZDOTDIR:-$HOME}/.zsh/inc"/*.zsh; do
        zrecompile -pq "${f}"
    done
) &!

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
