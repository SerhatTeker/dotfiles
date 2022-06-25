#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# MacOS Preferences

# Theme : auto
# Night shift : Sunset to Sunrise
# Preferred language : English US (primary)
# Security : Enable firewall except SSH

# Dock
dock() {
    # Autohide the Dock when the mouse is out
    defaults write com.apple.dock "autohide" -bool "true"
    # MacBook Air
    defaults write com.apple.dock "tilesize" -int "42"
    killall Dock
}

# TODO: find and write
## Keyboard
# * Disable: Adjust keyboard brightness
# * Press "World": "Do Nothing"
# * Enable: Use F1, F2 keys as standard function keys
## Modifier Keys:
# * Caps Lock: Escape
# * Switch Globe and ^Control key
## Input Sources
# Add US and make it default
keyboard() {
    # Disable press-and-hold for keys in favor of key repeat
    defaults write -g ApplePressAndHoldEnabled -bool false
    defaults write -g FullKeyboardAccessEnabled -bool true

    defaults write com.apple.Accessibility KeyRepeatEnabled -bool true

    # Set a really fast initial and subsequent key repeat
    defaults write -g KeyRepeat -int 1          # normal minimum is 2 (30 ms)
    defaults write -g InitialKeyRepeat -int 10  # normal minimum is 15 (225 ms)

    # Turn text completion off on touchbar (no need for that!)
    defaults write -g NSAutomaticTextCompletionEnabled -bool false
}

corners(){
    # Hot corners
    # Possible values:
    #  0: no-op
    #  2: Mission Control
    #  3: Show application windows
    #  4: Desktop
    #  5: Start screen saver
    #  6: Disable screen saver
    #  7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center
    # 13: Lock Screen
    # tl, tr, bl, br
    # Bottom left screen corner → Lock screen
    defaults write com.apple.dock wvous-bl-corner -int 13
    defaults write com.apple.dock wvous-bl-modifier -int 0
    # Bottom Right screen corner → Desktop
    defaults write com.apple.dock wvous-br-corner -int 4
    defaults write com.apple.dock wvous-br-modifier -int 0
}

# INFO: Not used
# TODO: find and write
# Disable:
# * rearrange spaces
# * Group windows
mission_control() {
    echo
}

# INFO: Not used
desktop() {
    # Store screenshots in subfolder on desktop
    mkdir ~/Desktop/Screenshots
    defaults write com.apple.screencapture location ~/Desktop/Screenshots
}

main() {
    dock
    keyboard
    corners
}

main
