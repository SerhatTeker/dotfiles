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

# INFO: Not using since not working inside tmux
# Enable Touch ID for sudo
# Separate pam module needed for tmux
# https://github.com/fabianishere/pam_reattach
touch_id_sudo() {
    sudo tee /etc/pam.d/sudo &>/dev/null <<EOF
# sudo: auth account password session
auth       sufficient     pam_tid.so
auth       sufficient     pam_smartcard.so
auth       required       pam_opendirectory.so
account    required       pam_permit.so
password   required       pam_deny.so
session    required       pam_permit.so
EOF
}

# Dock
dock() {
    # Autohide the Dock when the mouse is out
    defaults write com.apple.dock "autohide" -bool "true"

    # MacBook Air tile size
    defaults write com.apple.dock "tilesize" -int "42"

    # Don't show recent apps in the Dock
    defaults write com.apple.dock show-recents -bool false

    # ---------------------------------------------------------
    # Custom Dock Apps
    # ---------------------------------------------------------

    # 1. Wipe all default app icons (Finder and Trash will remain)
    defaults write com.apple.dock persistent-apps -array

    # 2. Add Google Chrome
    defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

    # 3. Add Ghostty
    defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Ghostty.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
}

# TODO: need testing
#
## Keyboard
# * Key Repeat: Fastest & Delay Until Repeat: Short
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

    # Key Repeat: Fastest & Delay Until Repeat: Short
    # Note: 2 (30ms) is the UI minimum for KeyRepeat, 15 (225ms) is the UI minimum for InitialKeyRepeat
    defaults write -g KeyRepeat -int 2
    defaults write -g InitialKeyRepeat -int 15

    # Disable: Adjust keyboard brightness
    defaults write com.apple.BezelServices kDim -bool false

    # Press "World" (Globe key): "Do Nothing"
    defaults write com.apple.HIToolbox AppleFnUsageType -int 0

    # Enable: Use F1, F2 keys as standard function keys
    defaults write -g com.apple.keyboard.fnState -bool true

    # Modifier Keys:
    # 1. Caps Lock (0x700000039) -> Escape (0x700000029)
    # 2. Globe/Fn (0xFF00000003) -> Left Control (0x7000000E0)
    # 3. Left Control (0x7000000E0) -> Globe/Fn (0xFF00000003)
    hidutil property --set '{"UserKeyMapping":[
        {"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029},
        {"HIDKeyboardModifierMappingSrc":0xFF00000003,"HIDKeyboardModifierMappingDst":0x7000000E0},
        {"HIDKeyboardModifierMappingSrc":0x7000000E0,"HIDKeyboardModifierMappingDst":0xFF00000003}
    ]}' > /dev/null

    # Input Sources: Add US and make it default
    # Note: This overwrites the current array to enforce US as the clean default.
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>0</integer><key>KeyboardLayout Name</key><string>U.S.</string></dict>'
    defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID "com.apple.keylayout.US"
}

trackpad() {
    # Tap to click
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Click firmness (Medium)
    # 0 = Light, 1 = Medium, 2 = Firm
    defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
    defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1

    # Tracking Speed
    #
    # Standard range is 0.0 (Slow) to 3.0 (Fast).
    # Your screenshot shows it on the 4th tick mark out of 10.
    # 0.875 closely matches that specific UI placement. (1.0 is dead center).
    defaults write -g com.apple.trackpad.scaling -float 0.875
}

corners() {
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

# Disable:
# * Re-arrange Spaces
# * Group windows
mission_control() {
    defaults write com.apple.dock "mru-spaces" -bool false
    defaults write com.apple.dock expose-group-apps -bool false
}

desktop() {
    # Store screenshots in subfolder on desktop
    local ss_dir="${HOME}/Desktop/screenshots"
    mkdir -p "${ss_dir}"
    defaults write com.apple.screencapture location "${ss_dir}"
}

finder() {
    # Show the full path at the bottom of Finder
    defaults write com.apple.finder ShowPathbar -bool true

    # Show all file extensions
    defaults write -g AppleShowAllExtensions -bool true

    # Unhide the ~/Library folder
    chflags nohidden ~/Library
}

# See the changes
see_changes() {
    killall Dock
    killall Finder
    killall SystemUIServer
}

main() {
    # Quit System Preferences so it doesn't override settings
    osascript -e 'tell application "System Preferences" to quit'

    dock
    keyboard
    trackpad
    corners
    mission_control
    desktop
    finder

    see_changes
}

main
