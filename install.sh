#!/bin/bash
set -eu

cd "$(dirname "$0")"

# Homebrew
if ! command -v brew &> /dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# Nix
if ! command -v nix &> /dev/null; then
  echo "==> Installing Nix..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# home-manager (also installs chezmoi, which renders the Brewfile below)
echo "==> Running home-manager switch..."
nix run home-manager/master -- switch --flake . --impure
export PATH="$HOME/.nix-profile/bin:$PATH"

# Brewfile (rendered per machine type from Brewfile.tmpl)
if ! command -v brew-file &> /dev/null; then
  brew install rcmdnk/file/brew-file
fi
brewfile="$(mktemp)"
trap 'rm -f "$brewfile"' EXIT
chezmoi execute-template < Brewfile.tmpl > "$brewfile"
brew file install -f "$brewfile"
