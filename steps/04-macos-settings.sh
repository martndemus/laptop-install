#!/bin/bash
# Apply macOS defaults
set -euo pipefail
# shellcheck source=../lib/colors.sh
source "$(cd "$(dirname "$0")" && pwd)/../lib/colors.sh"

[[ "$(uname -s)" == "Darwin" ]] || { echo "Skipping: not macOS."; exit 0; }

print_step "Applying macOS settings..."
# shellcheck source=../mac/settings.sh
source "$(cd "$(dirname "$0")" && pwd)/../mac/settings.sh"
