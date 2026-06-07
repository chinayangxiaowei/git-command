#!/usr/bin/env bash
# test/test-rollback.sh — exercise lib.sh safety guarantees:
#   - ensure_clean_state refuses to start during rebase/cherry-pick/revert/merge
#   - run_or_abort calls --abort on command failure
#   - _lib_cleanup_on_exit calls --abort when rc != 0 and a rebase-like state is present
#   - _GIT_CMD_DONE=1 short-circuits the EXIT trap (no spurious abort during wait)
#
# These are the load-bearing safety claims advertised in README; if they
# regress silently a future user could lose work.

set -euo pipefail
export GIT_COMMAND_NO_OPEN=1
export GIT_COMMAND_NO_PAUSE=1

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

pass=0; fail=0
ok()    { pass=$((pass+1)); echo "  ✓ $1"; }
fail_() { fail=$((fail+1)); echo "  ✗ $1"; }

# ───────────────────────────────────────────────────────────────
# Sandbox — a plain git repo is enough for rollback semantics
# (cherry-pick / revert / rebase don't need bare+wt layout)
# ───────────────────────────────────────────────────────────────
SB=$(mktemp -d)
cd "$SB"
git init -q -b main
git config user.email "t@t"
git config user.name "t"
echo "v1" > a.txt && git add a.txt && git commit -qm "init"

# Build two branches with a conflicting change to the same line
git switch -q -c branch-a
echo "vA" > a.txt && git commit -qam "A: vA"
SHA_A=$(git rev-parse HEAD)

git switch -q main
git switch -q -c branch-b
echo "vB" > a.txt && git commit -qam "B: vB"
SHA_B=$(git rev-parse HEAD)

git switch -q branch-a   # now on A; cherry-picking B will conflict
SHA_A_TIP=$(git rev-parse HEAD)
GDIR=$(git rev-parse --git-dir)

# ───────────────────────────────────────────────────────────────
# A. cherry-pick conflict → script auto-aborts, tree restored
# ───────────────────────────────────────────────────────────────
echo
echo "── A. cherry-pick conflict auto-abort ──"
out=$(printf 'y\n' | bash "$DIR/cherry-pick.sh" "$SHA_B" 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] \
   && [ "$(git rev-parse HEAD)" = "$SHA_A_TIP" ] \
   && [ ! -f "$GDIR/CHERRY_PICK_HEAD" ] \
   && [ "$(cat a.txt)" = "vA" ] \
   && git diff --quiet && git diff --cached --quiet; then
  ok "cherry-pick conflict → HEAD/file/index restored, no CHERRY_PICK_HEAD"
else
  fail_ "cherry-pick: ec=$ec HEAD=$(git rev-parse HEAD) file='$(cat a.txt)' CHERRY_PICK_HEAD=$([ -f $GDIR/CHERRY_PICK_HEAD ] && echo yes || echo no)"
fi

# ───────────────────────────────────────────────────────────────
# B. revert conflict → also auto-aborts
# ───────────────────────────────────────────────────────────────
echo
echo "── B. revert conflict auto-abort ──"
# Make branch-a have 2 commits so we can revert the middle one and conflict
git switch -q branch-a
echo "vA2" > a.txt && git commit -qam "A: vA2"
SHA_A_v2=$(git rev-parse HEAD)
SHA_A_v1=$(git rev-parse HEAD~1)
# Revert vA (HEAD~1) — would need to undo "vA" → back to "v1", but tip is "vA2" so conflict
out=$(printf 'y\n' | bash "$DIR/revert.sh" "$SHA_A_v1" 2>&1) && ec=0 || ec=$?
if [ "$ec" -ne 0 ] \
   && [ "$(git rev-parse HEAD)" = "$SHA_A_v2" ] \
   && [ ! -f "$GDIR/REVERT_HEAD" ] \
   && [ "$(cat a.txt)" = "vA2" ]; then
  ok "revert conflict → HEAD/file/REVERT_HEAD restored"
else
  fail_ "revert: ec=$ec HEAD=$(git rev-parse HEAD) file='$(cat a.txt)' REVERT_HEAD=$([ -f $GDIR/REVERT_HEAD ] && echo yes || echo no)"
fi

