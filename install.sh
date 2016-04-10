#!/bin/sh

# Install symlinks for a set of dotfiles

set -e

# Assume lite set by default, this is will be the most commonly used set
DEFAULT_SET=lite

usage() {
    echo "$0 [options] [<set>]" >&2
    echo "  -d <destdir>  # destination directory (default: ${HOME})"
    echo "  -f            # force overwriting existing files"
    echo "  -q            # quiet"
    echo "  -h            # help"
    echo "Default set: ${DEFAULT_SET}"
}

usage_error() {
    echo "Error: $@" >&2
    usage
    exit 1
}

help() {
    usage
    exit 0
}

error() {
    echo "Error: $@" >&2
}

puts() { [ "${quiet}" -eq 1 ] && return
    echo $@
}

load_set() {
    set_file="${sets}/${set}"
    if ! [ -f "${set_file}" ]; then
        error "Set ${set} does not exist!"
        exit 1
    fi
    sed -e '/^$/d' -e '/^#/d' "${set_file}"
}

install() {
    file_dir="$(dirname "$1")"
    if ! [ -d "${destdir}/${file_dir}" ]; then
        makedirs "${destdir}/${file_dir}"
    fi
    if [ -e "${destdir}/$1" -a "${force}" -ne 1 ]; then
        puts "SKIP $1 (use -f to force)"
        return
    fi
    symlink "$1"
}

makedirs() {
    puts "MAKEDIRS $1"
    mkdir -p "$1"
}

symlink() {
    puts "SYMLINK $1 -> ${destdir}/$1"
    ln -snf "${dotfiles}/$1" "${destdir}/$1"
}

dotfiles="$(readlink -f $(dirname $0))"
sets="${dotfiles}/sets"

set="${DEFAULT_SET}"
force=0
quiet=0
destdir="${HOME}"

while [ $# -ne 0 ]; do
    case $1 in
        -d)
            shift
            if [ $# -eq 0 ]; then
                usage_error "Missing argument for -d"
            fi
            destdir="$1"
            ;;
        -f)
            force=1
            ;;
        -q)
            quiet=1
            ;;
        -h)
            help
            ;;
        -*)
            usage_error "Unknown option: $1"
            ;;
        *)
            set=$1; shift
            if [ $# -ne 0 ]; then
                usage_error "Unexpected extra arguments: $@"
            fi
            break
            ;;
    esac
    shift
done

puts "Set: ${set}"
puts "Destination directory: ${destdir}"
puts

files=$(load_set "${set}")
for file in $files; do
    install "${file}"
done

puts
puts "Done."
exit 0
