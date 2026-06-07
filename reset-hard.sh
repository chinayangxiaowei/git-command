#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "reset-hard（硬重置到此 commit · destructive）" \
  "作用: HEAD 移到此 commit；丢弃中间 commits + 工作区所有改动" \
  "场景: 彻底回退到某状态，且确认不要保留任何中间改动" \
  "后果: 不可恢复（除非 30 天内 git reflog 还有；要输入 YES 全大写才执行）"

print_header "$SHA"

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  echo "$SHA 不在 HEAD 祖先链上，refuse。" >&2
  exit 1
fi

if [[ "$(git rev-parse "$SHA")" == "$(git rev-parse HEAD)" ]]; then
  echo "$SHA 就是 HEAD，无需 reset。" >&2
  exit 1
fi

current="$(git rev-parse --abbrev-ref HEAD)"
target_short="$(git rev-parse --short "$SHA")"

echo "当前分支：$current"
echo
echo "将丢弃以下 commit（不可恢复，除非走 reflog）："
git --no-pager log --oneline "${SHA}..HEAD"
echo
echo "工作区改动也会被丢弃："
git --no-pager status --short
echo

printf '%s' "输入 YES (大写) 确认硬重置到 ${target_short}："
read -r ans
if [[ "$ans" != "YES" ]]; then
  echo "未输入 YES，已取消。"
  exit 130
fi

echo
echo "提示：reflog 还能救回这些 commit，30 天内 git reflog 找 HEAD@{N}。"
git reset --hard "$SHA"
