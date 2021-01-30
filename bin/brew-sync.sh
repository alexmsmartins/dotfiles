#!/bin/bash

# Sync Homebrew installations between Macs via Dropbox
#

BREW="/usr/local/bin/brew"

# first get local settings
echo "Reading local settings ..."
rm -f /tmp/brew-sync.*
$BREW tap > /tmp/brew-sync.taps
$BREW list --formula > /tmp/brew-sync.installed
$BREW list --cask > /tmp/brew-sync.cask

# then combine it with list in Dropbox
echo "Reading settings from Dropbox ..."
[ -e ~/Dropbox/Apps/Homebrew/brew-sync.taps ] && cat ~/Dropbox/Apps/Homebrew/brew-sync.taps >> /tmp/brew-sync.taps
[ -e ~/Dropbox/Apps/Homebrew/brew-sync.installed ] && cat ~/Dropbox/Apps/Homebrew/brew-sync.installed >> /tmp/brew-sync.installed
[ -e ~/Dropbox/Apps/Homebrew/brew-sync.cask ] && cat ~/Dropbox/Apps/Homebrew/brew-sync.cask >> /tmp/brew-sync.cask

# make the lists unique and sync into Dropbox
echo "Syncing to Dropbox ..."
mkdir -p ~/Dropbox/Apps/Homebrew
cat /tmp/brew-sync.taps | sort | uniq > ~/Dropbox/Apps/Homebrew/brew-sync.taps
cat /tmp/brew-sync.installed | sort | uniq > ~/Dropbox/Apps/Homebrew/brew-sync.installed
cat /tmp/brew-sync.cask | sort | uniq > ~/Dropbox/Apps/Homebrew/brew-sync.cask

# Set taps
echo "Enabling taps ..."
for TAP in `cat ~/Dropbox/Apps/Homebrew/brew-sync.taps`; do
	$BREW tap ${TAP} >/dev/null
done

# Install missing Homebrew packages
echo "Install missing packages ..."
for PACKAGE in `cat ~/Dropbox/Apps/Homebrew/brew-sync.installed`; do
	$BREW list --formula ${PACKAGE} >/dev/null
	[ "$?" != "0" ] && $BREW install ${PACKAGE}
done
echo "Install missing casks ..."
for PACKAGE in `cat ~/Dropbox/Apps/Homebrew/brew-sync.cask`; do
	$BREW list --cask ${PACKAGE} >/dev/null
	[ "$?" != "0" ] && $BREW install ${PACKAGE}
done
