#
#                      _           _        _ _       _
#                     (_)_ __  ___| |_ __ _| | |  ___| |__
#                     | | '_ \/ __| __/ _` | | | / __| '_ \
#                     | | | | \__ \ || (_| | | |_\__ \ | | |
#                     |_|_| |_|___/\__\__,_|_|_(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Main script to install dotfiles
# Warning : WIP
# ----------------------------------------------------------------------------#
#	ZSH	{{{1
# ----------------------------------------------------------------------------#

DOTFILES="$HOME/dotfiles"
SYSBAK="$HOME/system-bak"

# Craete ZDOTDIR
mkdir "$HOME/.zsh"
# Export main environment variables for ZSH
export ZMAIN="$HOME/.zsh"
export ZDOTDIR=$ZMAIN

# oh-my-zsh {{{2

# install ohmyzsh
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
export ZSH="$HOME/.oh-my-zsh"
ZSH="$HOME/.oh-my-zsh" sh install.sh
rm install.sh

# plugins {{{3

# zsh-syntax-highlighting custom plugin
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# }}}#

# Set global ZDOTDIR
# Hacky ugly way to fix tmux behavior
echo "export ZDOTDIR=\"${HOME}/.zsh\"" | sudo tee -a /etc/zsh/zshenv
# }}}2

# link configs {{{2

# create soft links
ln -s $DOTFILES/zsh/.zshrc $ZMAIN/.zhsrc
ln -s $DOTFILES/zsh/.zlogin $ZMAIN/.zlogin
ln -s $DOTFILES/zsh/.agnoster.zsh $ZMAIN/.agnoster.zsh
ln -s $DOTFILES/zsh/.fzf.zsh $ZMAIN/.fzf.zsh
ln -s $DOTFILES/zsh/.p10k.zsh $ZMAIN/.p10k.zsh
ln -s $SYSBAK/zsh/.zsh_private $ZMAIN/.zsh_private
#   }}}2
# ----------------------------------------------------------------------------#
#   }}}1
# ----------------------------------------------------------------------------#
