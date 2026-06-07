#!/usr/bin/env bash
# test/test-all.sh — single-entry test for the whole git-command suite.
#
# Architecture:
#   1. Build a real bare+worktree sandbox via init-bare-tree.sh (this also
#      validates init-bare-tree itself transitively, and exercises every
#      script's require_bare_layout check).
#   2. Build base commits in main/.
#   3. Each test case gets its own dedicated worktree inside the sandbox
#      so cases don't fight over HEAD / branches / staging.
#   4. Cases run sequentially today (deterministic, easy to debug). A
#      future revision can spawn independent cases with & + wait.
#
# Skip Zed pop-ups and the post-success "press Enter" pause:
set -euo pipefail
export GIT_COMMAND_NO_OPEN=1
export GIT_COMMAND_NO_PAUSE=1

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

pass=0
fail=0
ok()   { pass=$((pass+1)); echo "  ✓ $1"; }
fail_() { fail=$((fail+1)); echo "  ✗ $1"; }

assert_eq() {
  local got="$1" want="$2" name="$3"
  if [ "$got" = "$want" ]; then ok "$name"
  else
    fail_ "$name"
    echo "      want: $(printf '%q' "$want")"
    echo "      got:  $(printf '%q' "$got")"
  fi
}

# ───────────────────────────────────────────────────────────────
# Unit: slug() from worktree-from.sh (sourced cleanly via guard)
# ───────────────────────────────────────────────────────────────
echo "── slug() unit ──"
# shellcheck source=/dev/null
source "$DIR/worktree-from.sh"
assert_eq "$(slug 'fix: auth bug')"          'fix-auth-bug'              "conventional prefix"
assert_eq "$(slug '修复登录 bug')"            '修复登录-bug'              "CJK + space"
assert_eq "$(slug 'WIP refactor')"           'WIP-refactor'              "uppercase preserved"
assert_eq "$(slug '   leading/trailing   ')" 'leading-trailing'          "trim + slash"
assert_eq "$(slug 'feat(payment): add ✨')"  'feat(payment)-add-✨'      "() + emoji"
assert_eq "$(slug '')"                       ''                          "empty"
assert_eq "$(slug 'a/b/c')"                  'a-b-c'                     "slashes"
assert_eq "$(slug '~^:?*[\')"                ''                          "all illegal"
assert_eq "$(slug '中文 ✨ test')"            '中文-✨-test'              "CJK + emoji mix"

# ───────────────────────────────────────────────────────────────
# Sandbox: init-bare-tree.sh build a real bare+wt layout
# ───────────────────────────────────────────────────────────────
SB=$(mktemp -d)
echo
echo "── Sandbox: $SB ──"
cd "$SB"
bash "$DIR/init-bare-tree.sh" project >/dev/null
cd project/main
git config user.email "t@t"
git config user.name "t"

# Base commits in main: 3 different subjects to exercise i18n / slug paths
echo a > a.txt && git add a.txt && git commit -qm "fix: auth bug in login"
echo b > b.txt && git add b.txt && git commit -qm "修复登录 bug"
echo c > c.txt && git add c.txt && git commit -qm "feat(payment): add stripe"

SHA1=$(git rev-parse HEAD~2)   # fix: auth bug in login
SHA2=$(git rev-parse HEAD~1)   # 修复登录 bug
SHA3=$(git rev-parse HEAD)     # feat(payment): add stripe
short1=$(git rev-parse --short "$SHA1")
short2=$(git rev-parse --short "$SHA2")
short3=$(git rev-parse --short "$SHA3")
PROJECT="$SB/project"
MAIN="$PROJECT/main"

# Helpers
run() { bash "$DIR/$1" "${@:2}" >/dev/null 2>&1; }
run_out() { bash "$DIR/$1" "${@:2}" 2>&1; }
exit_code() { local ec=0; bash "$DIR/$1" "${@:2}" >/dev/null 2>&1 || ec=$?; echo "$ec"; }

# ───────────────────────────────────────────────────────────────
# worktree-from
# ───────────────────────────────────────────────────────────────
echo
echo "── worktree-from ──"

