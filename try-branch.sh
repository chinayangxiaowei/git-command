#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_TRY_BRANCH_TITLE" \
  "$MSG_TRY_BRANCH_PURPOSE" \
  "$MSG_TRY_BRANCH_WHEN" \
  "$MSG_TRY_BRANCH_HINT"

print_header "$SHA"

current="$(git rev-parse --abbrev-ref HEAD)"
short="$(git rev-parse --short "$SHA")"

if [[ "$current" == "HEAD" ]]; then
  base_slug="detached"
  return_hint="$MSG_TRY_BRANCH_DETACHED_HINT"
else
  base_slug="${current//\//-}"
  return_hint="git switch $current"
fi
default_name="try/${base_slug}-${short}"

printf "$MSG_TRY_BRANCH_FROM_FMT" "$current" "$short"
echo

prompt=$(printf "$MSG_TRY_BRANCH_NAME_PROMPT_FMT" "$default_name")
read -rp "$prompt" name
name="${name// /}"
name="${name:-$default_name}"

if git show-ref --verify --quiet "refs/heads/$name"; then
  printf "$MSG_TRY_BRANCH_EXISTS_FMT" "$name" >&2
  exit 1
fi

read -rp "$MSG_TRY_BRANCH_SWITCH_PROMPT" sw
sw="${sw:-y}"

if [[ "$sw" =~ ^[yY] ]]; then
  git switch -c "$name" "$SHA"
else
  git branch "$name" "$SHA"
  printf "$MSG_TRY_BRANCH_CREATED_FMT" "$name"
fi

echo
echo "$MSG_TRY_BRANCH_CLEANUP_HEADER"
printf "$MSG_TRY_BRANCH_CLEANUP_RETURN_FMT" "$return_hint"
printf "$MSG_TRY_BRANCH_CLEANUP_DELETE_FMT" "$name"
