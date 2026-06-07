#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_COPY_MSG_TITLE" \
  "$MSG_COPY_MSG_PURPOSE" \
  "$MSG_COPY_MSG_WHEN" \
  "$MSG_COPY_MSG_NOTE"

print_header "$SHA"

read -erp "$MSG_COPY_MSG_KIND_PROMPT" kind
kind="${kind:-s}"

case "$kind" in
  s|S|subject) msg=$(git log -1 --format='%s' "$SHA") ;;
  f|F|full)    msg=$(git log -1 --format='%B' "$SHA") ;;
  *) printf "$MSG_COPY_MSG_KIND_INVALID_FMT" "$kind" >&2; exit 1 ;;
esac

if copy_to_clipboard "$msg"; then
  preview=$(echo "$msg" | head -1)
  printf "$MSG_COPY_MSG_DONE_FMT" "$preview"
else
  echo "$MSG_COPY_MSG_NO_CLIPBOARD" >&2
  echo "$msg"
  exit 1
fi
