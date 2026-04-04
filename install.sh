#!/bin/bash

# Homebrew
brew -v
if [ ! $? ]; then
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
fi
brew file install -f ./Brewfile

# Nix
if ! command -v nix &> /dev/null; then
  echo "==> Installing Nix..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
fi

# home-manager
if command -v nix &> /dev/null; then
  echo "==> Running home-manager switch..."
  nix run home-manager/master -- switch --flake "$(dirname "$0")"
fi