# review at SHA1: creates review/<short>/, detached
if run worktree-from.sh review "$SHA1" && [ -d "$PROJECT/review/$short1" ]; then
  ok "review path created"
  head=$(git -C "$PROJECT/review/$short1" rev-parse --abbrev-ref HEAD)
  [ "$head" = "HEAD" ] && ok "review HEAD detached" || fail_ "review HEAD: $head"
else
  fail_ "review failed"
fi

# try at SHA2: try/main-<short>/, branch same name
expected="try/main-$short2"
if run worktree-from.sh try "$SHA2" && [ -d "$PROJECT/$expected" ]; then
  ok "try path created"
  br=$(git -C "$PROJECT/$expected" rev-parse --abbrev-ref HEAD)
  [ "$br" = "$expected" ] && ok "try branch matches path" || fail_ "try branch: $br"
else
  fail_ "try failed"
fi

# fix at SHA3 with default name (feed empty line)
default_name="feat(payment)-add-stripe-${short3}"
fix_path="fix/$default_name"
if echo "" | bash "$DIR/worktree-from.sh" fix "$SHA3" >/dev/null 2>&1 && [ -d "$PROJECT/$fix_path" ]; then
  ok "fix default name accepted: $default_name"
else
  fail_ "fix default name failed"
fi

# Duplicate review = path conflict
out=$(bash "$DIR/worktree-from.sh" review "$SHA1" 2>&1) && ec=0 || ec=$?
if echo "$out" | grep -qE "(Path already exists|路径已存在)"; then
  ok "duplicate review detects conflict"
else
  fail_ "duplicate review ec=$ec"
fi

# Invalid purpose
out=$(bash "$DIR/worktree-from.sh" badpurpose "$SHA1" 2>&1) && ec=0 || ec=$?
echo "$out" | grep -q "invalid purpose" && ok "invalid purpose rejected" || fail_ "purpose ec=$ec"

# Invalid SHA
ec=$(exit_code worktree-from.sh review notasha)
[ "$ec" -ne 0 ] && ok "invalid SHA rejected" || fail_ "invalid SHA"

# ───────────────────────────────────────────────────────────────
# worktree-remove (use the worktrees just created)
# ───────────────────────────────────────────────────────────────
echo
echo "── worktree-remove ──"

# remove the review worktree
if printf 'review/%s\n' "$short1" | bash "$DIR/worktree-remove.sh" review >/dev/null 2>&1 \
   && [ ! -d "$PROJECT/review/$short1" ]; then
  ok "[review] removed via paste-confirm"
else
  fail_ "[review] removal failed"
fi

# remove the try worktree, keep the branch
if printf 'try/main-%s\nn\n' "$short2" | bash "$DIR/worktree-remove.sh" try >/dev/null 2>&1 \
   && [ ! -d "$PROJECT/try/main-$short2" ] \
   && git show-ref --verify --quiet "refs/heads/try/main-$short2"; then
  ok "[try] worktree removed, branch retained"
  git branch -D "try/main-$short2" 2>/dev/null
else
  fail_ "[try] retain-branch failed"
fi

# review with no worktrees left → exits cleanly
out=$(bash "$DIR/worktree-remove.sh" review 2>&1) && ec=0 || ec=$?
echo "$out" | grep -qE "(has no worktree to remove|没有 worktree 可删)" && ok "[review] empty state ok" \
  || fail_ "[review] empty ec=$ec"

# Invalid purpose
ec=$(exit_code worktree-remove.sh badpurpose)
[ "$ec" -ne 0 ] && ok "[remove] invalid purpose rejected" || fail_ "[remove] purpose"

# Clean up any remaining worktrees + branches from worktree-from so
# downstream branch-* tests see only `main` at HEAD.
default_name="feat(payment)-add-stripe-${short3}"
git worktree remove "$PROJECT/fix/$default_name" 2>/dev/null || true
git branch -D "fix/$default_name" 2>/dev/null || true

# ───────────────────────────────────────────────────────────────
# branch-delete
# ───────────────────────────────────────────────────────────────
echo
echo "── branch-delete ──"

