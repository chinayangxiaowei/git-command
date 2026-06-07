#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_STASH_POP_TITLE" \
  "$MSG_STASH_POP_PURPOSE" \
  "$MSG_STASH_POP_WHEN" \
  "$MSG_STASH_POP_NOTE"

if ! git rev-parse --verify --quiet stash@{0} >/dev/null 2>&1; then
  echo "$MSG_STASH_POP_EMPTY" >&2
  exit 1
fi

echo "$MSG_STASH_POP_LIST_HEADER"
git --no-pager stash list | head -5
echo
echo "$MSG_STASH_POP_PREVIEW_HEADER"
git --no-pager stash show --stat stash@{0}
echo

confirm "$MSG_STASH_POP_CONFIRM"

if ! git stash pop; then
  echo
  echo "$MSG_STASH_POP_CONFLICT" >&2
  echo "$MSG_STASH_POP_CONFLICT_HINT" >&2
  exit 1
fi
