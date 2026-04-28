#!/bin/bash
# Pre-flight: ensure Full Disk Access and macOS Command Line Tools are available
set -euo pipefail

[[ "$(uname -s)" == "Darwin" ]] || { echo "Skipping: not macOS."; exit 0; }

printf "==> Checking for Full Disk Access ..."
if sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "SELECT 1" &>/dev/null; then
  echo " granted!"
else
  echo ""
  echo "    Full Disk Access is required."
  echo "    Grant \"$TERM_PROGRAM\" access, then restart it and re-run this script."
  echo "    Remember to revoke it when the install is complete."
  echo ""
  read -rsp "    Press any key to open System Settings..." -n1
  echo ""
  open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
  exit 1
fi

printf "==> Checking for Command Line Tools ..."
if xcode-select -p &>/dev/null; then
  echo " found!"
  exit 0
fi

printf "\n\n    Command Line Tools not found. Complete the installation, then re-run this script...\n"
xcode-select --install
exit 1
