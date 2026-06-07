#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"
export GIT_COMMAND_NO_PAUSE=1   # feedback is outside the terminal (clipboard/editor)

show_intro "$MSG_COPY_BRANCH_TITLE" \
  "$MSG_COPY_BRANCH_PURPOSE" \
  "$MSG_COPY_BRANCH_WHEN" \
  "$MSG_COPY_BRANCH_NOTE"

print_header "$SHA"

branches=()
while IFS= read -r line; do
  [ -n "$line" ] && branches+=("$line")
done < <(git branch --points-at "$SHA" --format='%(refname:short)')

if [ "${#branches[@]}" -eq 0 ]; then
  echo "$MSG_COPY_BRANCH_NONE"
  exit 0
fi

if [ "${#branches[@]}" -eq 1 ]; then
  name="${branches[0]}"
else
  echo "$MSG_COPY_BRANCH_LIST_HEADER"
  i=1
  for b in "${branches[@]}"; do
    echo "  $i. $b"
    i=$((i+1))
  done
  echo
  read -erp "$MSG_COPY_BRANCH_SELECT_PROMPT" name
  name="${name// /}"
  if [ -z "$name" ]; then
    echo "$MSG_COPY_BRANCH_NO_INPUT"
    exit 130
  fi
  if [[ "$name" =~ ^[0-9]+$ ]] && [ "$name" -ge 1 ] && [ "$name" -le "${#branches[@]}" ]; then
    name="${branches[$((name-1))]}"
  fi
fi

found=no
for b in "${branches[@]}"; do
  [ "$b" = "$name" ] && found=yes && break
done
if [ "$found" = no ]; then
  printf "$MSG_COPY_BRANCH_NOT_IN_LIST_FMT" "$name" >&2
  exit 1
fi

if copy_to_clipboard "$name"; then
  printf "$MSG_COPY_BRANCH_DONE_FMT" "$name"
else
  echo "$MSG_COPY_BRANCH_NO_CLIPBOARD" >&2
  echo "  $name"
  exit 1
fi
