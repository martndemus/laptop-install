#!/bin/bash
# Install Homebrew and packages from brew/{formulae,casks}
set -euo pipefail

here="$(dirname "$0")"

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for Apple Silicon
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew already installed."
fi

mapfile -t formulae < "$here/../brew/formulae"
brew install "${formulae[@]}"

mapfile -t casks < "$here/../brew/casks"
brew install --cask "${casks[@]}"
