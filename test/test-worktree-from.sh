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
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
