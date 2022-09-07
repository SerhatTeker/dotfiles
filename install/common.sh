#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                                                              _
#               ___ ___  _ __ ___  _ __ ___   ___  _ __    ___| |__
#              / __/ _ \| '_ ` _ \| '_ ` _ \ / _ \| '_ \  / __| '_ \
#             | (_| (_) | | | | | | | | | | | (_) | | | |_\__ \ | | |
#              \___\___/|_| |_| |_|_| |_| |_|\___/|_| |_(_)___/_| |_|
#
#
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# ----------------------------------------------------------------------------#

#
# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=2034
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ----------------------------------------------------------------------------#
# Environments and default directories {{{
# ----------------------------------------------------------------------------#

# Create default HOME directories if not exists
__create_home_dirs() {
    declare -a arr=(
        ".config"
        ".cache"
        ".local/bin"
        ".local/share"
        ".local/lib"
        "dotfiles"
        "system-bak"
        "Private"
    )

    for dir in "${arr[@]}"; do
        mkdir -p "${HOME}/${dir}"
    done
}

__create_home_dirs

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"

export DOTFILES="${HOME}/dotfiles"
export SYSBAK="${HOME}/system-bak"
export PRIVATE="${HOME}/Private"
export APPS="${HOME}/apps"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
# ----------------------------------------------------------------------------#
# }}}
# ----------------------------------------------------------------------------#

# ----------------------------------------------------------------------------#
# Utils functions {{{
# ----------------------------------------------------------------------------#

# Check OS {{{

is_linux() {
    local uname="$(uname -a)"

    if [[ "$uname" =~ Linux ]]; then
        return
    fi

    false
}

is_macos() {
    local uname="$(uname -a)"

    if [[ "$uname" =~ Darwin ]]; then
        return
    fi

    false
}

is_different_os() {
    if is_linux && is_macos; then
        msg_cli red "OSTYPE: ${OSTYPE} is not implemented"
        exit 1
    fi
}
# }}}

# Message helpers {{{

abort() {
    printf "%s\n" "$@" >&2
    exit 1
}

msg() {
    msg_cli white "$1" normal
}

info() {
    msg_cli blue "INFO: $1" normal
}

success() {
    msg_cli green "SUCCESS: $1" normal
}

warn() {
    msg_cli yellow "WARNING: $1" normal
}

error() {
    msg_cli red "ERROR: $1" normal
}
# }}}

# dep installed {{{
# ----------------------------------------------------------------------------#

is_installed() {
    if command_exists $1; then
        warn "$1 already installed! If you want to re-install it, first uninstall it!"
        exit 0
    fi
}

check_dep() {
    command_exists $1 || {
        error "$1 not exist, first install it!"
        exit 1
    }
}

# Check dep installed or install with brew
# $1 command to check
# $2 package to install
check_dep_or_install() {
    command_exists $1 && return
    command_exists brew || error "brew not exist, first install it!"
    brew install $2
}
# }}}

# Forced {{{
# ----------------------------------------------------------------------------#

force_remove() {
    local _source=$1
    local _target=$2

    if [ -d "${_target}" ] && [ ! -L "${_target}" ]; then
        warn "Deleting directory ${_target}"
        rm -rf ${_target}
    elif [ -f "${_target}" ] && [ ! -L "${_target}" ]; then
        warn "Deleting file ${_target}"
        rm ${_target}
    else
        [ -L "${_target}" ] && unlink "${_target}"
    fi

    ln -sf "${_source}" "${_target}"
}

error_forced() {
    error "Invalid argument(s). Installing cancelled"
    exit 1
}

# Make forced or cancel the program
make_forced() {
    # Check if both `INTERACTIVE` and `NONINTERACTIVE` are set
    # Always use single-quoted strings with `exp` expressions
    # shellcheck disable=SC2016
    if [[ -n "${INTERACTIVE-}" && -n "${NO_INTERACTIVE-}" ]]; then
        abort 'Both `$INTERACTIVE` and `$NONINTERACTIVE` are set. Please unset at least one variable and try again.'
    fi

    if [[ -z "${NO_INTERACTIVE-}" ]]; then
        printf '%sThis may overwrite existing files in your HOME directory. Are you sure? (y/n)%s ' \
            "${FMT_YELLOW}" "${FMT_RESET}"
        read -r opt
        case ${opt} in
        y* | Y* | "")
            export NO_INTERACTIVE=1
            return
            ;;
        n* | N*)
            msg_cli red "Installing cancelled." normal
            exit 0
            ;;
        *) error_forced ;;
        esac
    fi
}
# }}}

# If given file exists (regardless of type: node, directory, socket etc.)
# take a backup with time attached in UTC ISO8601 format
bakup_old() {
    local current="${1}"
    if [[ -e "${current}" ]]; then
        mv "${current}" "${current}.$(date -u '+%Y_%m_%dT%H_%M_%S').old"
    fi
}
# ----------------------------------------------------------------------------#
# }}}
# ----------------------------------------------------------------------------#

# ----------------------------------------------------------------------------#
# Utils from oh-my-zsh install.sh {{{
# ----------------------------------------------------------------------------#
# https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh

# Make sure important variables exist if not already defined
#
# $USER is defined by login(1) which is not always executed (e.g. containers)
# POSIX: https://pubs.opengroup.org/onlinepubs/009695299/utilities/id.html
USER=${USER:-$(id -u -n)}

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