# ───────────────────────────────────────────────────────────────
# C. ensure_clean_state — refuses to start during rebase
# ───────────────────────────────────────────────────────────────
echo
echo "── C. ensure_clean_state refuses mid-op ──"
mkdir -p "$GDIR/rebase-merge"; touch "$GDIR/rebase-merge/orig-head"
out=$(bash "$DIR/cherry-pick.sh" "$SHA_B" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(unfinished|未完成的)" \
  && ok "cherry-pick refuses during rebase" \
  || fail_ "rebase-not-refused ec=$ec"
rm -rf "$GDIR/rebase-merge"

# Mid cherry-pick
echo "$SHA_B" > "$GDIR/CHERRY_PICK_HEAD"
out=$(bash "$DIR/cherry-pick.sh" "$SHA_B" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(unfinished|未完成的)" \
  && ok "cherry-pick refuses during another cherry-pick" \
  || fail_ "cherry-pick-not-refused ec=$ec"
rm -f "$GDIR/CHERRY_PICK_HEAD"

# Mid revert
echo "$SHA_B" > "$GDIR/REVERT_HEAD"
out=$(bash "$DIR/revert.sh" "$SHA_B" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(unfinished|未完成的)" \
  && ok "revert refuses during another revert" \
  || fail_ "revert-not-refused ec=$ec"
rm -f "$GDIR/REVERT_HEAD"

# Mid merge
echo "$SHA_B" > "$GDIR/MERGE_HEAD"
out=$(bash "$DIR/cherry-pick.sh" "$SHA_B" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(unfinished|未完成的)" \
  && ok "cherry-pick refuses during merge" \
  || fail_ "merge-not-refused ec=$ec"
rm -f "$GDIR/MERGE_HEAD"

# ───────────────────────────────────────────────────────────────
# D. _GIT_CMD_DONE=1 short-circuit (rc!=0 + rebase state → still no abort)
# ───────────────────────────────────────────────────────────────
echo
echo "── D. _GIT_CMD_DONE short-circuits cleanup ──"
mkdir -p "$GDIR/rebase-merge"; touch "$GDIR/rebase-merge/orig-head"
out=$( (
  # shellcheck source=/dev/null
  source "$DIR/lib.sh"
  _GIT_CMD_DONE=1
  ( exit 130 ); _lib_cleanup_on_exit
) 2>&1 )
if [ -z "$out" ] && [ -d "$GDIR/rebase-merge" ]; then
  ok "flag → silent short-circuit, rebase state untouched"
else
  fail_ "expected silent skip, got output='$out' rebase-merge=$([ -d $GDIR/rebase-merge ] && echo yes || echo no)"
fi
rm -rf "$GDIR/rebase-merge"

# Without the flag: rc!=0 + rebase state → cleanup must announce and attempt abort
echo
echo "── E. without flag → cleanup announces + attempts abort ──"
mkdir -p "$GDIR/rebase-merge"; touch "$GDIR/rebase-merge/orig-head"
out=$( (
  # shellcheck source=/dev/null
  source "$DIR/lib.sh"
  ( exit 130 ); _lib_cleanup_on_exit
) 2>&1 )
if echo "$out" | grep -qE "(auto-running|自动)"; then
  ok "no flag → announces abort attempt"
else
  fail_ "expected abort message, got='$out'"
fi
rm -rf "$GDIR/rebase-merge" 2>/dev/null || true

# ───────────────────────────────────────────────────────────────
# F. rc=0 + no rebase state → no cleanup noise
# ───────────────────────────────────────────────────────────────
echo
echo "── F. rc=0 trap path silent ──"
out=$( (
  # shellcheck source=/dev/null
  source "$DIR/lib.sh"
  ( exit 0 ); _lib_cleanup_on_exit
) 2>&1 </dev/null )   # </dev/null so wait_to_close auto-skips (not a tty)
if [ -z "$out" ]; then
  ok "rc=0 + no tty → silent"
else
  fail_ "expected silent, got='$out'"
fi

# ───────────────────────────────────────────────────────────────
# G. tmpdir cleanup — script-created mktemp dir is removed on EXIT
# ───────────────────────────────────────────────────────────────
echo
echo "── G. tmpdir auto-cleanup ──"
marker=$( (
  # shellcheck source=/dev/null
  source "$DIR/lib.sh"
  tmpdir=$(mktemp -d)
  echo "$tmpdir"
) )
if [ ! -d "$marker" ]; then
  ok "tmpdir removed after subshell exit"
else
  fail_ "tmpdir leaked: $marker"
  rm -rf "$marker"
fi

cd /
rm -rf "$SB"

echo
echo "── Total ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
