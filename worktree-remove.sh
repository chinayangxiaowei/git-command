#!/usr/bin/env bash
# worktree-remove.sh — 删除指定 purpose 下的某个 worktree
# 用法: bash worktree-remove.sh <purpose>
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

show_intro "worktree-remove [$purpose]" \
  "作用: 列出 [$purpose] 下的 worktree，由用户复制粘贴名字来删除" \
  "用法: 看下面列表，复制要删的那一行的名字（含 ${purpose}/ 前缀），粘贴到输入框"

container=$(cd "$(git rev-parse --git-common-dir)/.." && pwd)

# 收集 container/<purpose>/* 下的 worktree（bash 3.2 兼容，用 while read）
items=()
while IFS= read -r line; do
  # git worktree list 行格式: <abs_path> <sha> [<branch>] | (detached HEAD)
  abs=$(echo "$line" | awk '{print $1}')
  case "$abs" in
    "$container/$purpose/"*)
      rel="${abs#$container/}"
      items+=("$rel")
      ;;
  esac
done < <(git worktree list)

if [ "${#items[@]}" -eq 0 ]; then
  echo "[$purpose] 下没有 worktree 可删。"
  exit 0
fi

echo "[$purpose] 下的 worktree:"
for it in "${items[@]}"; do
  echo "  $it"
done
echo

read -erp "粘贴要删的 worktree 名字（完整复制上面某一行）: " name
name="${name## }"; name="${name%% }"  # trim 前后空格（粘贴常带空格）
name="${name#  }"; name="${name#  }"  # 列表前缀的两空格
if [ -z "$name" ]; then
  echo "未输入，已取消。"
  exit 130
fi

# 验证 name 在列表里
found=no
for it in "${items[@]}"; do
  [ "$it" = "$name" ] && found=yes && break
done
if [ "$found" = no ]; then
  echo "'$name' 不在 [$purpose] worktree 列表里。" >&2
  exit 1
fi

abs_path="$container/$name"
branch="$name"  # 对 try/fix/feat/hot, worktree 路径 == 分支名

echo "正在删除: $abs_path"
git worktree remove "$abs_path"
echo "✓ worktree 已删除。"

# review 是 detached，无分支
if [ "$purpose" = "review" ]; then
  echo "(review 是 detached，无分支需要清理)"
  exit 0
fi

# 其他类：分支可能也要删
if git show-ref --verify --quiet "refs/heads/$branch"; then
  read -erp "也删本地分支 '$branch'？[y/N] " del
  if [[ "$del" =~ ^[yY] ]]; then
    git branch -D "$branch"
    echo "✓ 本地分支已删除。"
  fi
else
  echo "(分支 '$branch' 不存在，可能 git worktree remove 已带走)"
fi
