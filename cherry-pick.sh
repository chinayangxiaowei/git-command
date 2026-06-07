#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_CHERRY_PICK_TITLE" \
  "$MSG_CHERRY_PICK_PURPOSE" \
  "$MSG_CHERRY_PICK_WHEN" \
  "$MSG_CHERRY_PICK_NOTE"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

current="$(git rev-parse --abbrev-ref HEAD)"
printf "$MSG_CHERRY_PICK_CURRENT_FMT" "$current"
echo

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_CHERRY_PICK_DIRTY_TREE" >&2
  exit 1
fi

short=$(git rev-parse --short "$SHA")
confirm "$(printf "$MSG_CHERRY_PICK_CONFIRM_FMT" "$short" "$current")"
run_or_abort cherry-pick git cherry-pick "$SHA"
