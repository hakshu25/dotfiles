#!/bin/bash

# Homebrew
brew -v
if [ ! $? ]; then
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
fi
brew file install -f ./Brewfile
