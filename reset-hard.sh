#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_RESET_HARD_TITLE" \
  "$MSG_RESET_HARD_PURPOSE" \
  "$MSG_RESET_HARD_WHEN" \
  "$MSG_RESET_HARD_AFTER"

print_header "$SHA"

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  printf "$MSG_RESET_HARD_NOT_ANCESTOR_FMT" "$SHA" >&2
  exit 1
fi

if [[ "$(git rev-parse "$SHA")" == "$(git rev-parse HEAD)" ]]; then
  printf "$MSG_RESET_HARD_IS_HEAD_FMT" "$SHA" >&2
  exit 1
fi

current="$(git rev-parse --abbrev-ref HEAD)"
target_short="$(git rev-parse --short "$SHA")"

printf "$MSG_RESET_HARD_CURRENT_BRANCH_FMT" "$current"
echo
echo "$MSG_RESET_HARD_WILL_DROP"
git --no-pager log --oneline "${SHA}..HEAD"
echo
echo "$MSG_RESET_HARD_WT_LOST"
git --no-pager status --short
echo

printf "$MSG_RESET_HARD_YES_PROMPT_FMT" "$target_short"
read -r ans
if [[ "$ans" != "YES" ]]; then
  echo "$MSG_RESET_HARD_NO_YES"
  exit 0
fi

echo
echo "$MSG_RESET_HARD_REFLOG_HINT"
git reset --hard "$SHA"
