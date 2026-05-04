#!/bin/bash
# Install Homebrew and packages from brew/{formulae,casks}
set -euo pipefail

here="$(dirname "$0")"
# shellcheck source=../lib/colors.sh
source "$(cd "$(dirname "$0")" && pwd)/../lib/colors.sh"

if ! command -v brew &>/dev/null; then
  print_step "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for Apple Silicon
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  print_step "Homebrew already installed."
fi

# zsh compaudit flags group-writable completion dirs; 755 removes group write
chmod 755 /opt/homebrew/share

formulae=()
while IFS= read -r pkg; do formulae+=("$pkg"); done < "$here/../brew/formulae"
print_step "Installing formulae..."
brew install -q "${formulae[@]}"

casks=()
while IFS= read -r pkg; do casks+=("$pkg"); done < "$here/../brew/casks"
print_step "Installing casks..."
brew install -q --cask "${casks[@]}"

print_step "Upgrading and cleaning up..."
brew upgrade -gq
brew cleanup -q --prune=all
