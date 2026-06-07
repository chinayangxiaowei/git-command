#!/usr/bin/env bash
# 集成测试 for worktree-remove.sh
# 跑法: bash test/test-worktree-remove.sh
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$DIR/worktree-remove.sh"

pass=0
fail=0
mark_pass() { pass=$((pass+1)); echo "  ✓ $1"; }
mark_fail() { fail=$((fail+1)); echo "  ✗ $1"; }

setup_sandbox() {
  local sb
  sb=$(mktemp -d)
  cd "$sb"
  git init --bare .bare >/dev/null
  git --git-dir=.bare symbolic-ref HEAD refs/heads/main
  local tree commit
  tree=$(git --git-dir=.bare hash-object -t tree --stdin < /dev/null)
  commit=$(git --git-dir=.bare commit-tree -m "init" "$tree")
  git --git-dir=.bare update-ref refs/heads/main "$commit"
  echo "gitdir: ./.bare" > .git
  git worktree add main main >/dev/null 2>&1
  cd main
  git config user.email "t@t"
  git config user.name "t"
  echo a > a.txt && git add a.txt && git commit -qm "a"
  echo b > b.txt && git add b.txt && git commit -qm "b"
  printf '%s\n' "$sb"
}

teardown() { cd /; rm -rf "$1"; }

echo "── worktree-remove 集成测试 ──"
SB=$(setup_sandbox)
echo "  sandbox: $SB"
cd "$SB/main"

SHA=$(git rev-parse HEAD)
short=$(git rev-parse --short HEAD)

# Case 1: review 类 0 worktree → exit 0
out=$(echo "" | bash "$SCRIPT" review 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && echo "$out" | grep -q "没有 worktree 可删"; then
  mark_pass "[review] 0 worktree 正常退出"
else
  mark_fail "[review] 应正常退出 ec=$ec"
fi

# Case 2: review 类，建一个，粘贴名字删除
git worktree add --detach "$SB/review/$short" "$SHA" >/dev/null 2>&1
out=$(printf 'review/%s\n' "$short" | bash "$SCRIPT" review 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ ! -d "$SB/review/$short" ]; then
  mark_pass "[review] 删除成功"
else
  mark_fail "[review] 删除失败 ec=$ec exists=$([ -d "$SB/review/$short" ] && echo yes || echo no)"
fi

# Case 3: try 类，建一个，删 worktree 时回答不删分支
git worktree add -b "try/main-$short" "$SB/try/main-$short" "$SHA" >/dev/null 2>&1
# 输入: try/main-<short>\n + n\n (不删分支)
out=$(printf 'try/main-%s\nn\n' "$short" | bash "$SCRIPT" try 2>&1) && ec=0 || ec=$?
branch_exists=$(git show-ref --verify --quiet "refs/heads/try/main-$short" && echo yes || echo no)
if [ "$ec" -eq 0 ] && [ ! -d "$SB/try/main-$short" ] && [ "$branch_exists" = yes ]; then
  mark_pass "[try] 删 worktree 保留分支"
else
  mark_fail "[try] ec=$ec dir_gone=$([ ! -d "$SB/try/main-$short" ] && echo yes || echo no) branch_exists=$branch_exists"
fi
git branch -D "try/main-$short" 2>/dev/null || true

# Case 4: try 类，建一个，y 同时删分支
git worktree add -b "try/main-$short" "$SB/try/main-$short" "$SHA" >/dev/null 2>&1
out=$(printf 'try/main-%s\ny\n' "$short" | bash "$SCRIPT" try 2>&1) && ec=0 || ec=$?
branch_exists=$(git show-ref --verify --quiet "refs/heads/try/main-$short" && echo yes || echo no)
if [ "$ec" -eq 0 ] && [ ! -d "$SB/try/main-$short" ] && [ "$branch_exists" = no ]; then
  mark_pass "[try] 删 worktree + 分支"
else
  mark_fail "[try] 同时删 ec=$ec branch_exists=$branch_exists"
fi

# Case 5: 输入不在列表的名字 → exit 1
git worktree add -b "fix/realone" "$SB/fix/realone" "$SHA" >/dev/null 2>&1
out=$(printf 'fix/nonexistent\n' | bash "$SCRIPT" fix 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -q "不在.*worktree 列表里"; then
  mark_pass "[fix] 拒绝列表外名字"
else
  mark_fail "[fix] 应拒绝 ec=$ec"
fi

# 清理 fix/realone
git worktree remove "$SB/fix/realone" 2>/dev/null || true
git branch -D fix/realone 2>/dev/null || true

# Case 6: 非法 purpose
out=$(bash "$SCRIPT" badpurpose 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -q "invalid purpose"; then
  mark_pass "拒绝非法 purpose"
else
  mark_fail "应拒绝非法 purpose ec=$ec"
fi

teardown "$SB"
cd "$DIR"

echo
echo "── 总计 ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
