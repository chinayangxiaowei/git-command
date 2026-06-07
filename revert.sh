#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "revert（生成反向 commit 撤销此 commit）" \
  "作用: 不改历史，在 HEAD 之上加一条新 commit，内容与此 commit 相反" \
  "场景: 已 push 的 commit 想撤销（不能用 reset 改公共历史）" \
  "对比: reset 是改历史，revert 是加新历史；冲突时自动 abort"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "工作区有未提交改动，请先提交或 stash。" >&2
  exit 1
fi

confirm "在 HEAD 之上生成反向提交以撤销 $(git rev-parse --short "$SHA")？"
run_or_abort revert git revert --no-edit "$SHA"
