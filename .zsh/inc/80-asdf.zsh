# {{{ asdf

asdf() {
  autoload -U colors; colors

  asdf_dir="${HOMEBREW_PREFIX:-/usr/local}/opt/asdf"

  if ! [ -d "${asdf_dir}" ]; then
    echo "${fg[red]}\uF00D${reset_color} pyenv not found!" >&2
    return 1
  fi

  unset -f asdf

  export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME:-${HOME}/.config}/asdf/asdfrc"
  export ASDF_DATA_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/asdf"

  . "${asdf_dir}/libexec/asdf.sh"
  echo "${fg[green]}\uF00C${reset_color} asdf loaded!"
  unset asdf_dir

  if [[ $# -ge 1 ]]; then
    echo "${fg[blue]}❯ asdf $@${reset_color}"
    asdf "$@"
  fi
}

# }}}

# vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
