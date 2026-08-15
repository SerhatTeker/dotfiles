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

pointer() {
    # Accessibility > Display > Pointer
    # Yellow fill + black outline + slightly larger size for high visibility.
    # Values captured from the UI (macOS stores the color channels as strings).
    defaults write com.apple.universalaccess cursorFill -dict \
        red "0.9994240403" green "0.9855536819" blue 0 alpha 1
    defaults write com.apple.universalaccess cursorOutline -dict \
        red 0 green 0 blue 0 alpha 1
    defaults write com.apple.universalaccess cursorIsCustomized -bool true

    # Pointer size (1.0 = Normal, ~4.0 = Large)
    defaults write com.apple.universalaccess mouseDriverCursorSize -float 1.2578125
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

# Lock Screen
# Require password immediately after sleep / screen saver begins, so closing
# the lid (which sleeps the Mac) locks it right away.
lock_screen() {
    # Modern macOS (Catalina+) manages this via sysadminctl.
    # Prompts once for your login password.
    sysadminctl -screenLock immediate -password -

    # Legacy fallback for older macOS (ignored on newer versions).
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
}

# OpenSuperWhisper: local push-to-talk dictation
# https://github.com/Starmel/OpenSuperWhisper
#
# Installed as a cask by install/brew.sh. Only the settings live here, because
# the app keeps everything in UserDefaults and has no config file to link.
#
# Manual steps this cannot do:
# * Grant Microphone, Accessibility and Input Monitoring in System Settings.
#   Without Accessibility it transcribes but cannot paste anywhere.
# * Download a model from the app: Settings > Model.
opensuperwhisper() {
    local domain="ru.starmel.OpenSuperWhisper"

    # The first-run onboarding overwrites these, so writing them before the
    # app has ever been opened achieves nothing. install.sh runs defaults
    # before brew, so on a new machine open the app once, finish onboarding,
    # then run this script again.
    if [[ "$(defaults read ${domain} hasCompletedOnboarding 2>/dev/null || echo 0)" != "1" ]]; then
        warn "OpenSuperWhisper: open it once and finish onboarding, then re-run"
        return 0
    fi

    # A running app rewrites its own plist on exit and would discard these
    if pgrep -x OpenSuperWhisper > /dev/null; then
        killall OpenSuperWhisper
    fi

    # Push-to-talk on Right Option: hold to record, release to stop.
    # Left Control and Globe/Fn are taken by the remap in keyboard(), and
    # AeroSpace owns the alt-<key> combinations. A bare Right Option hold
    # sends no key, so it collides with neither.
    # Cost: Right Option no longer types alternate glyphs such as é.
    defaults write ${domain} modifierOnlyHotkey -string "rightOption"
    defaults write ${domain} lastModifierOnlyHotkey -string "rightOption"
    defaults write ${domain} holdToRecord -bool true

    # Paste the transcription into whatever has focus, which is what puts it
    # in the Claude Code prompt. It does not press Enter.
    defaults write ${domain} autoPasteTranscription -bool true
    # Keep a copy on the clipboard in case another window steals focus
    defaults write ${domain} autoCopyToClipboard -bool true

    # Background menu bar app, no window on launch
    defaults write ${domain} startHiddenInMenuBar -bool true
    # Audible proof the key registered, silent failure is the usual annoyance
    defaults write ${domain} playSoundOnRecordStart -bool true
    # Esc drops a bad take without a dialog
    defaults write ${domain} escCancelWithoutConfirmation -bool true

    # Skip language auto-detection: faster and more accurate when it is known
    defaults write ${domain} whisperLanguage -string "en"
    defaults write ${domain} suppressBlankAudio -bool true
    defaults write ${domain} addSpaceAfterSentence -bool true

    # Whisper takes this as context and it biases the spelling of what it
    # hears. Without it, dictated technical words come out wrong. Extend the
    # list as needed.
    # NOTE: only the whisper engine reads this. It is inert while
    # selectedEngine is fluidaudio (Parakeet), which onboarding picks.
    defaults write ${domain} initialPrompt -string \
        "Technical dictation for a software engineer. Terms include Claude Code, git, rebase, repo, PR, Django, Python, Kubernetes, kubectl, Postgres, refactor, endpoint, migration, payload, webhook, backend, async, boolean, nullable, stdout, CLI."
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
    pointer
    corners
    mission_control
    desktop
    finder
    lock_screen
    opensuperwhisper

    see_changes
}

main
