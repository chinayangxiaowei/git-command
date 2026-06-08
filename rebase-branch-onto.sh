#!/usr/bin/env bash
# rebase-branch-onto.sh — rebase branch A onto branch B (CLion "rebase A onto B" equivalent)
# Commit-independent; SHA arg is ignored.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_RBO_TITLE" \
  "$MSG_RBO_PURPOSE" \
  "$MSG_RBO_WHEN" \
  "$MSG_RBO_NOTE"

require_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_RBO_DIRTY_TREE" >&2
  exit 1
fi

current="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$current" == "HEAD" ]]; then
  current="(detached)"
fi

echo "$MSG_RBO_LOCAL_BRANCHES"
git --no-pager branch | sed 's/^/  /'
echo

prompt=$(printf "$MSG_RBO_A_PROMPT_FMT" "$current")
read -erp "$prompt" branch_a
branch_a="${branch_a// /}"
branch_a="${branch_a:-$current}"

if [[ "$branch_a" == "(detached)" ]]; then
  echo "$MSG_RBO_DETACHED_ERR" >&2
  exit 1
fi

if ! git show-ref --verify --quiet "refs/heads/$branch_a"; then
  printf "$MSG_RBO_NO_LOCAL_FMT" "$branch_a" >&2
  exit 1
fi

read -erp "$MSG_RBO_B_PROMPT" branch_b
branch_b="${branch_b// /}"
if [[ -z "$branch_b" ]]; then
  echo "$MSG_RBO_NO_INPUT"
  exit_ok
fi

if ! git rev-parse --verify --quiet "$branch_b" >/dev/null 2>&1; then
  printf "$MSG_RBO_INVALID_REF_FMT" "$branch_b" >&2
  exit 1
fi

if [[ "$(git rev-parse "$branch_a")" == "$(git rev-parse "$branch_b")" ]]; then
  echo "$MSG_RBO_SAME" >&2
  exit 1
fi

echo
echo "$MSG_RBO_PREVIEW"
echo "A: $branch_a → $(git rev-parse --short "$branch_a")  $(git log -1 --format='%s' "$branch_a")"
echo "B: $branch_b → $(git rev-parse --short "$branch_b")  $(git log -1 --format='%s' "$branch_b")"
echo

a_only="$(git --no-pager log --oneline "${branch_b}..${branch_a}" 2>/dev/null)"
if [[ -z "$a_only" ]]; then
  echo "$MSG_RBO_NO_EXCLUSIVE"
  echo "$MSG_RBO_FF_OR_NOOP"
else
  count=$(echo "$a_only" | wc -l | tr -d ' ')
  printf "$MSG_RBO_REPLAY_FMT" "$count"
  echo "$a_only" | sed 's/^/  /' | head -15
fi
echo

confirm "$(printf "$MSG_RBO_CONFIRM_FMT" "$branch_a" "$branch_b")"

if [[ "$current" != "$branch_a" ]]; then
  printf "$MSG_RBO_SWITCHING_FMT" "$branch_a"
  git switch "$branch_a"
fi

run_or_abort rebase git rebase "$branch_b"

echo
echo "$MSG_RBO_DONE"
git --no-pager log --oneline -5
