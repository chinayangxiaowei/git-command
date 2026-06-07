#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "try-branch（从此 commit 起临时分支测试）" \
  "作用: 在此 commit 创建 try/<branch-slug>-<sha> 命名的分支，可立即切换过去" \
  "场景: 想试错而不污染当前分支；测某个老 commit 的状态" \
  "提示: 结尾打印「回原分支」+「删此分支」的命令，避免用完忘了清理"

print_header "$SHA"

current="$(git rev-parse --abbrev-ref HEAD)"
short="$(git rev-parse --short "$SHA")"

if [[ "$current" == "HEAD" ]]; then
  base_slug="detached"
  return_hint="git switch -  # 之前是 detached，用 reflog 查"
else
  base_slug="${current//\//-}"
  return_hint="git switch $current"
fi
default_name="try/${base_slug}-${short}"

echo "原分支：$current"
echo "起点：  $short"
echo

read -rp "新分支名（回车=${default_name}）：" name
name="${name// /}"
name="${name:-$default_name}"

if git show-ref --verify --quiet "refs/heads/$name"; then
  echo "分支已存在：$name" >&2
  exit 1
fi

read -rp "创建后立即切换过去？[Y/n] " sw
sw="${sw:-y}"

if [[ "$sw" =~ ^[yY] ]]; then
  git switch -c "$name" "$SHA"
else
  git branch "$name" "$SHA"
  echo "已创建 ${name}（未切换）"
fi

echo
echo "用完清理："
echo "  回原分支：    $return_hint"
echo "  删此临时分支：git branch -D $name"
