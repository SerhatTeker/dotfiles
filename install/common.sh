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

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# ----------------------------------------------------------------------------#
# Environments and default directories
# ----------------------------------------------------------------------------#

# Create default HOME directories if not exists
__create_home_dirs() {
	declare -a arr=(
		"dotfiles"
		"system-bak"
		"Private"
		".config"
		".cache"
		".local/share"
		".local/bin"
	)

	for dir in "${arr[@]}"
	do
        mkdir -p "${HOME}/${dir}"
    done
}

__create_home_dirs


export DOTFILES=${HOME}/dotfiles
export SYSBAK=${HOME}/system-bak
export PRIVATE=${HOME}/Private

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export CONFIG=${HOME}/.config   # Alias for XDG_CONFIG_HOME

export LOCAL_BIN="${HOME}/.local/bin"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# ----------------------------------------------------------------------------#
# Utils functions
# ----------------------------------------------------------------------------#

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

# ----------------------------------------------------------------------------#
# Colors and msg_cli
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
    _color=${1:-white}
    _message=$2
    _type=${3:-normal}


    case $_color in
        b|blue) color=${COLOR_BLUE} ;;
        g|green) color=${COLOR_GREEN} ;;
        r|red) color=${COLOR_RED} ;;
        y|yellow) color=${COLOR_YELLOW} ;;
        c|cyan) color=${COLOR_CYAN} ;;
        m|magenta) color=${COLOR_MAGENTA} ;;
        w|white) color=${COLOR_WHITE} ;;
        *) color=${COLOR_WHITE} ;;
    esac


    case $_type in
        h|header) echo -e "${color}------------------------------- ${_message} -------------------------------${COLOR_RESET}" ;;
        n|normal) echo -e "${color}${_message}${COLOR_RESET}" ;;
        *) echo -e "${color}${_message}${COLOR_RESET}" ;;
    esac
}

# ----------------------------------------------------------------------------#
# Utils from oh-my-zsh install.sh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh
# ----------------------------------------------------------------------------#

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
	truecolor|24bit) return 0 ;;
	esac

	case "$TERM" in
	iterm           |\
	tmux-truecolor  |\
	linux-truecolor |\
	xterm-truecolor |\
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

setup_color
