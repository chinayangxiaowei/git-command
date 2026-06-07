#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "tag-delete（删除 tag）" \
  "作用: 删本地 tag，可选同时删远端 tag" \
  "场景: 错打 / release 重发 / 清理无用 tag" \
  "注意: 已 push 的远端 tag 删除会影响其他人；本地+远端分两步问"

print_header "$SHA"

# 列出此 commit 上的所有 tag（如果有）
echo "此 commit 上的 tag："
points_at="$(git tag --points-at "$SHA")"
if [[ -n "$points_at" ]]; then
  echo "$points_at" | sed 's/^/  /'
else
  echo "  (无)"
fi
echo

read -erp "要删的 tag 名字（也可以是其它 commit 上的 tag）：" name
name="${name// /}"
if [[ -z "$name" ]]; then
  echo "未输入，已取消。"
  exit 130
fi

if ! git rev-parse --verify --quiet "refs/tags/$name" >/dev/null 2>&1; then
  echo "tag 不存在：$name" >&2
  exit 1
fi

target_short="$(git rev-parse --short "$name")"
target_subj="$(git log -1 --format='%s' "$name" 2>/dev/null || echo '(annotated tag)')"
echo
echo "tag '$name' → $target_short  $target_subj"
echo

confirm "删除本地 tag '$name'？"
git tag -d "$name"
echo "本地 tag 已删除。"
echo

remote="$(git remote | head -1)"
if [[ -z "$remote" ]]; then
  echo "（没有 remote，跳过远端）"
elif ! git ls-remote --tags "$remote" "$name" 2>/dev/null | grep -q "refs/tags/$name"; then
  echo "（远端 [$remote] 上没有此 tag，跳过）"
else
  read -erp "也从远端 [$remote] 删除？[y/N] " push
  if [[ "$push" =~ ^[yY] ]]; then
    git push "$remote" --delete "$name"
    echo "远端 tag 已删除。"
  fi
fi

echo
echo "提示：Zed Git Graph 不监听 tag 变化，需手动刷新（cmd+shift+P → reload window 或下次 commit 时自动刷）。"
