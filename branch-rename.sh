#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_BRANCH_RENAME_TITLE" \
  "$MSG_BRANCH_RENAME_PURPOSE" \
  "$MSG_BRANCH_RENAME_WHEN" \
  "$MSG_BRANCH_RENAME_NOTE"

print_header "$SHA"

branches=()
while IFS= read -r line; do
  [ -n "$line" ] && branches+=("$line")
done < <(git branch --points-at "$SHA" --format='%(refname:short)')

if [ "${#branches[@]}" -eq 0 ]; then
  echo "$MSG_BRANCH_RENAME_NONE"
  exit 0
fi

if [ "${#branches[@]}" -eq 1 ]; then
  old_name="${branches[0]}"
  printf "$MSG_BRANCH_RENAME_ONE_FMT" "$old_name"
else
  echo "$MSG_BRANCH_RENAME_LIST_HEADER"
  i=1
  for b in "${branches[@]}"; do
    echo "  $i. $b"
    i=$((i+1))
  done
  echo
  read -erp "$MSG_BRANCH_RENAME_SELECT_PROMPT" old_name
  old_name="${old_name// /}"
  if [ -z "$old_name" ]; then
    echo "$MSG_BRANCH_RENAME_NO_INPUT"
    exit 130
  fi
  if [[ "$old_name" =~ ^[0-9]+$ ]] && [ "$old_name" -ge 1 ] && [ "$old_name" -le "${#branches[@]}" ]; then
    old_name="${branches[$((old_name-1))]}"
  fi
fi

found=no
for b in "${branches[@]}"; do
  [ "$b" = "$old_name" ] && found=yes && break
done
if [ "$found" = no ]; then
  printf "$MSG_BRANCH_RENAME_NOT_IN_LIST_FMT" "$old_name" >&2
  exit 1
fi

read -erp "$MSG_BRANCH_RENAME_NEW_NAME_PROMPT" new_name
new_name="${new_name// /}"
if [ -z "$new_name" ]; then
  echo "$MSG_BRANCH_RENAME_NO_INPUT"
  exit 130
fi

if ! git check-ref-format --branch "$new_name" >/dev/null 2>&1; then
  printf "$MSG_BRANCH_RENAME_INVALID_NAME_FMT" "$new_name" >&2
  exit 1
fi

if git show-ref --verify --quiet "refs/heads/$new_name"; then
  printf "$MSG_BRANCH_RENAME_EXISTS_FMT" "$new_name" >&2
  exit 1
fi

git branch -m "$old_name" "$new_name"
printf "$MSG_BRANCH_RENAME_DONE_FMT" "$old_name" "$new_name"

remote="$(git remote | head -1)"
if [ -n "$remote" ] && git ls-remote --heads "$remote" "$old_name" 2>/dev/null | grep -q "refs/heads/$old_name"; then
  prompt=$(printf "$MSG_BRANCH_RENAME_REMOTE_PROMPT_FMT" "$remote")
  read -erp "$prompt" pushit
  if [[ "$pushit" =~ ^[yY] ]]; then
    git push "$remote" "$new_name"
    git push "$remote" --delete "$old_name"
    echo "$MSG_BRANCH_RENAME_REMOTE_DONE"
  fi
fi
