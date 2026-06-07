#!/usr/bin/env bash
# 集成 + 单元测试 for worktree-from.sh
# 跑法: bash test/test-worktree-from.sh
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$DIR/worktree-from.sh"

# 让 source 主脚本只拿函数，不跑 main
# shellcheck source=/dev/null
source "$SCRIPT"

pass=0
fail=0

assert_eq() {
  local got="$1" want="$2" name="$3"
  if [ "$got" = "$want" ]; then
    pass=$((pass + 1))
    echo "  ✓ $name"
  else
    fail=$((fail + 1))
    echo "  ✗ $name"
    echo "    want: $(printf '%q' "$want")"
    echo "    got:  $(printf '%q' "$got")"
  fi
}

echo "── slug() 单元测试 ──"
assert_eq "$(slug 'fix: auth bug')"          'fix-auth-bug'              "conventional commit prefix"
assert_eq "$(slug '修复登录 bug')"            '修复登录-bug'              "中文 + 空格"
assert_eq "$(slug 'WIP refactor')"           'WIP-refactor'              "大写字母保留"
assert_eq "$(slug '   leading/trailing   ')" 'leading-trailing'          "trim + / 替换"
assert_eq "$(slug 'feat(payment): add ✨')"  'feat(payment)-add-✨'      "() 和 emoji 保留"
assert_eq "$(slug '')"                       ''                          "空 → 空"
assert_eq "$(slug 'a/b/c')"                  'a-b-c'                     "斜杠替换"
assert_eq "$(slug '~^:?*[\')"                ''                          "全非法 → 空"
assert_eq "$(slug '中文 ✨ test')"            '中文-✨-test'              "中文 + emoji 混合"

echo
echo "── 集成测试 ──"

# 沙箱：建临时 bare+worktree 布局
setup_sandbox() {
  local sb
  sb=$(mktemp -d)
  cd "$sb"
  # bare repo
  git init --bare .bare >/dev/null
  git --git-dir=.bare symbolic-ref HEAD refs/heads/main
  # 占位 commit（worktree add 需要 HEAD 有 commit）
  local tree commit
  tree=$(git --git-dir=.bare hash-object -t tree --stdin < /dev/null)
  commit=$(git --git-dir=.bare commit-tree -m "init" "$tree")
  git --git-dir=.bare update-ref refs/heads/main "$commit"
  echo "gitdir: ./.bare" > .git
  git worktree add main main >/dev/null
  # 在 main 里建 3 个 commit 不同 subject
  cd main
  git config user.email "test@example.com"
  git config user.name "test"
  echo "a" > a.txt && git add a.txt && git commit -m "fix: auth bug in login" >/dev/null
  echo "b" > b.txt && git add b.txt && git commit -m "修复登录 bug" >/dev/null
  echo "c" > c.txt && git add c.txt && git commit -m "feat(payment): add stripe" >/dev/null
  printf '%s\n' "$sb"
}

teardown_sandbox() {
  local sb="$1"
  cd /
  rm -rf "$sb"
}

SB=$(setup_sandbox)
echo "  sandbox: $SB"
SHA1=$(git rev-parse HEAD~2)  # fix: auth bug...
SHA2=$(git rev-parse HEAD~1)  # 修复登录 bug
SHA3=$(git rev-parse HEAD)    # feat(payment): add stripe

# 占位断言（下个 Task 实现真测试）
assert_eq "ok" "ok" "sandbox 建好"

teardown_sandbox "$SB"
cd "$DIR"

echo
echo "── 总计 ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
