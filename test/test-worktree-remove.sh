#!/usr/bin/env bash
# Integration tests for worktree-remove.sh
# Run: bash test/test-worktree-remove.sh
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

echo "── worktree-remove integration tests ──"
SB=$(setup_sandbox)
echo "  sandbox: $SB"
cd "$SB/main"

SHA=$(git rev-parse HEAD)
short=$(git rev-parse --short HEAD)

# Case 1: review with no worktrees → exit 0
out=$(echo "" | bash "$SCRIPT" review 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && echo "$out" | grep -qE "(has no worktree to remove|没有 worktree 可删)"; then
  mark_pass "[review] empty state exits cleanly"
else
  mark_fail "[review] should exit cleanly ec=$ec"
fi

# Case 2: review with one worktree → paste name to delete
git worktree add --detach "$SB/review/$short" "$SHA" >/dev/null 2>&1
out=$(printf 'review/%s\n' "$short" | bash "$SCRIPT" review 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ ! -d "$SB/review/$short" ]; then
  mark_pass "[review] deletion succeeded"
else
  mark_fail "[review] deletion failed ec=$ec exists=$([ -d "$SB/review/$short" ] && echo yes || echo no)"
fi

# Case 3: try with one worktree → reply 'n' to keep branch
git worktree add -b "try/main-$short" "$SB/try/main-$short" "$SHA" >/dev/null 2>&1
# Input: try/main-<short>\n + n\n (don't delete branch)
out=$(printf 'try/main-%s\nn\n' "$short" | bash "$SCRIPT" try 2>&1) && ec=0 || ec=$?
branch_exists=$(git show-ref --verify --quiet "refs/heads/try/main-$short" && echo yes || echo no)
if [ "$ec" -eq 0 ] && [ ! -d "$SB/try/main-$short" ] && [ "$branch_exists" = yes ]; then
  mark_pass "[try] worktree removed, branch retained"
else
  mark_fail "[try] ec=$ec dir_gone=$([ ! -d "$SB/try/main-$short" ] && echo yes || echo no) branch_exists=$branch_exists"
fi
git branch -D "try/main-$short" 2>/dev/null || true

# Case 4: try with one worktree → reply 'y' to also delete the branch
git worktree add -b "try/main-$short" "$SB/try/main-$short" "$SHA" >/dev/null 2>&1
out=$(printf 'try/main-%s\ny\n' "$short" | bash "$SCRIPT" try 2>&1) && ec=0 || ec=$?
branch_exists=$(git show-ref --verify --quiet "refs/heads/try/main-$short" && echo yes || echo no)
if [ "$ec" -eq 0 ] && [ ! -d "$SB/try/main-$short" ] && [ "$branch_exists" = no ]; then
  mark_pass "[try] worktree + branch deleted"
else
  mark_fail "[try] dual deletion ec=$ec branch_exists=$branch_exists"
fi

# Case 5: name not in list → exit 1
git worktree add -b "fix/realone" "$SB/fix/realone" "$SHA" >/dev/null 2>&1
out=$(printf 'fix/nonexistent\n' | bash "$SCRIPT" fix 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -qE "(is not in the .* worktree list|不在.*worktree 列表里)"; then
  mark_pass "[fix] reject name not in list"
else
  mark_fail "[fix] should reject name not in list ec=$ec"
fi

# Cleanup fix/realone
git worktree remove "$SB/fix/realone" 2>/dev/null || true
git branch -D fix/realone 2>/dev/null || true

# Case 6: invalid purpose
out=$(bash "$SCRIPT" badpurpose 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -q "invalid purpose"; then
  mark_pass "reject invalid purpose"
else
  mark_fail "should reject invalid purpose ec=$ec"
fi

teardown "$SB"
cd "$DIR"

echo
echo "── Total ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
