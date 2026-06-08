#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_REBASE_I_TITLE" \
  "$MSG_REBASE_I_PURPOSE" \
  "$MSG_REBASE_I_WHEN" \
  "$MSG_REBASE_I_PREREQ"

print_header "$SHA"
require_clean_state
enable_failure_rollback

printf "$MSG_REBASE_I_RANGE_FMT" "$SHA"
echo

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_REBASE_I_DIRTY_TREE" >&2
  exit 1
fi

if ! git rev-parse --verify --quiet "${SHA}^" >/dev/null 2>&1; then
  printf "$MSG_COMMON_ROOT_COMMIT_FMT" "$SHA" >&2
  echo "$MSG_COMMON_ROOT_HINT" >&2
  exit 1
fi

confirm "$MSG_REBASE_I_CONTINUE"
git rebase -i --autosquash "${SHA}^"
