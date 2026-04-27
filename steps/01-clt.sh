#!/bin/bash
# Install/update macOS Command Line Tools
set -euo pipefail

[[ "$(uname -s)" == "Darwin" ]] || { echo "Skipping: not macOS."; exit 0; }

# softwareupdate -l output uses "* Label: <name>" on recent macOS.
# Returns the most recent matching label, or empty if none.
find_clt_label() {
  softwareupdate -l 2>/dev/null \
    | awk -F'Label: ' '/^\* .*Command Line Tools/ {print $2}' \
    | tail -n1
}

if ! xcode-select -p &>/dev/null; then
  echo "Installing Command Line Tools..."
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  product=$(find_clt_label)
  if [[ -n "$product" ]]; then
    softwareupdate -i "$product" --verbose
  else
    xcode-select --install
    echo "Complete the Command Line Tools installation in the GUI prompt, then re-run this script."
    exit 1
  fi
  rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
else
  echo "Command Line Tools already installed; checking for updates..."
  product=$(find_clt_label)
  if [[ -n "$product" ]]; then
    softwareupdate -i "$product" --verbose
  else
    echo "No Command Line Tools updates available."
  fi
fi
