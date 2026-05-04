#!/bin/bash
# Disable colors when NO_COLOR is set or stdout is not a terminal
if [[ -z "${NO_COLOR+x}" && -t 1 ]]; then
  BOLD=$'\033[1m'      # bold default  (banner delimiters)
  BLUE=$'\033[1;34m'   # bright blue   (step label text)
  GREEN=$'\033[1;32m'  # bold green    (Done label, success messages)
  YELLOW=$'\033[1;33m' # bold yellow   (warnings)
  RESET=$'\033[0m'
else
  BOLD=''
  BLUE=''
  GREEN=''
  YELLOW=''
  RESET=''
fi

print_step() { echo "==> $*"; }
print_ok()   { echo "${GREEN}$*${RESET}"; }
print_warn() { echo "${YELLOW}Warning: $*${RESET}"; }
