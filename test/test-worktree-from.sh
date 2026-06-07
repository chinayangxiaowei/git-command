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
# setup_sandbox's `cd` was in a subshell; caller must cd into sandbox too.
cd "$SB/main"
SHA1=$(git rev-parse HEAD~2)  # fix: auth bug...
SHA2=$(git rev-parse HEAD~1)  # 修复登录 bug
SHA3=$(git rev-parse HEAD)    # feat(payment): add stripe

# 占位断言（下个 Task 实现真测试）
assert_eq "ok" "ok" "sandbox 建好"

SCRIPT_BIN="bash $SCRIPT"

# bad purpose → exit 1，stderr 包含 "invalid purpose"
out=$($SCRIPT_BIN badpurpose "$SHA1" 2>&1) && ec=0 || ec=$?
if echo "$out" | grep -q "invalid purpose"; then
  pass=$((pass+1)); echo "  ✓ bad purpose 报正确错误"
else
  fail=$((fail+1)); echo "  ✗ bad purpose 错误信息不对 (ec=$ec)"
fi

# bad SHA → exit 1
out=$($SCRIPT_BIN review notasha 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ]; then
  pass=$((pass+1)); echo "  ✓ bad SHA 退出非 0"
else
  fail=$((fail+1)); echo "  ✗ bad SHA 应退出非 0"
fi

# review: 在 review/<short_sha>/ detached 检出
short1=$(git rev-parse --short "$SHA1")
$SCRIPT_BIN review "$SHA1" >/dev/null 2>&1 && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ -d "$SB/review/$short1" ]; then
  pass=$((pass+1)); echo "  ✓ review 路径创建成功: review/$short1/"
else
  exists=$([ -d "$SB/review/$short1" ] && echo yes || echo no)
  fail=$((fail+1)); echo "  ✗ review 路径未创建 ec=$ec exists=$exists"
fi

# review HEAD 是 detached
if [ -d "$SB/review/$short1" ]; then
  head=$(git -C "$SB/review/$short1" rev-parse --abbrev-ref HEAD)
  if [ "$head" = "HEAD" ]; then
    pass=$((pass+1)); echo "  ✓ review HEAD detached"
  else
    fail=$((fail+1)); echo "  ✗ review HEAD 不是 detached: $head"
  fi
fi

# try: 自动命名 try/<base_slug>-<short_sha>/，base_slug=main（当前在 main worktree）
short2=$(git rev-parse --short "$SHA2")
expected_path="try/main-$short2"
$SCRIPT_BIN try "$SHA2" >/dev/null 2>&1 && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ -d "$SB/$expected_path" ]; then
  pass=$((pass+1)); echo "  ✓ try 路径创建: $expected_path"
else
  fail=$((fail+1)); echo "  ✗ try 路径错 ec=$ec expected=$expected_path"
fi

# try 分支名 = 路径
if [ -d "$SB/$expected_path" ]; then
  br=$(git -C "$SB/$expected_path" rev-parse --abbrev-ref HEAD)
  if [ "$br" = "$expected_path" ]; then
    pass=$((pass+1)); echo "  ✓ try 分支同名"
  else
    fail=$((fail+1)); echo "  ✗ try 分支名错: $br"
  fi
fi

# fix: 喂回车接受默认 name = slug(subject)-short_sha
# SHA3 subject = "feat(payment): add stripe" → slug = "feat(payment)-add-stripe"
short3=$(git rev-parse --short "$SHA3")
default_name="feat(payment)-add-stripe-${short3}"
fix_path="fix/$default_name"
echo "" | $SCRIPT_BIN fix "$SHA3" >/dev/null 2>&1 && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ -d "$SB/$fix_path" ]; then
  pass=$((pass+1)); echo "  ✓ fix 默认 name: $default_name"
else
  fail=$((fail+1)); echo "  ✗ fix 路径错 ec=$ec expected=$fix_path"
fi

# fix 分支同名
if [ -d "$SB/$fix_path" ]; then
  br=$(git -C "$SB/$fix_path" rev-parse --abbrev-ref HEAD)
  if [ "$br" = "$fix_path" ]; then
    pass=$((pass+1)); echo "  ✓ fix 分支同名"
  else
    fail=$((fail+1)); echo "  ✗ fix 分支名错: $br"
  fi
fi

# 冲突：再跑同一 review SHA → 报路径冲突
out=$($SCRIPT_BIN review "$SHA1" 2>&1) && ec=0 || ec=$?
if echo "$out" | grep -q "路径已存在"; then
  pass=$((pass+1)); echo "  ✓ 路径冲突检测"
else
  fail=$((fail+1)); echo "  ✗ 路径冲突未检测 ec=$ec"
fi

teardown_sandbox "$SB"
cd "$DIR"

echo
echo "── 总计 ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
