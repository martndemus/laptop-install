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

# zsh compaudit flags group-writable completion dirs; 755 removes group write
chmod 755 /opt/homebrew/share

formulae=()
while IFS= read -r pkg; do formulae+=("$pkg"); done < "$here/../brew/formulae"
brew install "${formulae[@]}"

casks=()
while IFS= read -r pkg; do casks+=("$pkg"); done < "$here/../brew/casks"
brew install --cask "${casks[@]}"
