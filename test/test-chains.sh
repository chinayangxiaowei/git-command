#!/usr/bin/env bash
# test/test-chains.sh — multi-step workflows users actually run.
# Stresses state transitions across scripts: branch lifecycle, worktree
# lifecycle, stash↔worktree interaction.
set -euo pipefail
export GIT_COMMAND_NO_OPEN=1
export GIT_COMMAND_NO_PAUSE=1

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

pass=0; fail=0
ok()    { pass=$((pass+1)); echo "  ✓ $1"; }
fail_() { fail=$((fail+1)); echo "  ✗ $1"; }

# bare+wt sandbox via init-bare-tree
SB=$(mktemp -d)
cd "$SB"
bash "$DIR/init-bare-tree.sh" project >/dev/null
cd project/main
git config user.email "t@t"
git config user.name "t"
echo a > a.txt && git add a.txt && git commit -qm "fix: a"
echo b > b.txt && git add b.txt && git commit -qm "feat: b"
PROJECT="$SB/project"
SHA1=$(git rev-parse HEAD~1)
SHA2=$(git rev-parse HEAD)

# ───────────────────────────────────────────────────────────────
# A. branch full lifecycle: from → rename → checkout → delete
# ───────────────────────────────────────────────────────────────
echo "── A. branch lifecycle ──"

printf 'lifecycle1\n' | bash "$DIR/branch-from.sh" "$SHA1" >/dev/null 2>&1
[ "$(git rev-parse --abbrev-ref HEAD)" = "lifecycle1" ] \
  && ok "branch-from → HEAD on lifecycle1" \
  || fail_ "branch-from (HEAD=$(git rev-parse --abbrev-ref HEAD))"

# rename has to happen while we're not on the branch (git rename allows it but
# branch-rename script ensures behavior). switch back to main first.
git switch -q main
# Multi-branch case: stdin first = old name, second = new name
git branch placeholder "$SHA1"   # so it's a true multi-branch list
printf 'lifecycle1\nlifecycle2\n' | bash "$DIR/branch-rename.sh" "$SHA1" >/dev/null 2>&1
if git show-ref --verify --quiet refs/heads/lifecycle2 \
   && ! git show-ref --verify --quiet refs/heads/lifecycle1; then
  ok "rename: lifecycle1 → lifecycle2"
else
  fail_ "rename failed"
fi
git branch -D placeholder 2>/dev/null

printf 'lifecycle2\n' | bash "$DIR/branch-checkout.sh" "$SHA1" >/dev/null 2>&1 || true
[ "$(git rev-parse --abbrev-ref HEAD)" = "lifecycle2" ] \
  && ok "checkout: HEAD on lifecycle2" \
  || fail_ "checkout (HEAD=$(git rev-parse --abbrev-ref HEAD))"

git switch -q main
printf 'y\n' | bash "$DIR/branch-delete.sh" "$SHA1" >/dev/null 2>&1
! git show-ref --verify --quiet refs/heads/lifecycle2 \
  && ok "delete: lifecycle2 gone" || fail_ "delete failed"

# ───────────────────────────────────────────────────────────────
# B. worktree lifecycle: create → modify → remove → recreate refused
# ───────────────────────────────────────────────────────────────
echo
echo "── B. worktree lifecycle ──"
short1=$(git rev-parse --short "$SHA1")
expected="try/main-$short1"

bash "$DIR/worktree-from.sh" try "$SHA1" >/dev/null 2>&1
[ -d "$PROJECT/$expected" ] && ok "create: try worktree exists" || fail_ "create"

echo modified > "$PROJECT/$expected/c.txt"
[ -f "$PROJECT/$expected/c.txt" ] && ok "modify: file landed in try worktree" || fail_ "modify"
# Commit inside the worktree so it's clean enough for `git worktree remove`
# (script intentionally refuses dirty/untracked worktrees)
git -C "$PROJECT/$expected" add c.txt
git -C "$PROJECT/$expected" commit -qm "wt commit"

# remove worktree but keep branch
printf '%s\nn\n' "$expected" | bash "$DIR/worktree-remove.sh" try >/dev/null 2>&1 || true
if [ ! -d "$PROJECT/$expected" ] && git show-ref --verify --quiet "refs/heads/$expected"; then
  ok "remove: worktree gone, branch retained"
else
  fail_ "remove (dir=$([ -d $PROJECT/$expected ] && echo yes || echo no), branch=$(git show-ref --verify --quiet refs/heads/$expected && echo yes || echo no))"
fi

# recreating must refuse — branch already exists
out=$(bash "$DIR/worktree-from.sh" try "$SHA1" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(Branch already exists|分支已存在)" \
  && ok "recreate refuses: branch already exists" \
  || fail_ "recreate ec=$ec"

git branch -D "$expected" 2>/dev/null

# ───────────────────────────────────────────────────────────────
# C. stash + worktree-from interaction
#    Dirty changes are stashed, a worktree is created, stash survives,
#    then pop restores the dirty state.
# ───────────────────────────────────────────────────────────────
echo
echo "── C. stash + worktree ──"
echo dirty-line >> a.txt
printf 'my-stash\n' | bash "$DIR/stash-push.sh" >/dev/null 2>&1
git diff --quiet && ok "stash-push: main worktree clean" || fail_ "stash-push didn't clean"

bash "$DIR/worktree-from.sh" review "$SHA2" >/dev/null 2>&1
short2=$(git rev-parse --short "$SHA2")
[ -d "$PROJECT/review/$short2" ] && ok "review worktree created during stash state" \
  || fail_ "review create"

git stash list | grep -q "my-stash" && ok "stash preserved across worktree-from" \
  || fail_ "stash lost"

printf 'y\n' | bash "$DIR/stash-pop.sh" >/dev/null 2>&1
if ! git diff --quiet && grep -q "dirty-line" a.txt; then
  ok "stash-pop restored the dirty change"
else
  fail_ "stash-pop"
fi
git checkout -- a.txt 2>/dev/null || true

cd /
rm -rf "$SB"

echo
echo "── Total ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
