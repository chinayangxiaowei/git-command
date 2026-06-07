#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_TAG_DELETE_TITLE" \
  "$MSG_TAG_DELETE_PURPOSE" \
  "$MSG_TAG_DELETE_WHEN" \
  "$MSG_TAG_DELETE_NOTE"

print_header "$SHA"

echo "$MSG_TAG_DELETE_AT_HEADER"
points_at="$(git tag --points-at "$SHA")"
if [[ -n "$points_at" ]]; then
  echo "$points_at" | sed 's/^/  /'
else
  echo "$MSG_TAG_DELETE_NONE"
fi
echo

read -erp "$MSG_TAG_DELETE_NAME_PROMPT" name
name="${name// /}"
if [[ -z "$name" ]]; then
  echo "$MSG_TAG_DELETE_NO_INPUT"
  exit 0
fi

if ! git rev-parse --verify --quiet "refs/tags/$name" >/dev/null 2>&1; then
  printf "$MSG_TAG_DELETE_NOT_EXIST_FMT" "$name" >&2
  exit 1
fi

target_short="$(git rev-parse --short "$name")"
target_subj="$(git log -1 --format='%s' "$name" 2>/dev/null || echo "$MSG_TAG_DELETE_ANNOTATED")"
echo
printf "$MSG_TAG_DELETE_PREVIEW_FMT" "$name" "$target_short" "$target_subj"
echo

confirm "$(printf "$MSG_TAG_DELETE_CONFIRM_FMT" "$name")"
git tag -d "$name"
echo "$MSG_TAG_DELETE_LOCAL_DONE"
echo

remote="$(git remote | head -1)"
if [[ -z "$remote" ]]; then
  echo "$MSG_TAG_DELETE_NO_REMOTE"
elif ! git ls-remote --tags "$remote" "$name" 2>/dev/null | grep -q "refs/tags/$name"; then
  printf "$MSG_TAG_DELETE_REMOTE_ABSENT_FMT" "$remote"
else
  prompt=$(printf "$MSG_TAG_DELETE_REMOTE_PROMPT_FMT" "$remote")
  read -erp "$prompt" push
  if [[ "$push" =~ ^[yY] ]]; then
    git push "$remote" --delete "$name"
    echo "$MSG_TAG_DELETE_REMOTE_DONE"
  fi
fi

echo
echo "$MSG_TAG_REFRESH_HINT"
