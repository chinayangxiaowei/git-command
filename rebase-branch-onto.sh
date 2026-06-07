#!/usr/bin/env bash
# rebase-branch-onto.sh — 把分支 A 变基到分支 B 上（CLion "rebase A onto B" 等效）
# 跟 commit 无关，SHA 参数忽略。
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "rebase-branch-onto（把分支 A 变基到分支 B 上）" \
  "作用: git switch A && git rebase B；A 的独有 commit 会重放到 B 顶部" \
  "场景: A 是 feature 分支、B 是 main/develop；想把 A 跟上 B 的最新进度" \
  "注意: A 上的 commit 会被重写 (新 SHA)；冲突时自动 abort 回滚"

ensure_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "工作区有未提交改动，请先 commit 或 stash。" >&2
  exit 1
fi

current="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$current" == "HEAD" ]]; then
  current="(detached)"
fi

echo "本地分支："
git --no-pager branch | sed 's/^/  /'
echo

read -erp "分支 A（要被变基的分支，回车=当前 ${current}）：" branch_a
branch_a="${branch_a// /}"
branch_a="${branch_a:-$current}"

if [[ "$branch_a" == "(detached)" ]]; then
  echo "当前是 detached HEAD，必须明确指定分支 A。" >&2
  exit 1
fi

if ! git show-ref --verify --quiet "refs/heads/$branch_a"; then
  echo "本地不存在分支：$branch_a" >&2
  exit 1
fi

read -erp "分支 B（变基的目标基准；可以是本地分支 / 远端分支 / tag）：" branch_b
branch_b="${branch_b// /}"
if [[ -z "$branch_b" ]]; then
  echo "未输入，已取消。"
  exit 130
fi

if ! git rev-parse --verify --quiet "$branch_b" >/dev/null 2>&1; then
  echo "无效的目标 ref：$branch_b" >&2
  exit 1
fi

if [[ "$(git rev-parse "$branch_a")" == "$(git rev-parse "$branch_b")" ]]; then
  echo "A 和 B 指向同一 commit，无需变基。" >&2
  exit 1
fi

# 预览
echo
echo "─── 预览 ───"
echo "分支 A: $branch_a → $(git rev-parse --short "$branch_a")  $(git log -1 --format='%s' "$branch_a")"
echo "分支 B: $branch_b → $(git rev-parse --short "$branch_b")  $(git log -1 --format='%s' "$branch_b")"
echo

# A 独有的 commit 预览
a_only="$(git --no-pager log --oneline "${branch_b}..${branch_a}" 2>/dev/null)"
if [[ -z "$a_only" ]]; then
  echo "A 没有 B 之外的 commit（A 是 B 的祖先或同一点）。"
  echo "rebase 会变成 fast-forward 或 no-op。"
else
  count=$(echo "$a_only" | wc -l | tr -d ' ')
  echo "A 上将被重放的 commit ($count 条)："
  echo "$a_only" | sed 's/^/  /' | head -15
fi
echo

confirm "继续：git switch ${branch_a} && git rebase ${branch_b}？"

# 切换到 A（如果不在）
if [[ "$current" != "$branch_a" ]]; then
  echo "切换到 $branch_a..."
  git switch "$branch_a"
fi

# 变基
run_or_abort rebase git rebase "$branch_b"

echo
echo "完成。"
git --no-pager log --oneline -5
