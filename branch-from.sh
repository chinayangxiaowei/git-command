#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_BRANCH_FROM_TITLE" \
  "$MSG_BRANCH_FROM_PURPOSE" \
  "$MSG_BRANCH_FROM_WHEN" \
  "$MSG_BRANCH_FROM_CONTRAST"

print_header "$SHA"

read -rp "$MSG_BRANCH_FROM_NAME_PROMPT" name
name="${name// /}"
if [[ -z "$name" ]]; then
  echo "$MSG_BRANCH_FROM_NO_NAME"
  exit 130
fi

git switch -c "$name" "$SHA"
