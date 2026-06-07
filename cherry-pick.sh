#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "cherry-pick（复制此 commit 到当前分支顶部）" \
  "作用: 把此 commit 的改动复制到当前分支顶上，形成新 commit (新 SHA)" \
  "场景: 跨分支搬 hotfix / 从同事分支偷一条 / 从 reflog 救回 commit" \
  "注意: 源 commit 不被删除；同分支无意义；冲突时自动 abort"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

current="$(git rev-parse --abbrev-ref HEAD)"
echo "当前分支：$current"
echo

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "工作区有未提交改动，请先提交或 stash。" >&2
  exit 1
fi

confirm "把 $(git rev-parse --short "$SHA") cherry-pick 到 ${current}？"
run_or_abort cherry-pick git cherry-pick "$SHA"
