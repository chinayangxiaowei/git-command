#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "rebase-i（交互式 rebase 到此 commit 之前）" \
  "作用: 启动 git rebase -i SHA^，打开 \$EDITOR 让你手动编辑 todo" \
  "场景: 想手动重排/合并/编辑/drop 多条 commit；超出标准菜单覆盖的复杂操作" \
  "前提: 工作区必须干净；中途冲突自己处理或菜单兜底 abort"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

echo "将启动交互式 rebase，范围：${SHA}^..HEAD"
echo

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "工作区有未提交改动，请先提交或 stash。" >&2
  exit 1
fi

confirm "继续？"
git rebase -i --autosquash "${SHA}^"
