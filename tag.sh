#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "tag（给此 commit 打 tag）" \
  "作用: 创建轻量或 annotated tag 指向此 commit；可选立即 push 到远端" \
  "场景: release 节点 / 重要里程碑 / 给某 commit 一个稳定的命名引用" \
  "区别: annotated 带 message+作者+时间（推荐 release）；lightweight 只是个 ref"

print_header "$SHA"

read -erp "tag 名字（例：v1.0.0 / release-2024-01）：" name
name="${name// /}"
if [[ -z "$name" ]]; then
  echo "未输入，已取消。"
  exit 130
fi

if git rev-parse --verify --quiet "refs/tags/$name" >/dev/null; then
  echo "tag 已存在：$name" >&2
  exit 1
fi

read -erp "annotated（带 message）还是 lightweight？[a]/l（默认 a）：" kind
kind="${kind:-a}"

if [[ "$kind" =~ ^[aA] ]]; then
  read -erp "tag message（回车 = 用 tag 名字）：" msg
  msg="${msg:-$name}"
  git tag -a "$name" -m "$msg" "$SHA"
else
  git tag "$name" "$SHA"
fi

echo "已创建 tag：$name → $(git rev-parse --short "$SHA")"
echo

remote="$(git remote | head -1)"
if [[ -n "$remote" ]]; then
  read -erp "推送到远端 [$remote]？[y/N] " push
  if [[ "$push" =~ ^[yY] ]]; then
    git push "$remote" "$name"
  fi
else
  echo "（没有 remote，跳过 push）"
fi

echo
echo "提示：Zed Git Graph 不监听 tag 变化，需手动刷新（cmd+shift+P → reload window 或下次 commit 时自动刷）。"
