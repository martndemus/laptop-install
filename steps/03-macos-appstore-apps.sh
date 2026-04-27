#!/bin/bash
# Install Mac App Store apps via mas
set -euo pipefail

[[ "$(uname -s)" == "Darwin" ]] || { echo "Skipping: not macOS."; exit 0; }

brew install mas

mas install 1569813296 # 1Password for Safari
mas install 6745342698 # uBlock Origin Lite
mas install 1606897889 # Consent-O-Matic