# zero branches at SHA1: exits 0 + no-branches message
out=$(echo "" | bash "$DIR/branch-delete.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
[ "$ec" -eq 0 ] && echo "$out" | grep -qE "(No local branches|没有本地分支)" \
  && ok "no branches → clean exit" || fail_ "no branches ec=$ec"

# single branch: confirm y → deleted
git branch lonely "$SHA1"
if printf 'y\n' | bash "$DIR/branch-delete.sh" "$SHA1" >/dev/null 2>&1 \
   && ! git show-ref --verify --quiet "refs/heads/lonely"; then
  ok "sole branch deleted on y"
else
  fail_ "sole branch delete failed"
fi

# multiple branches + pick by number
git branch alpha "$SHA1"
git branch beta  "$SHA1"
git branch gamma "$SHA1"
out=$(printf '2\ny\n' | bash "$DIR/branch-delete.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
target=$(echo "$out" | grep -E '^\s*2\.' | sed -E 's/.*2\. *//')
if [ -n "$target" ] && ! git show-ref --verify --quiet "refs/heads/$target"; then
  ok "multi: delete by number ($target)"
  git branch -D alpha beta gamma 2>/dev/null || true
else
  fail_ "multi number ec=$ec target='$target'"
  git branch -D alpha beta gamma 2>/dev/null || true
fi

# multiple + pick by name
git branch alpha "$SHA1"
git branch beta  "$SHA1"
if printf 'alpha\ny\n' | bash "$DIR/branch-delete.sh" "$SHA1" >/dev/null 2>&1 \
   && ! git show-ref --verify --quiet "refs/heads/alpha" \
   && git show-ref --verify --quiet "refs/heads/beta"; then
  ok "multi: delete by name"
  git branch -D beta 2>/dev/null
else
  fail_ "multi by-name"
  git branch -D alpha beta 2>/dev/null || true
fi

# refuse to delete current branch (HEAD's commit)
out=$(printf 'y\n' | bash "$DIR/branch-delete.sh" "$(git rev-parse HEAD)" 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -qE "(Cannot delete|无法删)"; then
  ok "refuse current branch"
else
  fail_ "current ec=$ec out='$(echo "$out" | tail -3)'"
fi

# reject name not in list
git branch x "$SHA1"
git branch y "$SHA1"
out=$(printf 'nonexistent\n' | bash "$DIR/branch-delete.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(not in the at-this-commit list|不在指向此 commit 的分支列表里)" \
  && ok "reject name-not-in-list" || fail_ "not-in-list ec=$ec"
git branch -D x y 2>/dev/null

# ───────────────────────────────────────────────────────────────
# branch-checkout
# ───────────────────────────────────────────────────────────────
echo
echo "── branch-checkout ──"

# zero branches at SHA1 → exits 0 + no-branches
out=$(bash "$DIR/branch-checkout.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
[ "$ec" -eq 0 ] && echo "$out" | grep -qE "(No local branches|没有本地分支)" \
  && ok "no branches → clean exit" || fail_ "no branches ec=$ec"

# single branch at SHA1 → auto-switches
git branch only "$SHA1"
if bash "$DIR/branch-checkout.sh" "$SHA1" >/dev/null 2>&1 \
   && [ "$(git rev-parse --abbrev-ref HEAD)" = "only" ]; then
  ok "sole branch auto-checkout"
else
  fail_ "sole branch checkout failed (HEAD=$(git rev-parse --abbrev-ref HEAD))"
fi
git switch main >/dev/null 2>&1

# Multiple branches at SHA1 → pick by name
git branch p1 "$SHA1"
git branch p2 "$SHA1"
if printf 'p2\n' | bash "$DIR/branch-checkout.sh" "$SHA1" >/dev/null 2>&1 \
   && [ "$(git rev-parse --abbrev-ref HEAD)" = "p2" ]; then
  ok "multi: checkout by name"
else
  fail_ "multi by-name checkout (HEAD=$(git rev-parse --abbrev-ref HEAD))"
fi
git switch main >/dev/null 2>&1

# Dirty tree refuses
echo dirty >> a.txt
out=$(bash "$DIR/branch-checkout.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(uncommitted changes|未提交改动)" \
  && ok "dirty tree refused" || fail_ "dirty ec=$ec"
git checkout -- a.txt

# Already-on-branch is a no-op (ensure HEAD is on main first)
git switch main >/dev/null 2>&1 || true
if bash "$DIR/branch-checkout.sh" "$(git rev-parse HEAD)" >/dev/null 2>&1; then
  ok "already-on-branch no-op"
else
  fail_ "already-on no-op (HEAD=$(git rev-parse --abbrev-ref HEAD))"
fi

git branch -D only p1 p2 2>/dev/null || true

# ───────────────────────────────────────────────────────────────
# branch-rename
# ───────────────────────────────────────────────────────────────
echo
echo "── branch-rename ──"

# zero branches at SHA1 → no-branches
out=$(bash "$DIR/branch-rename.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
[ "$ec" -eq 0 ] && echo "$out" | grep -qE "(No local branches|没有本地分支)" \
  && ok "no branches → clean exit" || fail_ "no branches ec=$ec"

# Sole branch rename
git branch oldname "$SHA1"
if printf 'newname\n' | bash "$DIR/branch-rename.sh" "$SHA1" >/dev/null 2>&1 \
   && git show-ref --verify --quiet "refs/heads/newname" \
   && ! git show-ref --verify --quiet "refs/heads/oldname"; then
  ok "sole rename: old gone, new exists"
  git branch -D newname 2>/dev/null
else
  fail_ "sole rename"
  git branch -D oldname newname 2>/dev/null || true
fi

# new name already exists
git branch a "$SHA1"
git branch b "$SHA1"
out=$(printf 'a\nb\n' | bash "$DIR/branch-rename.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
# Pick "a", rename to "b" → conflict
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(Branch already exists|分支已存在)" \
  && ok "rename rejects existing name" || fail_ "rename-exists ec=$ec"
git branch -D a b 2>/dev/null

# Invalid new name — multi-branch so stdin: first line picks, second is new name
git branch picka "$SHA1"
git branch pickb "$SHA1"
out=$(printf 'picka\n..bad..\n' | bash "$DIR/branch-rename.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] && echo "$out" | grep -qE "(Invalid branch name|无效的分支名)"; then
  ok "rename rejects invalid name"
else
  fail_ "rename-invalid ec=$ec out='$(echo "$out" | tail -3)'"
fi
git branch -D picka pickb 2>/dev/null || true

# ───────────────────────────────────────────────────────────────
# copy-branch-name
# ───────────────────────────────────────────────────────────────
echo
echo "── copy-branch-name ──"

# no branches
out=$(bash "$DIR/copy-branch-name.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
[ "$ec" -eq 0 ] && echo "$out" | grep -qE "(No local branches|没有本地分支)" \
  && ok "no branches → clean exit" || fail_ "no branches ec=$ec"

# Single branch — exits 0 (we don't verify pbcopy content; clipboard is OS-side)
git branch solo "$SHA1"
ec=$(exit_code copy-branch-name.sh "$SHA1")
[ "$ec" -eq 0 ] && ok "sole branch copy ok" || fail_ "sole copy ec=$ec"
git branch -D solo

# Multiple — pick by name
git branch m1 "$SHA1"
git branch m2 "$SHA1"
ec=$(printf 'm1\n' | bash "$DIR/copy-branch-name.sh" "$SHA1" >/dev/null 2>&1 && echo 0 || echo $?)
[ "$ec" -eq 0 ] && ok "multi copy by name" || fail_ "multi copy ec=$ec"
git branch -D m1 m2

# ───────────────────────────────────────────────────────────────
# copy-commit-message
# ───────────────────────────────────────────────────────────────
echo
echo "── copy-commit-message ──"

# Subject (default)
ec=$(echo "" | bash "$DIR/copy-commit-message.sh" "$SHA1" >/dev/null 2>&1 && echo 0 || echo $?)
[ "$ec" -eq 0 ] && ok "subject (default) ok" || fail_ "subject ec=$ec"

# Full
ec=$(printf 'f\n' | bash "$DIR/copy-commit-message.sh" "$SHA1" >/dev/null 2>&1 && echo 0 || echo $?)
[ "$ec" -eq 0 ] && ok "full ok" || fail_ "full ec=$ec"

# Invalid choice
out=$(printf 'x\n' | bash "$DIR/copy-commit-message.sh" "$SHA1" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(Invalid choice|无效选项)" \
  && ok "invalid choice rejected" || fail_ "invalid choice ec=$ec"

# ───────────────────────────────────────────────────────────────
# Teardown
# ───────────────────────────────────────────────────────────────
cd /
rm -rf "$SB"

echo
echo "── Total ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
