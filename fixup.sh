#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_FIXUP_TITLE" \
  "$MSG_FIXUP_PURPOSE" \
  "$MSG_FIXUP_WHEN" \
  "$MSG_FIXUP_PREREQ"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  printf "$MSG_FIXUP_NOT_ANCESTOR_FMT" "$SHA" >&2
  exit 1
fi

has_staged=0
has_unstaged=0
git diff --cached --quiet || has_staged=1
git diff --quiet || has_unstaged=1

if (( ! has_staged && ! has_unstaged )); then
  echo "$MSG_FIXUP_NO_CHANGES" >&2
  echo "$MSG_FIXUP_WORKFLOW_HINT" >&2
  exit 1
fi

echo "$MSG_FIXUP_WILL_FOLD"
git --no-pager status --short | sed 's/^/  /'
echo

if (( has_unstaged )); then
  if (( has_staged )); then
    read -erp "$MSG_FIXUP_ASK_INCLUDE_UNSTAGED" ans
  else
    read -erp "$MSG_FIXUP_ASK_ADD_ALL" ans
    ans="${ans:-y}"
  fi
  if [[ "$ans" =~ ^[yY] ]]; then
    git add -A
  elif (( ! has_staged )); then
    echo "$MSG_FIXUP_EMPTY_INDEX"
    exit 0
  fi
fi

target_msg="$(git log -1 --format='%s' "$SHA")"
target_short="$(git rev-parse --short "$SHA")"

echo
printf "$MSG_FIXUP_TARGET_FMT" "$target_short" "$target_msg"
read -erp "$MSG_FIXUP_CONFIRM" ans
if [[ "$ans" =~ ^[nN] ]]; then
  echo "$MSG_FIXUP_CANCELLED"
  exit 0
fi

git commit --fixup="$SHA" --quiet
echo "$MSG_FIXUP_CREATED"

export GIT_SEQUENCE_EDITOR=true
run_or_abort rebase git rebase -i --autosquash "${SHA}^"

printf "$MSG_FIXUP_DONE_FMT" "$target_short"
git --no-pager log --oneline -3
