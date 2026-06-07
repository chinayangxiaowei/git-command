#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_BRANCH_DELETE_TITLE" \
  "$MSG_BRANCH_DELETE_PURPOSE" \
  "$MSG_BRANCH_DELETE_WHEN" \
  "$MSG_BRANCH_DELETE_NOTE"

print_header "$SHA"

# 列出指向此 commit 的本地分支（bash 3.2 无 mapfile）
branches=()
while IFS= read -r line; do
  [ -n "$line" ] && branches+=("$line")
done < <(git branch --points-at "$SHA" --format='%(refname:short)')

if [ "${#branches[@]}" -eq 0 ]; then
  echo "$MSG_BRANCH_DELETE_NONE"
  exit 0
fi

current="$(git rev-parse --abbrev-ref HEAD)"

if [ "${#branches[@]}" -eq 1 ]; then
  name="${branches[0]}"
  printf "$MSG_BRANCH_DELETE_ONE_FMT" "$name"
else
  echo "$MSG_BRANCH_DELETE_LIST_HEADER"
  i=1
  for b in "${branches[@]}"; do
    echo "  $i. $b"
    i=$((i+1))
  done
  echo
  read -erp "$MSG_BRANCH_DELETE_SELECT_PROMPT" name
  name="${name// /}"
  if [ -z "$name" ]; then
    echo "$MSG_BRANCH_DELETE_NO_INPUT"
    exit 130
  fi
  # 编号 → 分支名
  if [[ "$name" =~ ^[0-9]+$ ]] && [ "$name" -ge 1 ] && [ "$name" -le "${#branches[@]}" ]; then
    name="${branches[$((name-1))]}"
  fi
fi

# 验证 name 在分支列表里
found=no
for b in "${branches[@]}"; do
  [ "$b" = "$name" ] && found=yes && break
done
if [ "$found" = no ]; then
  printf "$MSG_BRANCH_DELETE_NOT_IN_LIST_FMT" "$name" >&2
  exit 1
fi

# 拒绝删当前所在分支
if [ "$name" = "$current" ]; then
  printf "$MSG_BRANCH_DELETE_IS_CURRENT_FMT" "$name" >&2
  echo "$MSG_BRANCH_DELETE_CURRENT_HINT" >&2
  exit 1
fi

echo
confirm "$(printf "$MSG_BRANCH_DELETE_CONFIRM_FMT" "$name")"
git branch -D "$name"
echo "$MSG_BRANCH_DELETE_LOCAL_DONE"
echo

# 远端
remote="$(git remote | head -1)"
if [ -z "$remote" ]; then
  echo "$MSG_BRANCH_DELETE_NO_REMOTE"
elif ! git ls-remote --heads "$remote" "$name" 2>/dev/null | grep -q "refs/heads/$name"; then
  printf "$MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT\n" "$remote"
else
  prompt=$(printf "$MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT" "$remote")
  read -erp "$prompt" push
  if [[ "$push" =~ ^[yY] ]]; then
    git push "$remote" --delete "$name"
    echo "$MSG_BRANCH_DELETE_REMOTE_DONE"
  fi
fi
