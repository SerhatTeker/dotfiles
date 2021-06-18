export ZDOTDIR="$HOME/.zsh"

# ENV {{{1

# DOTNET
# Turning off Telemetry Data in .NET Core
DOTNET_CLI_TELEMETRY_OPTOUT=1


# NeoVim Resource {{{2

export MYNVIMRC=$HOME/dotfiles/vim/.nvimrc
# export MYNVIMRC=$HOME/.nvimrc
# }}}2

# npm node {{{2

# Changing the location of global npm packages
# $ mkdir ~/.node_modules
# $ npm config set prefix=$HOME/.node_modules
# $ npm install npm@latest -g
export PATH="$HOME/.node_modules/bin:$PATH"
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