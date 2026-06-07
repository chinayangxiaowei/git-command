#!/usr/bin/env bash
# worktree-remove.sh — remove a worktree under a given purpose
# Usage: bash worktree-remove.sh <purpose>
#   <purpose> ∈ {review, try, fix, feat, hot}

set -euo pipefail
purpose="${1:?usage: $0 <purpose>}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/lib.sh"

case "$purpose" in
  review|try|fix|feat|hot) ;;
  *) echo "invalid purpose: $purpose (need: review/try/fix/feat/hot)" >&2; exit 1 ;;
esac

require_bare_layout

show_intro "$(printf "$MSG_WT_RM_TITLE_FMT" "$purpose")" \
  "$(printf "$MSG_WT_RM_PURPOSE_FMT" "$purpose")" \
  "$(printf "$MSG_WT_RM_USAGE_FMT" "$purpose")"

container=$(cd "$(git rev-parse --git-common-dir)/.." && pwd)

# collect worktrees under container/<purpose>/* (bash 3.2 — no mapfile)
items=()
while IFS= read -r line; do
  abs=$(echo "$line" | awk '{print $1}')
  case "$abs" in
    "$container/$purpose/"*)
      rel="${abs#$container/}"
      items+=("$rel")
      ;;
  esac
done < <(git worktree list)

if [ "${#items[@]}" -eq 0 ]; then
  printf "$MSG_WT_RM_EMPTY_FMT" "$purpose"
  exit 0
fi

printf "$MSG_WT_RM_LIST_HEADER_FMT" "$purpose"
for it in "${items[@]}"; do
  echo "  $it"
done
echo

read -erp "$MSG_WT_RM_NAME_PROMPT" name
name="${name## }"; name="${name%% }"
name="${name#  }"; name="${name#  }"
if [ -z "$name" ]; then
  echo "$MSG_WT_RM_NO_INPUT"
  exit 130
fi

found=no
for it in "${items[@]}"; do
  [ "$it" = "$name" ] && found=yes && break
done
if [ "$found" = no ]; then
  printf "$MSG_WT_RM_NOT_IN_LIST_FMT" "$name" "$purpose" >&2
  exit 1
fi

abs_path="$container/$name"
branch="$name"

printf "$MSG_WT_RM_REMOVING_FMT" "$abs_path"
git worktree remove "$abs_path"
echo "$MSG_WT_RM_DONE"

if [ "$purpose" = "review" ]; then
  echo "$MSG_WT_RM_REVIEW_NO_BRANCH"
  exit 0
fi

if git show-ref --verify --quiet "refs/heads/$branch"; then
  prompt=$(printf "$MSG_WT_RM_ALSO_DEL_BRANCH_FMT" "$branch")
  read -erp "$prompt" del
  if [[ "$del" =~ ^[yY] ]]; then
    git branch -D "$branch"
    echo "$MSG_WT_RM_BRANCH_DONE"
  fi
else
  printf "$MSG_WT_RM_BRANCH_ABSENT_FMT" "$branch"
fi
