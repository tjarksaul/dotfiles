#!/bin/bash

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
sudo -v # ask for password only at the beginning

brew update
brew upgrade --all
brew tap homebrew/dupes
brew tap homebrew/versions

./brew.sh
./cask.sh

brew cleanup
