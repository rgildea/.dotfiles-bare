#!/bin/sh

# Demo script that shows how to script macOS `defaults` command
# to set many system preferences and application settings.
#
# This script is intended to work on macOS Monterey 
# running on the Apple M1 chip.
#
# These are gathered from many different sources.
#
# Thanks:
#
#   * https://macos-defaults.com
#   * https://github.com/paulmillr/dotfiles
#   * https://github.com/mathiasbynens/dotfiles
#   * https://github.com/stianeikeland/dotfiles/edit/master/bin/sanemacdefaults.sh
#   * https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/

## Software Update

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Automatically download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

## NSGlobalDomain

# Show all filename extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable subpixel font rendering on non-Apple LCDs.
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Always show scrollbars.
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Use “natural” (Lion-style) scrolling.
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Disable press-and-hold for keys in favor of key repeat.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a fast KeyRepeat rate. We prefer 1 (15ms). The default minimum is 2 (30ms). May require reboot.
defaults write NSGlobalDomain KeyRepeat -int 1 

# Set a fast initial key repeat. We prefer 4 (60ms). The default minimum is 15 (225ms). May require reboot.
defaults write NSGlobalDomain InitialKeyRepeat -int 4

## NSGlobalDomain NS*

# Save to disk (not to iCloud) by default.
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable typing automatic capitalization.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable typingautomatic period substition a.k.a. "smart stops".
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -int 0

# Disable typing automatic dash substitution e.g. "smart dashes".
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable typing automatic quote substitution a.k.a. "smart quotes".
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable typing automatic spelling correction a.k.a. "auto-correct".
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Expand save panel by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Speed up window resize time.
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

## Finder

# Show all files.
defaults write com.apple.finder AppleShowAllFiles YES

# Show all extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Empty the trash securely by default (commented out because it's slow).
#defaults write com.apple.finder EmptyTrashSecurely -bool true

# Disable the warning when changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Always open everything in Finder's list view
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"

# Allow selection of text in quicklook windows.
defaults write com.apple.finder QLEnableTextSelection -bool true

# Enable quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Show status bar.
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar.
defaults write com.apple.finder ShowPathbar -bool true

# Disable warning when the user does empty trash.
defaults write com.apple.finder WarnOnEmptyTrash -bool false

## Dock

# Move Dock to the left side of the screen
defaults write com.apple.dock "orientation" -string "left" && killall Dock

# Make Dock icons of hidden applications translucent.
defaults write com.apple.dock showhidden -bool true

# Enable iTunes track notifications in the Dock.
defaults write com.apple.dock itunes-notifications -bool true

# Show indicator lights for open applications in the Dock.
defaults write com.apple.dock show-process-indicators -bool true

# Remove the auto-hiding Dock delay.
defaults write com.apple.Dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock.
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock.
defaults write com.apple.dock autohide -bool true

# Disable expose animation.
defaults write com.apple.dock expose-animation-duration -float 0

# Dock: Make it popup faster
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -int 1

# Remove everything
dockutil --remove all > /dev/null 2>&1

# Minimal setup
dockutil --add /Applications/iTerm.app > /dev/null 2>&1
dockutil --add /Applications/Visual%20Studio%20Code.app > /dev/null 2>&1
dockutil --add /Applications/AppCleaner.app > /dev/null 2>&1
dockutil --add /System/Applications/App\ Store.app > /dev/null 2>&1
dockutil --add /System/Applications/Messages.app > /dev/null 2>&1
dockutil --add /System/Applications/System\ Preferences.app > /dev/null 2>&1
dockutil --add /Applications/Safari.app > /dev/null 2>&1
dockutil --add /Applications/Google\ Chrome.app > /dev/null 2>&1

## Screen Saver

# Require password immediately after sleep or screen saver begins.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0


## Safari

# Include the Develop menu
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Include the Internal Debug menu.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable WebKit Developer Extras preference key
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# Enable WebKit Developer Extras
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Disable universal search because we prefer privacy
defaults write com.apple.Safari UniversalSearchEnabled -bool false

# Suppress search suggestions because we prefer privacy
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Don't open "safe" downloads i.e. don't open files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Disable snapshots i.e. don't use thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool true
defaults write com.apple.Safari AutoFillPasswords -bool true
defaults write com.apple.Safari AutoFillCreditCardData -bool true
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool true


## Network Browser

# Use AirDrop over every interface.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1


## Terminal

# Only use UTF-8 in Terminal.app.
defaults write com.apple.terminal StringEncodings -array 4


## Desktop Services

# Avoid creating .DS_Store files on network volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true


## Bluetooth

# Set Bluetooth headset higher bitrate.
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

## Trackpad
# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sudo defaults write com.apple.AppleMultitouchTrackpad Clicking 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true


# Trackpad: Two-Finger-Tap
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

# Keyboard key repeat
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# Auto correct off & Auto capitalize off
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -int 0

# Disable the “reopen windows when logging back in” option
defaults write com.apple.loginwindow TALLogoutSavesState -bool false

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true



# Show the ~/Library folder.
chflags nohidden ~/Library

###############################################################################
# Energy saving                                                               #
###############################################################################

# Enable lid wakeup
sudo pmset -a lidwake 1

# Restart automatically on power loss
sudo pmset -a autorestart 1

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Sleep the display after 15 minutes
sudo pmset -a displaysleep 15

# # Disable machine sleep while charging
# sudo pmset -c sleep 0

# # Set machine sleep to 5 minutes on battery
# sudo pmset -b sleep 5

# # Set standby delay to 24 hours (default is 1 hour)
# sudo pmset -a standbydelay 86400

# # Remove the sleep image file to save disk space
# sudo rm /private/var/vm/sleepimage
# # Create a zero-byte file instead…
# sudo touch /private/var/vm/sleepimage
# # …and make sure it can’t be rewritten
# sudo chflags uchg /private/var/vm/sleepimage

## Login window

# Show host info e.g. IP address, hostname, OS version, etc. when you click the clock
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName


# Screenshots

# screenshots as jpg (usually smaller size) and not png
#defaults write com.apple.screencapture type jpg
# change screenshot destination (desktop works fine also)
defaults write com.apple.screencapture location "~/Screenshots"
# do not open prev. file previews
defaults write com.apple.Preview ApplePersistenceIgnoreState YES


# Hot corners
# Possible values: 0 no-op; 2 Mission Control; 3 Show application windows;
# 4 Desktop; 5 Start screen saver; 6 Disable screen saver; 7 Dashboard;
# 10 Put display to sleep; 11 Launchpad; 12 Notification Center
# defaults write com.apple.dock wvous-tl-corner -int 3
# defaults write com.apple.dock wvous-tl-modifier -int 0

# defaults write com.apple.dock wvous-tr-corner -int 4
# defaults write com.apple.dock wvous-tr-modifier -int 0

# defaults write com.apple.dock wvous-bl-corner -int 2
# defaults write com.apple.dock wvous-bl-modifier -int 0

defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0


# Misc Settings

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Notification Center and remove the menu bar icon
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null


# Kill affected applications.
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done