#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "fixup（把工作区改动并入此 commit）" \
  "作用: 创建 fixup commit + 自动 autosquash，把工作区改动合进此 commit" \
  "场景: 改完文件想合进某老 commit（最常用）；不想产生新 commit 污染历史" \
  "前提: 工作区/暂存区必须有改动；冲突时自动 abort"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  echo "$SHA 不在当前分支祖先链上。" >&2
  exit 1
fi

# 工作区状态
has_staged=0
has_unstaged=0
git diff --cached --quiet || has_staged=1
git diff --quiet || has_unstaged=1

if (( ! has_staged && ! has_unstaged )); then
  echo "工作区干净，没改动可 fixup。" >&2
  echo "工作流：先改文件 → 点此菜单 → 选目标 commit → 自动 fixup + autosquash。" >&2
  exit 1
fi

# 展示要并入什么
echo "将并入此 commit 的改动："
git --no-pager status --short | sed 's/^/  /'
echo

# 如果有 unstaged，问要不要也 add
if (( has_unstaged )); then
  if (( has_staged )); then
    read -erp "暂存区已有内容；连未 add 的也一起 fixup 吗？[y/N] " ans
  else
    read -erp "没东西在暂存区，全部 git add 后再 fixup？[Y/n] " ans
    ans="${ans:-y}"
  fi
  if [[ "$ans" =~ ^[yY] ]]; then
    git add -A
  elif (( ! has_staged )); then
    echo "暂存区为空，没东西 fixup，已取消。"
    exit 130
  fi
fi

target_msg="$(git log -1 --format='%s' "$SHA")"
target_short="$(git rev-parse --short "$SHA")"

echo
echo "目标：$target_short  \"$target_msg\""
read -erp "确认 fixup + autosquash？[Y/n] " ans
if [[ "$ans" =~ ^[nN] ]]; then
  echo "已取消，暂存区状态保持不变。"
  exit 130
fi

# 创建 fixup commit
git commit --fixup="$SHA" --quiet
echo "  + fixup commit 已创建"

# 自动 autosquash：用 true 作 sequence editor，接受 autosquash 生成的 todo
export GIT_SEQUENCE_EDITOR=true
run_or_abort rebase git rebase -i --autosquash "${SHA}^"

echo "完成。改动已合入原 $target_short（autosquash 后 SHA 已更新）。"
git --no-pager log --oneline -3
