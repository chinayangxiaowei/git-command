#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "stash-pop（应用最近的 stash 到工作区）" \
  "作用: 把 stash@{0} 的改动应用回工作区，pop 成功则 stash 自动 drop" \
  "场景: 之前用 stash-push 收起了改动，现在想拿回来继续" \
  "注意: 冲突时 stash 不会自动 drop；手动解决冲突后再 git stash drop"

if ! git rev-parse --verify --quiet stash@{0} >/dev/null 2>&1; then
  echo "当前没有 stash 可 pop。" >&2
  exit 1
fi

echo "最近的 stash 列表："
git --no-pager stash list | head -5
echo
echo "stash@{0} 内容预览："
git --no-pager stash show --stat stash@{0}
echo

confirm "把 stash@{0} pop 到当前工作区？"

if ! git stash pop; then
  echo
  echo "pop 出现冲突——stash 还在（不会自动 drop）。" >&2
  echo "解决冲突 + git add 后，运行  git stash drop  扔掉这条 stash。" >&2
  exit 1
fi
