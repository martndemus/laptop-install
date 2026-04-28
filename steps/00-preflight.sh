#!/bin/bash
# Pre-flight: ensure macOS Command Line Tools are installed
set -euo pipefail

[[ "$(uname -s)" == "Darwin" ]] || { echo "Skipping: not macOS."; exit 0; }

printf "==> Checking for Command Line Tools ..."
if xcode-select -p &>/dev/null; then
  echo " found!"
  exit 0
fi

printf "\n\n    Command Line Tools not found. Complete the installation, then re-run this script...\n"
xcode-select --install
exit 1
