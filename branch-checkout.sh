#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_BRANCH_CHECKOUT_TITLE" \
  "$MSG_BRANCH_CHECKOUT_PURPOSE" \
  "$MSG_BRANCH_CHECKOUT_WHEN" \
  "$MSG_BRANCH_CHECKOUT_NOTE"

print_header "$SHA"
require_clean_state

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_BRANCH_CHECKOUT_DIRTY_TREE" >&2
  exit 1
fi

branches=()
while IFS= read -r line; do
  [ -n "$line" ] && branches+=("$line")
done < <(git branch --points-at "$SHA" --format='%(refname:short)')

if [ "${#branches[@]}" -eq 0 ]; then
  echo "$MSG_BRANCH_CHECKOUT_NONE"
  exit_ok
fi

current="$(git rev-parse --abbrev-ref HEAD)"

if [ "${#branches[@]}" -eq 1 ]; then
  name="${branches[0]}"
  printf "$MSG_BRANCH_CHECKOUT_ONE_FMT" "$name"
else
  echo "$MSG_BRANCH_CHECKOUT_LIST_HEADER"
  i=1
  for b in "${branches[@]}"; do
    echo "  $i. $b"
    i=$((i+1))
  done
  echo
  read -erp "$MSG_BRANCH_CHECKOUT_SELECT_PROMPT" name
  name="${name// /}"
  if [ -z "$name" ]; then
    echo "$MSG_BRANCH_CHECKOUT_NO_INPUT"
    exit_ok
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
  printf "$MSG_BRANCH_CHECKOUT_NOT_IN_LIST_FMT" "$name" >&2
  exit 1
fi

if [ "$name" = "$current" ]; then
  printf "$MSG_BRANCH_CHECKOUT_ALREADY_FMT" "$name"
  exit_ok
fi

git switch "$name"
