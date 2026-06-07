#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "reset-soft（软重置到此 commit · 改动保留到暂存区）" \
  "作用: HEAD 移到此 commit；中间 commits 的改动落到暂存区，不丢" \
  "场景: 想重新组织最后 N 条 commit（重新分块 / 改 message / 合并）" \
  "之后: git status 看暂存区，重新 commit 一份新的历史"

print_header "$SHA"

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  echo "$SHA 不在 HEAD 祖先链上，soft reset 没有意义。" >&2
  exit 1
fi

if [[ "$(git rev-parse "$SHA")" == "$(git rev-parse HEAD)" ]]; then
  echo "$SHA 就是 HEAD，无需 reset。" >&2
  exit 1
fi

current="$(git rev-parse --abbrev-ref HEAD)"
echo "当前分支：$current"
echo
echo "将丢弃以下 commit（其改动落到暂存区，HEAD → $(git rev-parse --short "$SHA")）："
git --no-pager log --oneline "${SHA}..HEAD"
echo

confirm "soft reset 到 $(git rev-parse --short "$SHA")？"
git reset --soft "$SHA"
echo
echo "完成。改动已在暂存区，可 git status 查看，git commit 重新提交。"
