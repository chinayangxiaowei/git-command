#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_TAG_TITLE" \
  "$MSG_TAG_PURPOSE" \
  "$MSG_TAG_WHEN" \
  "$MSG_TAG_CONTRAST"

print_header "$SHA"

read -erp "$MSG_TAG_NAME_PROMPT" name
name="${name// /}"
if [[ -z "$name" ]]; then
  echo "$MSG_TAG_NO_INPUT"
  exit 0
fi

if git rev-parse --verify --quiet "refs/tags/$name" >/dev/null; then
  printf "$MSG_TAG_EXISTS_FMT" "$name" >&2
  exit 1
fi

read -erp "$MSG_TAG_KIND_PROMPT" kind
kind="${kind:-a}"

if [[ "$kind" =~ ^[aA] ]]; then
  read -erp "$MSG_TAG_MSG_PROMPT" msg
  msg="${msg:-$name}"
  git tag -a "$name" -m "$msg" "$SHA"
else
  git tag "$name" "$SHA"
fi

printf "$MSG_TAG_CREATED_FMT" "$name" "$(git rev-parse --short "$SHA")"
echo

remote="$(git remote | head -1)"
if [[ -n "$remote" ]]; then
  prompt=$(printf "$MSG_TAG_PUSH_PROMPT_FMT" "$remote")
  read -erp "$prompt" push
  if [[ "$push" =~ ^[yY] ]]; then
    git push "$remote" "$name"
  fi
else
  echo "$MSG_TAG_NO_REMOTE"
fi

echo
echo "$MSG_TAG_REFRESH_HINT"
