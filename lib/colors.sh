#!/bin/bash
# Disable colors when NO_COLOR is set or stdout is not a terminal
if [[ -z "${NO_COLOR+x}" && -t 1 ]]; then
  BOLD=$'\033[1m'
  GREEN=$'\033[0;32m'
  YELLOW=$'\033[1;33m'
  RESET=$'\033[0m'
else
  BOLD=''
  GREEN=''
  YELLOW=''
  RESET=''
fi
