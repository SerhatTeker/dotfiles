#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                                   _           _
#                           _______| |__    ___| |__
#                          |_  / __| '_ \  / __| '_ \
#                           / /\__ \ | | |_\__ \ | | |
#                          /___|___/_| |_(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install and customize zsh
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=SC1090
source "${ROOT}/install/common.sh"

# Export main environment variables for ZSH
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSH="${XDG_DATA_HOME}/zsh/.oh-my-zsh"

DOT_ZSH="${DOTFILES}/zsh" # Alias for dotfiles zsh

# Install {{{

install_zsh() {
    if ! command_exists zsh; then
        msg_cli blue "Zsh not installed. Installing..." normal

        if is_linux; then
            sudo apt install zsh -y
        elif is_macos; then
            brew install zsh
        fi

        # make_default_shell
        msg_cli green "Zsh installed" normal
    fi
}
# }}}

# Setup shell {{{

# Use below modified one from oh-my-zsh install.sh
# cause oh-my-zsh install.sh needs user prompt input for chsh
setup_shell() {
    # If this user's login shell is already "zsh", do not attempt to switch.
    if [ "$(basename -- "$SHELL")" = "zsh" ]; then
        return
    fi

    # If this platform doesn't provide a "chsh" command, bail out.
    if ! command_exists chsh; then
        msg_cli red "I can't change your shell automatically because this system does not have chsh." normal
        msg_cli blug "Please manually change your default shell to zsh" normal
        return
    fi

    # Test for the right location of the "shells" file
    if [ -f /etc/shells ]; then
        shells_file=/etc/shells
    elif [ -f /usr/share/defaults/etc/shells ]; then # Solus OS
        shells_file=/usr/share/defaults/etc/shells
    else
        fmt_error "could not find /etc/shells file. Change your default shell manually."
        return
    fi

    # Get the path to the right zsh binary
    # 1. Use the most preceding one based on $PATH, then check that it's in the shells file
    # 2. If that fails, get a zsh path from the shells file, then check it actually exists
    if ! zsh=$(command -v zsh) || ! grep -qx "$zsh" "$shells_file"; then
        if ! zsh=$(grep '^/.*/zsh$' "$shells_file" | tail -n 1) || [ ! -f "$zsh" ]; then
            fmt_error "no zsh binary found or not present in '$shells_file'"
            fmt_error "change your default shell manually."
            return
        fi
    fi

    # We're going to change the default shell, so back up the current one
    if [ -n "$SHELL" ]; then
        echo "$SHELL" >~/.shell.pre-oh-my-zsh
    else
        grep "^$USER:" /etc/passwd | awk -F: '{print $7}' >~/.shell.pre-oh-my-zsh
    fi

    echo "Changing your shell to $zsh..."

    # Check if user has sudo privileges to run `chsh` with or without `sudo`
    #
    # This allows the call to succeed without password on systems where the
    # user does not have a password but does have sudo privileges, like in
    # Google Cloud Shell.
    #
    # On systems that don't have a user with passwordless sudo, the user will
    # be prompted for the password either way, so this shouldn't cause any issues.
    #
    if user_can_sudo; then
        sudo -k chsh -s "$zsh" "$USER" # -k forces the password prompt
    else
        chsh -s "$zsh" "$USER" # run chsh normally
    fi

    # Check if the shell change was successful
    if [ $? -ne 0 ]; then
        fmt_error "chsh command unsuccessful. Change your default shell manually."
    else
        export SHELL="$zsh"
        msg_cli green "Shell successfully changed to '$zsh'" normal
    fi

    echo
}

# Set ZDOTDIR globally
set_zdotdir() {
    # Set global ZDOTDIR
    # Hacky ugly way to fix tmux behavior
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "export ZDOTDIR=\"\$HOME/.config/zsh\"" |
            sudo tee -a /etc/zsh/zshenv
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # TODO: Implement
        echo "export ZDOTDIR=\"\$HOME/.config/zsh\"" |
            sudo tee -a /etc/zshenv
    else
        echo "No install configuration for ${OSTYPE}"
        exit 1
    fi

    msg_cli green "Succesfully set \$ZDOTDIR" normal
}
# }}}

# Soft Link {{{

# Create XDG_CONFIG_HOME link
link_xdg() {
    force_remove "${DOT_ZSH}" "${XDG_CONFIG_HOME}/zsh"
    msg_cli blue "Zsh dotfiles linked to XDG_CONFIG_HOME" normal
}

# Create personal soft links
link_personal() {
    local source_file="${PRIVATE}/${HOST/.*/}/zsh/.private.zsh"

    if [ -f "${source_file}" ]; then
        ln -sf "${source_file}" "${ZDOTDIR}/.private.zsh"
        msg_cli blue "Linked personal files" normal
    fi
}
# }}}

# oh-my-zsh {{{

install_oh-my-zsh() {
    # Fresh install: Remove if exists
    if [[ -d "${ZSH}" ]]; then
        rm -rf "${ZSH}"
    fi

    wget \
        https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
        -P /tmp

    #   --unattended: sets both CHSH and RUNZSH to 'no'
    ZSH="${ZSH}" sh /tmp/install.sh --unattended
}

# Customs {{{

# Install custom plugins
custom_plugins() {
    msg_cli blue "Installing custom plugins" normal

    ZSH_CUSTOM="${ZSH}/custom"

    # zsh-syntax-highlighting custom plugin
    # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

    # zsh-autosuggestions
    # https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone "https://github.com/zsh-users/zsh-autosuggestions" \
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

    # cd-gitroot
    # https://github.com/mollifier/cd-gitroot
    git clone "https://github.com/mollifier/cd-gitroot.git" \
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/cd-gitroot"

    # zsh-completions
    # https://github.com/zsh-users/zsh-completions
    git clone "https://github.com/zsh-users/zsh-completions" \
        "${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions"
}

# Install custom themes
custom_themes() {
    msg_cli blue "Installing custom themes" normal
    for theme in "simple" "gallois"; do
        ln -sf "${DOT_ZSH}/oh-my-zsh/custom/themes/${theme}-custom.zsh-theme" \
            "${ZSH}/custom/themes"
    done
}

# Link custom completions
custom_completions() {
    mkdir -p "${ZSH}/completions"
    ln -sf "${DOT_ZSH}/oh-my-zsh/completions/"* "${ZSH}/completions"
}
# }}}
# }}}

# Must be run with -f|--force flag or taking user approval
main() {
    is_installed zsh

    # Install
    install_zsh

    # Setup shell
    setup_shell
    set_zdotdir

    # Soft link
    link_xdg
    link_personal

    # oh-my-zsh
    install_oh-my-zsh
    custom_plugins
    custom_themes
    custom_completions

    msg_cli green "Zsh completely installed and configured. Happy zsh!" normal
}

main "$@"
