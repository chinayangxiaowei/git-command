#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_STASH_PUSH_TITLE" \
  "$MSG_STASH_PUSH_PURPOSE" \
  "$MSG_STASH_PUSH_WHEN" \
  "$MSG_STASH_PUSH_NOTE"

if git diff --quiet && git diff --cached --quiet; then
  echo "$MSG_STASH_PUSH_CLEAN" >&2
  exit 1
fi

echo "$MSG_STASH_PUSH_WILL_STASH"
git --no-pager status --short
echo

read -erp "$MSG_STASH_PUSH_NAME_PROMPT" name
if [[ -z "$name" ]]; then
  echo "$MSG_STASH_PUSH_NO_NAME"
  exit_ok
fi

git stash push -m "$name"
echo
echo "$MSG_STASH_PUSH_DONE_HINT"
echo "$MSG_STASH_PUSH_UNTRACKED_NOTE"
