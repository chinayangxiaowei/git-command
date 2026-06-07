#!/usr/bin/env bash
# Integration tests for branch-delete.sh
# Run: bash test/test-branch-delete.sh
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$DIR/branch-delete.sh"

# Don't pause for "press Enter" at the end of each script invocation
export GIT_COMMAND_NO_PAUSE=1

pass=0
fail=0

mark_pass() { pass=$((pass+1)); echo "  ✓ $1"; }
mark_fail() { fail=$((fail+1)); echo "  ✗ $1"; }

# Sandbox: plain git repo (branch-delete doesn't need bare+wt layout)
setup_sandbox() {
  local sb
  sb=$(mktemp -d)
  cd "$sb"
  git init -q -b main
  git config user.email "t@t"
  git config user.name "t"
  echo a > a.txt && git add a.txt && git commit -qm "a"
  echo b > b.txt && git add b.txt && git commit -qm "b"
  echo c > c.txt && git add c.txt && git commit -qm "c"
  printf '%s\n' "$sb"
}

teardown() { cd /; rm -rf "$1"; }

echo "── branch-delete integration tests ──"
SB=$(setup_sandbox)
echo "  sandbox: $SB"
cd "$SB"

SHA_B=$(git rev-parse HEAD~1)  # b
SHA_A=$(git rev-parse HEAD~2)  # a
SHA_C=$(git rev-parse HEAD)    # c (HEAD = main)

# Case 1: no branches at this commit → exit 0 + en/zh stable marker
out=$(echo "" | bash "$SCRIPT" "$SHA_A" 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && echo "$out" | grep -qE "(No local branches|没有本地分支)"; then
  mark_pass "no branches → exit 0"
else
  mark_fail "no branches (ec=$ec)"
fi

# Case 2: 1 branch → feed y → deleted
git branch lonely "$SHA_B"
out=$(printf 'y\n' | bash "$SCRIPT" "$SHA_B" 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && ! git show-ref --verify --quiet "refs/heads/lonely"; then
  mark_pass "sole branch deleted"
else
  mark_fail "sole branch should be deleted ec=$ec"
fi

# Case 3: multiple branches + input by number
git branch alpha "$SHA_B"
git branch beta "$SHA_B"
git branch gamma "$SHA_B"
# Input "2\ny\n" → pick second by listed order
out=$(printf '2\ny\n' | bash "$SCRIPT" "$SHA_B" 2>&1) && ec=0 || ec=$?
# Grab the actual line that was numbered 2
target=$(echo "$out" | grep -E '^\s*2\.' | sed -E 's/.*2\. *//')
if [ -n "$target" ] && ! git show-ref --verify --quiet "refs/heads/$target"; then
  mark_pass "delete by number ($target)"
else
  mark_fail "delete by number failed ec=$ec target='$target'"
fi
# Cleanup remaining
git branch -D alpha 2>/dev/null || true
git branch -D beta  2>/dev/null || true
git branch -D gamma 2>/dev/null || true

# Case 4: multiple branches + input by name
git branch alpha "$SHA_B"
git branch beta "$SHA_B"
out=$(printf 'alpha\ny\n' | bash "$SCRIPT" "$SHA_B" 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && ! git show-ref --verify --quiet "refs/heads/alpha" \
                   && git show-ref --verify --quiet "refs/heads/beta"; then
  mark_pass "delete by name"
else
  mark_fail "delete by name failed ec=$ec"
fi
git branch -D beta 2>/dev/null || true

# Case 5: refuse to delete currently-checked-out branch (main → SHA_C, HEAD on main)
out=$(printf 'y\n' | bash "$SCRIPT" "$SHA_C" 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -qE "(Cannot delete the currently checked-out|无法删当前所在分支)"; then
  mark_pass "refuse to delete current branch"
else
  mark_fail "should refuse current branch ec=$ec"
fi

# Case 6: input a name not in the list → exit 1
git branch foo "$SHA_B"
git branch bar "$SHA_B"
out=$(printf 'nonexistent\n' | bash "$SCRIPT" "$SHA_B" 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -qE "(not in the at-this-commit list|不在指向此 commit 的分支列表里)"; then
  mark_pass "reject name not in list"
else
  mark_fail "should reject name not in list ec=$ec"
fi
git branch -D foo bar 2>/dev/null || true

teardown "$SB"
cd "$DIR"

echo
echo "── Total ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
