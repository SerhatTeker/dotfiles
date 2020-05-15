# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi


# BIN {{{1

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
# }}}1


# ENV {{{1

# DOTNET
# Turning off Telemetry Data in .NET Core
DOTNET_CLI_TELEMETRY_OPTOUT=1


# NeoVim Resource {{{2

export MYNVIMRC=$HOME/.nvimrc
# }}}2

# Colors {{{2

export COLOR_BLACK="\e[0;30m"
export COLOR_BLUE="\e[0;34m"
export COLOR_GREEN="\e[0;32m"
export COLOR_CYAN="\e[0;36m"
export COLOR_PINK="\e[0;35m"
export COLOR_RED="\e[0;31m"
export COLOR_PURPLE="\e[0;35m"
export COLOR_BROWN="\e[0;33m"
export COLOR_LIGHTGRAY="\e[0;37m"
export COLOR_DARKGRAY="\e[1;30m"
export COLOR_LIGHTBLUE="\e[1;34m"
export COLOR_LIGHTGREEN="\e[1;32m"
export COLOR_LIGHTCYAN="\e[1;36m"
export COLOR_LIGHTRED="\e[1;31m"
export COLOR_LIGHTPURPLE="\e[1;35m"
export COLOR_YELLOW="\e[1;33m"
export COLOR_WHITE="\e[1;37m"
export COLOR_NONE="\e[0m"
# }}}2
# }}}1
