#!/bin/bash
# macOS defaults — run via steps/04-macos-settings.sh

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
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock show-process-indicators -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock showhidden -bool true

# Hot corners — all disabled
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

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
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain NSUserDictionaryReplacementItems -array \
  '{"on" = 1; "replace" = "shrug"; "with" = "\U00af\\\_(\U30c4)_/\U00af";}' \
  '{"on" = 1; "replace" = "omw"; "with" = "On my way!";}'

# Text input
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Keyboard shortcuts: disable Switch to Desktop 1-12 and Spotlight
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 15 '{"enabled" = 0;}' 16 '{"enabled" = 0;}' 17 '{"enabled" = 0;}' 18 '{"enabled" = 0;}' 19 '{"enabled" = 0;}' 20 '{"enabled" = 0;}' 21 '{"enabled" = 0;}' 22 '{"enabled" = 0;}' 23 '{"enabled" = 0;}' 24 '{"enabled" = 0;}' 25 '{"enabled" = 0;}' 26 '{"enabled" = 0;}' 164 '{"enabled" = 0;}'

# Language & locale
defaults write NSGlobalDomain AppleLanguages -array "en-US" "nl"
defaults write NSGlobalDomain AppleLocale -string "en_US"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Menu bar
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Bluetooth" -bool true

# Screenshots
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "png"

# Startup chime
sudo nvram StartupMute=%01

# Lock screen — require password immediately on sleep or screensaver
sysadminctl -screenLock immediate -password -

# Software updates
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Save & document defaults
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
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

# Chrome
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# Security
sudo systemsetup -settimezone "Europe/Amsterdam" > /dev/null
echo yes | sudo systemsetup -setremotelogin off > /dev/null
sudo systemsetup -setremoteappleevents off > /dev/null
sudo systemsetup -setwakeonnetworkaccess off > /dev/null
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# DNS — Quad9
wifi_service=$(networksetup -listallhardwareports | awk -F': ' '/Wi-Fi/{print $2; exit}')
[[ -n "$wifi_service" ]] && sudo networksetup -setdnsservers "$wifi_service" 9.9.9.9 149.112.112.112
