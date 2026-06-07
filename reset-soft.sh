#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_RESET_SOFT_TITLE" \
  "$MSG_RESET_SOFT_PURPOSE" \
  "$MSG_RESET_SOFT_WHEN" \
  "$MSG_RESET_SOFT_AFTER"

print_header "$SHA"

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  printf "$MSG_RESET_SOFT_NOT_ANCESTOR_FMT" "$SHA" >&2
  exit 1
fi

if [[ "$(git rev-parse "$SHA")" == "$(git rev-parse HEAD)" ]]; then
  printf "$MSG_RESET_SOFT_IS_HEAD_FMT" "$SHA" >&2
  exit 1
fi

current="$(git rev-parse --abbrev-ref HEAD)"
target_short="$(git rev-parse --short "$SHA")"
printf "$MSG_RESET_SOFT_CURRENT_BRANCH_FMT" "$current"
echo
printf "$MSG_RESET_SOFT_WILL_DROP_FMT" "$target_short"
git --no-pager log --oneline "${SHA}..HEAD"
echo

confirm "$(printf "$MSG_RESET_SOFT_CONFIRM_FMT" "$target_short")"
git reset --soft "$SHA"
echo
echo "$MSG_RESET_SOFT_DONE"
