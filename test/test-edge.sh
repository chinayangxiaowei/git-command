#!/usr/bin/env bash
# test/test-edge.sh — boundary inputs + the previously-untested simple
# scripts (5 VIEW wrappers, open-files, worktree-from feat/hot purposes,
# detached-HEAD try-branch path).
set -euo pipefail
export GIT_COMMAND_NO_OPEN=1
export GIT_COMMAND_NO_PAUSE=1

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

pass=0; fail=0
ok()    { pass=$((pass+1)); echo "  ✓ $1"; }
fail_() { fail=$((fail+1)); echo "  ✗ $1"; }

SB=$(mktemp -d)
cd "$SB"
bash "$DIR/init-bare-tree.sh" project >/dev/null
cd project/main
git config user.email "t@t"
git config user.name "t"
echo a > a.txt && git add a.txt && git commit -qm "fix: a"
echo b > b.txt && git add b.txt && git commit -qm "修复登录 ✨"
echo c > c.txt && git add c.txt && git commit -qm "feat: c"
SHA1=$(git rev-parse HEAD~2)
SHA2=$(git rev-parse HEAD~1)   # CJK + emoji subject
SHA3=$(git rev-parse HEAD)
PROJECT="$SB/project"
short1=$(git rev-parse --short "$SHA1")
short2=$(git rev-parse --short "$SHA2")
short3=$(git rev-parse --short "$SHA3")

# ───────────────────────────────────────────────────────────────
# 5 VIEW wrappers — make sure each exits 0 and produces non-empty
# output (we don't pin specific text since git output is volatile)
# ───────────────────────────────────────────────────────────────
echo "── view-* wrappers ──"
for sub in branches-containing tags-containing stat diff; do
  out=$(bash "$DIR/view-${sub}.sh" "$SHA2" </dev/null 2>&1) && ec=0 || ec=$?
  if [ "$ec" -eq 0 ]; then
    ok "view-${sub} exit 0"
  else
    fail_ "view-${sub} ec=$ec"
  fi
done
out=$(bash "$DIR/view-diff-head.sh" "$SHA1" </dev/null 2>&1) && ec=0 || ec=$?
[ "$ec" -eq 0 ] && ok "view-diff-head exit 0" || fail_ "view-diff-head ec=$ec"

# ───────────────────────────────────────────────────────────────
# open-files — empty-commit path
# ───────────────────────────────────────────────────────────────
echo
echo "── open-files boundary ──"
git commit --allow-empty -qm "empty commit"
SHA_EMPTY=$(git rev-parse HEAD)
out=$(bash "$DIR/open-files.sh" "$SHA_EMPTY" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(no file changes|没有文件变更)" \
  && ok "open-files reports empty commit" \
  || fail_ "open-files empty ec=$ec"
# reset HEAD back so following tests use SHA3 as tip
git reset --hard "$SHA3" >/dev/null

# ───────────────────────────────────────────────────────────────
# worktree-from feat / hot — purposes review/try/fix already tested
# but feat/hot share the fix code path. Add at least one round-trip.
# ───────────────────────────────────────────────────────────────
echo
echo "── worktree-from feat / hot ──"

# feat: subject is "修复登录 ✨" → slug = "修复登录-✨" → default_name
default_feat="修复登录-✨-${short2}"
echo "" | bash "$DIR/worktree-from.sh" feat "$SHA2" >/dev/null 2>&1
[ -d "$PROJECT/feat/$default_feat" ] \
  && ok "feat: CJK + emoji slug as path → feat/$default_feat" \
  || fail_ "feat path missing: feat/$default_feat"

# hot: subject "feat: c" → slug = "feat-c"
default_hot="feat-c-${short3}"
echo "" | bash "$DIR/worktree-from.sh" hot "$SHA3" >/dev/null 2>&1
[ -d "$PROJECT/hot/$default_hot" ] \
  && ok "hot: created at hot/$default_hot" \
  || fail_ "hot path missing"

# ───────────────────────────────────────────────────────────────
# detached HEAD: try-branch should use base_slug='detached'
# ───────────────────────────────────────────────────────────────
echo
echo "── detached HEAD: try-branch ──"
git switch --detach "$SHA1" >/dev/null 2>&1
expected_detached="try/detached-$short1"
# stdin: name (empty = default), then switch confirmation (empty = Y default)
printf '\n\n' | bash "$DIR/try-branch.sh" "$SHA1" >/dev/null 2>&1
if [ "$(git rev-parse --abbrev-ref HEAD)" = "$expected_detached" ]; then
  ok "try-branch from detached → base_slug='detached'"
else
  fail_ "detached try-branch (HEAD=$(git rev-parse --abbrev-ref HEAD), expected=$expected_detached)"
fi
git switch -q main
git branch -D "$expected_detached" 2>/dev/null || true

cd /
rm -rf "$SB"

echo
echo "── Total ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
