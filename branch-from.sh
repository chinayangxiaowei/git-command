#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "branch-from（从此 commit 创建新分支）" \
  "作用: 在此 commit 处创建新分支并切换过去" \
  "场景: 想从老 commit 起一条新支线 / 给特定状态保留命名引用" \
  "区别: 临时试错请用 try-branch（自动 try/前缀 + 清理提示）"

print_header "$SHA"

read -rp "新分支名（基于此提交）：" name
name="${name// /}"
if [[ -z "$name" ]]; then
  echo "未输入分支名，已取消。"
  exit 130
fi

git switch -c "$name" "$SHA"
