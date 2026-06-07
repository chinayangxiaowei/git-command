#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "stash-push（收起当前改动到带名字的 stash）" \
  "作用: 把已跟踪文件的改动收进 stash，工作区清空；输入一个名字方便日后找" \
  "场景: 想切分支但有 WIP 改动 / 暂时收起做别的事 / 暂存好让 reset 干净" \
  "不带 -u: untracked 文件留在工作区（避免 Graph 多出 untracked snapshot 节点）"

if git diff --quiet && git diff --cached --quiet; then
  echo "工作区干净，没改动可 stash。" >&2
  exit 1
fi

echo "将 stash 以下改动："
git --no-pager status --short
echo

read -erp "起个名字（之后好认）：" name
if [[ -z "$name" ]]; then
  echo "未输入名字，已取消。"
  exit 130
fi

git stash push -m "$name"
echo
echo "完成。回看：git stash list 或菜单「Pop 最近的 stash」"
echo "提示：未跟踪文件（untracked）没被 stash 进来，仍在工作区。"