user_can_sudo() {
    # Check if sudo is installed
    command_exists sudo || return 1
    # The following command has 3 parts:
    #
    # 1. Run `sudo` with `-v`. Does the following:
    #    • with privilege: asks for a password immediately.
    #    • without privilege: exits with error code 1 and prints the message:
    #      Sorry, user <username> may not run sudo on <hostname>
    #
    # 2. Pass `-n` to `sudo` to tell it to not ask for a password. If the
    #    password is not required, the command will finish with exit code 0.
    #    If one is required, sudo will exit with error code 1 and print the
    #    message:
    #    sudo: a password is required
    #
    # 3. Check for the words "may not run sudo" in the output to really tell
    #    whether the user has privileges or not. For that we have to make sure
    #    to run `sudo` in the default locale (with `LANG=`) so that the message
    #    stays consistent regardless of the user's locale.
    #
    ! LANG= sudo -n -v 2>&1 | grep -q "may not run sudo"
}

# The [ -t 1 ] check only works when the function is not called from
# a subshell (like in `$(...)` or `(...)`, so this hack redefines the
# function at the top level to always return false when stdout is not
# a tty.
if [ -t 1 ]; then
    is_tty() {
        true
    }
else
    is_tty() {
        false
    }
fi

# Adapted from code and information by Anton Kochkov (@XVilka)
# Source: https://gist.github.com/XVilka/8346728
supports_truecolor() {
    case "$COLORTERM" in
    truecolor | 24bit) return 0 ;;
    esac

    case "$TERM" in
    iterm | \
        tmux-truecolor | \
        linux-truecolor | \
        xterm-truecolor | \
        screen-truecolor) return 0 ;;
    esac

    return 1
}

fmt_underline() {
    is_tty && printf '\033[4m%s\033[24m\n' "$*" || printf '%s\n' "$*"
}

# shellcheck disable=SC2016 # backtick in single-quote
fmt_code() {
    is_tty && printf '`\033[2m%s\033[22m`\n' "$*" || printf '`%s`\n' "$*"
}

fmt_error() {
    printf '%sError: %s%s\n' "${FMT_BOLD}${FMT_RED}" "$*" "$FMT_RESET" >&2
}

setup_color() {
    # Only use colors if connected to a terminal
    if ! is_tty; then
        FMT_RED=""
        FMT_GREEN=""
        FMT_YELLOW=""
        FMT_BLUE=""
        FMT_BOLD=""
        FMT_RESET=""
        return
    fi

    FMT_RED=$(printf '\033[31m')
    FMT_GREEN=$(printf '\033[32m')
    FMT_YELLOW=$(printf '\033[33m')
    FMT_BLUE=$(printf '\033[34m')
    FMT_BOLD=$(printf '\033[1m')
    FMT_RESET=$(printf '\033[0m')
}
# ----------------------------------------------------------------------------#
# }}}
# ----------------------------------------------------------------------------#

# ----------------------------------------------------------------------------#
# Colors and msg_cli {{{
# ----------------------------------------------------------------------------#

COLOR_BLUE=$(tput setaf 4)
COLOR_RED=$(tput setaf 1)
COLOR_GREEN=$(tput setaf 2)
COLOR_YELLOW=$(tput setaf 3)
COLOR_CYAN=$(tput setaf 6)
COLOR_MAGENTA=$(tput setaf 5)
COLOR_WHITE=$(tput setaf 15)
COLOR_RESET=$(tput sgr0)

msg_cli() {
    if [ $# -ge 2 ]; then
        local _color=${1:-white}
        local message=$2
        local type=${3:-normal}

        case $_color in
        b | blue) color=${COLOR_BLUE} ;;
        g | green) color=${COLOR_GREEN} ;;
        r | red) color=${COLOR_RED} ;;
        y | yellow) color=${COLOR_YELLOW} ;;
        c | cyan) color=${COLOR_CYAN} ;;
        m | magenta) color=${COLOR_MAGENTA} ;;
        w | white) color=${COLOR_WHITE} ;;
        *) color=${COLOR_WHITE} ;;
        esac

        case $type in
        h | header) _center_text "${color}" "${message}" ;;
        n | normal) echo -e "${color}${message}${COLOR_RESET}" ;;
        *) echo -e "${color}${message}${COLOR_RESET}" ;;
        esac
    else
        local message=${1:?Message needed!}

        echo -e "${COLOR_WHITE}${message}${COLOR_RESET}"
    fi
}

# Center the text with a surrounding border
# first argument: color
# second argument: text to show
# Usage:
# $ _center_text blue "Something I want to print"
_center_text() {
    local color=${1}
    local text="${2}"
    local text_width=${#2}

    local term_width=$(tput cols)
    local ch="-"
    local padding="$(printf '%0.1s' ${ch}{1..50})"

    # TODO: Make better way
    # Adapt large/medium/small window sizes
    if [ $term_width -ge 200 ]; then
        local print_width=$(tput cols)*4/10
    elif [ $term_width -ge 120 ]; then
        local print_width=$(tput cols)*6/10
    else
        local print_width=${term_width}
    fi

    printf '%s%*.*s %s %*.*s%s\n' \
        "${color}" \
        0 \
        "$(((print_width - 2 - text_width) / 2))" \
        "${padding}" \
        "${text}" \
        0 \
        "$(((print_width - 1 - text_width) / 2))" \
        "${padding}" \
        "${COLOR_RESET}"
}
# ----------------------------------------------------------------------------#
# }}}
# ----------------------------------------------------------------------------#

main_common() {
    is_different_os
    setup_color
    make_forced
}

main_common
