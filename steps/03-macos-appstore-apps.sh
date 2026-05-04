#!/bin/bash
# Install Mac App Store apps via mas, reading IDs from mac/apps
set -euo pipefail

here="$(dirname "$0")"
# shellcheck source=../lib/colors.sh
source "$(cd "$(dirname "$0")" && pwd)/../lib/colors.sh"

[[ "$(uname -s)" == "Darwin" ]] || { echo "Skipping: not macOS."; exit 0; }

brew install mas

print_step "Installing App Store apps..."
while IFS= read -r line; do
  id="${line%%#*}"
  id="${id%"${id##*[![:space:]]}"}"
  [[ -n "$id" ]] && mas install "$id"
done < "$here/../mac/apps"
