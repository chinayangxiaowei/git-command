#!/usr/bin/env bash
# Unit + integration tests for worktree-from.sh
# Run: bash test/test-worktree-from.sh
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$DIR/worktree-from.sh"

# Source the script to expose slug() without running main()
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

echo "── slug() unit tests ──"
assert_eq "$(slug 'fix: auth bug')"          'fix-auth-bug'              "conventional commit prefix"
assert_eq "$(slug '修复登录 bug')"            '修复登录-bug'              "CJK + space"
assert_eq "$(slug 'WIP refactor')"           'WIP-refactor'              "uppercase preserved"
assert_eq "$(slug '   leading/trailing   ')" 'leading-trailing'          "trim + slash replacement"
assert_eq "$(slug 'feat(payment): add ✨')"  'feat(payment)-add-✨'      "() and emoji preserved"
assert_eq "$(slug '')"                       ''                          "empty → empty"
assert_eq "$(slug 'a/b/c')"                  'a-b-c'                     "slash replacement"
assert_eq "$(slug '~^:?*[\')"                ''                          "all illegal → empty"
assert_eq "$(slug '中文 ✨ test')"            '中文-✨-test'              "CJK + emoji mix"

echo
echo "── integration tests ──"

# Sandbox: bare + worktree layout in mktemp
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
  git worktree add main main >/dev/null
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

assert_eq "ok" "ok" "sandbox set up"

SCRIPT_BIN="bash $SCRIPT"

# bad purpose → exit 1 with "invalid purpose" stderr
out=$($SCRIPT_BIN badpurpose "$SHA1" 2>&1) && ec=0 || ec=$?
if echo "$out" | grep -q "invalid purpose"; then
  pass=$((pass+1)); echo "  ✓ bad purpose surfaces correct error"
else
  fail=$((fail+1)); echo "  ✗ bad purpose error message wrong (ec=$ec)"
fi

# bad SHA → exit 1
out=$($SCRIPT_BIN review notasha 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ]; then
  pass=$((pass+1)); echo "  ✓ bad SHA exits non-zero"
else
  fail=$((fail+1)); echo "  ✗ bad SHA should exit non-zero"
fi

# review: detached check-out at review/<short_sha>/
short1=$(git rev-parse --short "$SHA1")
$SCRIPT_BIN review "$SHA1" >/dev/null 2>&1 && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ -d "$SB/review/$short1" ]; then
  pass=$((pass+1)); echo "  ✓ review path created: review/$short1/"
else
  exists=$([ -d "$SB/review/$short1" ] && echo yes || echo no)
  fail=$((fail+1)); echo "  ✗ review path not created ec=$ec exists=$exists"
fi

# review HEAD is detached
if [ -d "$SB/review/$short1" ]; then
  head=$(git -C "$SB/review/$short1" rev-parse --abbrev-ref HEAD)
  if [ "$head" = "HEAD" ]; then
    pass=$((pass+1)); echo "  ✓ review HEAD detached"
  else
    fail=$((fail+1)); echo "  ✗ review HEAD not detached: $head"
  fi
fi

# try: auto-name try/<base_slug>-<short_sha>/, base_slug=main
short2=$(git rev-parse --short "$SHA2")
expected_path="try/main-$short2"
$SCRIPT_BIN try "$SHA2" >/dev/null 2>&1 && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ -d "$SB/$expected_path" ]; then
  pass=$((pass+1)); echo "  ✓ try path created: $expected_path"
else
  fail=$((fail+1)); echo "  ✗ try path wrong ec=$ec expected=$expected_path"
fi

# try branch matches path
if [ -d "$SB/$expected_path" ]; then
  br=$(git -C "$SB/$expected_path" rev-parse --abbrev-ref HEAD)
  if [ "$br" = "$expected_path" ]; then
    pass=$((pass+1)); echo "  ✓ try branch name matches path"
  else
    fail=$((fail+1)); echo "  ✗ try branch name wrong: $br"
  fi
fi

# fix: feed newline → accept default name = slug(subject)-short_sha
# SHA3 subject = "feat(payment): add stripe" → slug = "feat(payment)-add-stripe"
short3=$(git rev-parse --short "$SHA3")
default_name="feat(payment)-add-stripe-${short3}"
fix_path="fix/$default_name"
echo "" | $SCRIPT_BIN fix "$SHA3" >/dev/null 2>&1 && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ -d "$SB/$fix_path" ]; then
  pass=$((pass+1)); echo "  ✓ fix default name: $default_name"
else
  fail=$((fail+1)); echo "  ✗ fix path wrong ec=$ec expected=$fix_path"
fi

# fix branch matches path
if [ -d "$SB/$fix_path" ]; then
  br=$(git -C "$SB/$fix_path" rev-parse --abbrev-ref HEAD)
  if [ "$br" = "$fix_path" ]; then
    pass=$((pass+1)); echo "  ✓ fix branch name matches path"
  else
    fail=$((fail+1)); echo "  ✗ fix branch name wrong: $br"
  fi
fi

# Conflict: re-running same review SHA → reports path conflict
out=$($SCRIPT_BIN review "$SHA1" 2>&1) && ec=0 || ec=$?
if echo "$out" | grep -qE "(Path already exists|路径已存在)"; then
  pass=$((pass+1)); echo "  ✓ path-conflict detection"
else
  fail=$((fail+1)); echo "  ✗ path conflict not detected ec=$ec"
fi

teardown_sandbox "$SB"
cd "$DIR"

echo
echo "── Total ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
