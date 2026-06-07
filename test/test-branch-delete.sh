#!/usr/bin/env bash
# 集成测试 for branch-delete.sh
# 跑法: bash test/test-branch-delete.sh
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$DIR/branch-delete.sh"

pass=0
fail=0

mark_pass() { pass=$((pass+1)); echo "  ✓ $1"; }
mark_fail() { fail=$((fail+1)); echo "  ✗ $1"; }

# 建沙箱：普通 git repo（branch-delete 不需要 bare+wt 布局）
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

echo "── branch-delete 集成测试 ──"
SB=$(setup_sandbox)
echo "  sandbox: $SB"
cd "$SB"

SHA_B=$(git rev-parse HEAD~1)  # b
SHA_A=$(git rev-parse HEAD~2)  # a
SHA_C=$(git rev-parse HEAD)    # c (HEAD = main)

# Case 1: 此 commit 无分支 → exit 0 + "没有本地分支可删"
out=$(echo "" | bash "$SCRIPT" "$SHA_A" 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && echo "$out" | grep -q "没有本地分支可删"; then
  mark_pass "无分支可删 → 0 退出"
else
  mark_fail "无分支可删（ec=$ec）"
fi

# Case 2: 1 个分支 → 喂 y 确认 → 删成功
git branch lonely "$SHA_B"
out=$(printf 'y\n' | bash "$SCRIPT" "$SHA_B" 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && ! git show-ref --verify --quiet "refs/heads/lonely"; then
  mark_pass "唯一分支删除成功"
else
  mark_fail "唯一分支应删除 ec=$ec"
fi

# Case 3: 多个分支 + 输入编号
git branch alpha "$SHA_B"
git branch beta "$SHA_B"
git branch gamma "$SHA_B"
# 输入 "2\ny\n" → 选 beta（按字母序 alpha=1, beta=2, gamma=3）
out=$(printf '2\ny\n' | bash "$SCRIPT" "$SHA_B" 2>&1) && ec=0 || ec=$?
# 实际顺序看 git branch --points-at 输出。git 通常按字母序排但不保证。
# 我们抓 stdout 里实际哪条被打印为 2.，再判断哪个分支应被删
target=$(echo "$out" | grep -E '^\s*2\.' | sed -E 's/.*2\. *//')
if [ -n "$target" ] && ! git show-ref --verify --quiet "refs/heads/$target"; then
  mark_pass "多分支按编号删除 ($target)"
else
  mark_fail "多分支按编号删除失败 ec=$ec target='$target'"
fi
# 清剩下两个
git branch -D alpha 2>/dev/null || true
git branch -D beta  2>/dev/null || true
git branch -D gamma 2>/dev/null || true

# Case 4: 多个分支 + 输入分支名
git branch alpha "$SHA_B"
git branch beta "$SHA_B"
out=$(printf 'alpha\ny\n' | bash "$SCRIPT" "$SHA_B" 2>&1) && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && ! git show-ref --verify --quiet "refs/heads/alpha" \
                   && git show-ref --verify --quiet "refs/heads/beta"; then
  mark_pass "多分支按名字删除"
else
  mark_fail "多分支按名字删除失败 ec=$ec"
fi
git branch -D beta 2>/dev/null || true

# Case 5: 拒绝删当前分支 (main 指向 SHA_C，HEAD on main)
out=$(printf 'y\n' | bash "$SCRIPT" "$SHA_C" 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -q "无法删当前所在分支"; then
  mark_pass "拒绝删当前分支"
else
  mark_fail "应拒绝删当前分支 ec=$ec"
fi

# Case 6: 输入不在列表里的分支名 → exit 1
git branch foo "$SHA_B"
git branch bar "$SHA_B"
out=$(printf 'nonexistent\n' | bash "$SCRIPT" "$SHA_B" 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -q "不在指向此 commit 的分支列表里"; then
  mark_pass "拒绝列表外分支名"
else
  mark_fail "应拒绝列表外名字 ec=$ec"
fi
git branch -D foo bar 2>/dev/null || true

teardown "$SB"
cd "$DIR"

echo
echo "── 总计 ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
