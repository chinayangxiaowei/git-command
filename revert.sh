#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_REVERT_TITLE" \
  "$MSG_REVERT_PURPOSE" \
  "$MSG_REVERT_WHEN" \
  "$MSG_REVERT_CONTRAST"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_REVERT_DIRTY_TREE" >&2
  exit 1
fi

short=$(git rev-parse --short "$SHA")
confirm "$(printf "$MSG_REVERT_CONFIRM_FMT" "$short")"
run_or_abort revert git revert --no-edit "$SHA"
