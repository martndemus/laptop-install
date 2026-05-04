#!/bin/bash
# Apply macOS defaults
set -euo pipefail
# shellcheck source=../lib/colors.sh
source "$(cd "$(dirname "$0")" && pwd)/../lib/colors.sh"

[[ "$(uname -s)" == "Darwin" ]] || { echo "Skipping: not macOS."; exit 0; }

# Accessibility
defaults write com.apple.universalaccess reduceTransparency -bool true
defaults write com.apple.universalaccess reduceMotion -bool true
defaults write com.apple.universalaccess mouseDriverCursorSize -int 2
defaults write com.apple.universalaccess flashScreen -bool true
defaults write com.apple.universalaccess differentiateWithoutColor -bool true
defaults write NSGlobalDomain com.apple.sound.beep.flash -bool true

# Appearance
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock show-process-indicators -bool false
defaults write com.apple.dock show-recents -bool false

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Window Manager
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
defaults write com.apple.WindowManager HideDesktop -bool true

# Trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true
defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -int 0
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 2
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 2
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false

# Keyboard
defaults write com.apple.HIToolbox AppleFnUsageType -int 2
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain NSUserDictionaryReplacementItems -array \
  '{"on" = 1; "replace" = "shrug"; "with" = "\U00af\\\_(\U30c4)_/\U00af";}' \
  '{"on" = 1; "replace" = "omw"; "with" = "On my way!";}'

# Keyboard shortcuts: disable Switch to Desktop 1-12 and Spotlight
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 15 '{"enabled" = 0;}' 16 '{"enabled" = 0;}' 17 '{"enabled" = 0;}' 18 '{"enabled" = 0;}' 19 '{"enabled" = 0;}' 20 '{"enabled" = 0;}' 21 '{"enabled" = 0;}' 22 '{"enabled" = 0;}' 23 '{"enabled" = 0;}' 24 '{"enabled" = 0;}' 25 '{"enabled" = 0;}' 26 '{"enabled" = 0;}' 164 '{"enabled" = 0;}'

# Menu bar
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Bluetooth" -bool true

# Startup chime
sudo nvram StartupMute=%01

# Lock screen
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Safari (requires Full Disk Access for the terminal app)
if defaults write com.apple.Safari IncludeDevelopMenu -bool true 2>/dev/null; then
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
  defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true
  defaults write com.apple.Safari PreloadTopHit -bool false
  defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
  defaults write com.apple.Safari ShowOverlayStatusBar -bool true
  defaults write com.apple.Safari DownloadsClearingPolicy -int 2
  defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
  defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
  defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
else
  echo "${YELLOW}Warning: Skipped Safari settings: grant Full Disk Access to your terminal app in"
  echo "  System Settings > Privacy & Security > Full Disk Access, then re-run.${RESET}"
fi
