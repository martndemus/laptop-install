#!/bin/bash
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
steps_dir="$here/steps"
# shellcheck source=lib/colors.sh
source "$here/lib/colors.sh"

# Discover steps from steps/NN-name.sh, ordered by filename.
ALL_STEPS=()
declare -a STEP_FILES=()
for f in "$steps_dir"/[0-9]*-*.sh; do
  [[ -e "$f" ]] || continue
  name="$(basename "$f")"
  name="${name#*-}"   # strip leading "NN-"
  name="${name%.sh}"
  ALL_STEPS+=("$name")
  STEP_FILES+=("$f")
done

usage() {
  cat <<EOF
Usage: $0 [--steps=a,b,...] [--skip=a,b,...]

Steps: ${ALL_STEPS[*]}
EOF
}

selected=()
skipped=()
for arg in "$@"; do
  case "$arg" in
    --steps=*) IFS=',' read -r -a selected <<< "${arg#--steps=}" ;;
    --skip=*)  IFS=',' read -r -a skipped  <<< "${arg#--skip=}" ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $arg" >&2; usage; exit 1 ;;
  esac
done

[[ ${#selected[@]} -eq 0 ]] && selected=("${ALL_STEPS[@]}")

for step in "${selected[@]:-}" "${skipped[@]:-}"; do
  [[ -z "$step" ]] && continue
  if [[ ! " ${ALL_STEPS[*]} " == *" $step "* ]]; then
    echo "Unknown step: $step" >&2; usage; exit 1
  fi
done

should_run() {
  local step="$1"
  local sel=" ${selected[*]:-} "
  local skp=" ${skipped[*]:-} "
  [[ "$sel" == *" $step "* ]] || return 1
  [[ "$skp" == *" $step "* ]] && return 1
  return 0
}

for i in "${!ALL_STEPS[@]}"; do
  step="${ALL_STEPS[$i]}"
  if should_run "$step"; then
    label=" Running step: $step "
    pad=$(( (80 - ${#label}) / 2 ))
    rpad=$(( 80 - ${#label} - pad ))
    echo ""
    printf "${BOLD}%s${BLUE}%s${RESET}${BOLD}%s${RESET}\n" \
      "$(printf '%*s' "$pad" '' | tr ' ' '=')" \
      "$label" \
      "$(printf '%*s' "$rpad" '' | tr ' ' '=')"
    echo ""
    "${STEP_FILES[$i]}"
  fi
done

label=" Done. "
pad=$(( (80 - ${#label}) / 2 ))
rpad=$(( 80 - ${#label} - pad ))
echo ""
printf "${BOLD}%s${GREEN}%s${RESET}${BOLD}%s${RESET}\n" \
  "$(printf '%*s' "$pad" '' | tr ' ' '=')" \
  "$label" \
  "$(printf '%*s' "$rpad" '' | tr ' ' '=')"
