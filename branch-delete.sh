#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "branch-delete [删除指向此 commit 的本地分支]" \
  "作用: 删本地分支（可选同时删远端）" \
  "场景: 清理已合并 / 试错完的分支；批量删 try/* feat/* 等" \
  "注意: 用 git branch -D 强删，不检查是否 merged"

print_header "$SHA"

# 列出指向此 commit 的本地分支（bash 3.2 无 mapfile，用 while read）
branches=()
while IFS= read -r line; do
  [ -n "$line" ] && branches+=("$line")
done < <(git branch --points-at "$SHA" --format='%(refname:short)')

if [ "${#branches[@]}" -eq 0 ]; then
  echo "此 commit 上没有本地分支可删。"
  exit 0
fi

current="$(git rev-parse --abbrev-ref HEAD)"

if [ "${#branches[@]}" -eq 1 ]; then
  name="${branches[0]}"
  echo "此 commit 上唯一分支: $name"
else
  echo "此 commit 上的本地分支:"
  i=1
  for b in "${branches[@]}"; do
    echo "  $i. $b"
    i=$((i+1))
  done
  echo
  read -erp "选哪个？(分支名或编号): " name
  name="${name// /}"
  if [ -z "$name" ]; then
    echo "未输入，已取消。"
    exit 130
  fi
  # 编号转换成分支名
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
  echo "分支 '$name' 不在指向此 commit 的分支列表里。" >&2
  exit 1
fi

# 拒绝删当前所在分支
if [ "$name" = "$current" ]; then
  echo "无法删当前所在分支 '$name'。" >&2
  echo "先切到别的分支: git switch <other-branch>" >&2
  exit 1
fi

echo
confirm "删除本地分支 '$name'？"
git branch -D "$name"
echo "本地分支已删除。"
echo

# 远端
remote="$(git remote | head -1)"
if [ -z "$remote" ]; then
  echo "(没有 remote，跳过远端)"
elif ! git ls-remote --heads "$remote" "$name" 2>/dev/null | grep -q "refs/heads/$name"; then
  echo "(远端 [$remote] 上没有此分支，跳过)"
else
  read -erp "也从远端 [$remote] 删除？[y/N] " push
  if [[ "$push" =~ ^[yY] ]]; then
    git push "$remote" --delete "$name"
    echo "远端分支已删除。"
  fi
fi
