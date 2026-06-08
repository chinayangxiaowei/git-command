#!/usr/bin/env bash
# test/test-history-rewrite.sh — happy-path tests for the 12 high-risk
# scripts that rewrite git history. Each case starts in a fresh sandbox
# to keep state isolated.
#
# Scripts covered:
#   reword (HEAD + old) / edit-commit (HEAD + old) / squash-n /
#   drop-commit (HEAD + non-HEAD) / fixup / commit-fixup-into /
#   rebase-i / reset-soft / reset-hard / cherry-pick / revert /
#   rebase-branch-onto
#
# Conflict / abort paths for cherry-pick & revert already live in
# test-rollback.sh (sections A & B). Here we focus on the success
# path: tree state, message, SHA chain after the operation.

set -euo pipefail
export GIT_COMMAND_NO_OPEN=1
export GIT_COMMAND_NO_PAUSE=1

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

pass=0; fail=0
ok()    { pass=$((pass+1)); echo "  ✓ $1"; }
fail_() { fail=$((fail+1)); echo "  ✗ $1"; }

setup_sb() {
  SB=$(mktemp -d)
  cd "$SB"
  git init -q -b main
  git config user.email "t@t"
  git config user.name "t"
  echo "v1" > a.txt && git add a.txt && git commit -qm "first"
  echo "v2" > b.txt && git add b.txt && git commit -qm "second"
  echo "v3" > c.txt && git add c.txt && git commit -qm "third"
}
teardown_sb() { cd /; rm -rf "${SB:-}"; SB=; }

# ───────────────────────────────────────────────────────────────
# reword
# ───────────────────────────────────────────────────────────────
echo "── reword ──"

setup_sb
SHA=$(git rev-parse HEAD)
printf 'reworded HEAD\nQ\n' | bash "$DIR/reword.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ "$(git log -1 --format='%s')" = "reworded HEAD" ]; then
  ok "reword HEAD: message updated"
else
  fail_ "reword HEAD ec=$ec msg='$(git log -1 --format='%s')'"
fi
teardown_sb

setup_sb
SHA=$(git rev-parse HEAD~1)   # middle commit (root commit has no parent → SHA^ fails)
printf 'reworded middle\nQ\n' | bash "$DIR/reword.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
mid_msg=$(git log -1 --format='%s' HEAD~1)
if [ "$ec" -eq 0 ] && [ "$mid_msg" = "reworded middle" ]; then
  ok "reword middle commit: message updated, downstream replayed"
else
  fail_ "reword middle ec=$ec mid='$mid_msg'"
fi
teardown_sb

setup_sb
echo dirty > a.txt
out=$(printf 'x\nQ\n' | bash "$DIR/reword.sh" "$(git rev-parse HEAD)" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(uncommitted|未提交)" \
  && ok "reword refuses dirty tree" || fail_ "reword dirty ec=$ec"
teardown_sb

# ───────────────────────────────────────────────────────────────
# edit-commit (HEAD fast path + old-commit rebase path)
# ───────────────────────────────────────────────────────────────
echo
echo "── edit-commit ──"

setup_sb
SHA=$(git rev-parse HEAD)
echo extra > extra.txt
# HEAD path: stdin → "y" change message, "edited HEAD" Q, "n" no file ops
printf 'y\nedited HEAD\nQ\nn\n' | bash "$DIR/edit-commit.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ "$(git log -1 --format='%s')" = "edited HEAD" ]; then
  ok "edit-commit HEAD: amend message"
else
  fail_ "edit-commit HEAD ec=$ec msg='$(git log -1 --format='%s')'"
fi
teardown_sb

setup_sb
SHA=$(git rev-parse HEAD~1)   # middle commit (root has no parent → SHA^ fails)
# Old commit path: clean tree, confirm continue, change message, no file ops
printf 'y\ny\nedited middle\nQ\nn\n' | bash "$DIR/edit-commit.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
mid_msg=$(git log -1 --format='%s' HEAD~1)
if [ "$ec" -eq 0 ] && [ "$mid_msg" = "edited middle" ]; then
  ok "edit-commit middle: message updated, downstream replayed"
else
  fail_ "edit-commit middle ec=$ec mid='$mid_msg'"
fi
teardown_sb

# ───────────────────────────────────────────────────────────────
# squash-n
# ───────────────────────────────────────────────────────────────
echo
echo "── squash-n ──"

setup_sb
SHA=$(git rev-parse HEAD)
# Squash 2 commits (HEAD + HEAD~1): n=2, new message, confirm continue
count_before=$(git rev-list --count HEAD)
printf '2\nsquashed 2\nQ\ny\n' | bash "$DIR/squash-n.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
count_after=$(git rev-list --count HEAD)
top_msg=$(git log -1 --format='%s')
if [ "$ec" -eq 0 ] && [ "$count_after" = "$((count_before - 1))" ] && [ "$top_msg" = "squashed 2" ]; then
  ok "squash 2: count $count_before → $count_after, msg='$top_msg'"
else
  fail_ "squash 2 ec=$ec count $count_before→$count_after msg='$top_msg'"
fi
teardown_sb

setup_sb
out=$(printf '1\n' | bash "$DIR/squash-n.sh" "$(git rev-parse HEAD)" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(at least 2|至少 2)" \
  && ok "squash refuses n<2" || fail_ "squash n<2 ec=$ec"
teardown_sb

# ───────────────────────────────────────────────────────────────
# drop-commit (HEAD fast path + non-HEAD rebase path)
# ───────────────────────────────────────────────────────────────
echo
echo "── drop-commit ──"

setup_sb
SHA=$(git rev-parse HEAD)
parent=$(git rev-parse HEAD~1)
printf 'y\n' | bash "$DIR/drop-commit.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
if [ "$ec" -eq 0 ] && [ "$(git rev-parse HEAD)" = "$parent" ] && [ ! -f c.txt ]; then
  ok "drop HEAD: fast path moves HEAD~, c.txt gone"
else
  fail_ "drop HEAD ec=$ec HEAD=$(git rev-parse HEAD)"
fi
teardown_sb

setup_sb
SHA=$(git rev-parse HEAD~1)   # middle commit (second)
count_before=$(git rev-list --count HEAD)
printf 'y\n' | bash "$DIR/drop-commit.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
count_after=$(git rev-list --count HEAD)
# After drop of middle commit, b.txt should be gone
if [ "$ec" -eq 0 ] && [ "$count_after" = "$((count_before - 1))" ] && [ ! -f b.txt ]; then
  ok "drop middle: count $count_before → $count_after, b.txt gone"
else
  fail_ "drop middle ec=$ec count $count_before→$count_after b.txt=$([ -f b.txt ] && echo yes || echo no)"
fi
teardown_sb

# ───────────────────────────────────────────────────────────────
# fixup (working tree → folds into target commit)
# ───────────────────────────────────────────────────────────────
echo
echo "── fixup ──"

setup_sb
SHA=$(git rev-parse HEAD~1)
count_before=$(git rev-list --count HEAD)
# dirty change to fold into target commit
echo extra >> b.txt
# stdin: "Y" auto-add, "Y" confirm
printf 'Y\nY\n' | bash "$DIR/fixup.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
count_after=$(git rev-list --count HEAD)
# Count should stay same (autosquash absorbs fixup), b.txt should contain "extra"
if [ "$ec" -eq 0 ] && [ "$count_after" = "$count_before" ] && grep -q "extra" b.txt; then
  ok "fixup: working change folded into target, count unchanged"
else
  fail_ "fixup ec=$ec count $count_before→$count_after"
fi
teardown_sb

setup_sb
out=$(bash "$DIR/fixup.sh" "$(git rev-parse HEAD)" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qE "(clean.*nothing|没改动可 fixup)" \
  && ok "fixup refuses clean tree" || fail_ "fixup clean ec=$ec"
teardown_sb

# ───────────────────────────────────────────────────────────────
# commit-fixup-into (fold one commit into an ancestor)
# ───────────────────────────────────────────────────────────────
echo
echo "── commit-fixup-into ──"

setup_sb
SRC=$(git rev-parse HEAD)         # third
TGT=$(git rev-parse HEAD~1)       # second
count_before=$(git rev-list --count HEAD)
# stdin: target SHA + "y" confirm
printf '%s\ny\n' "$TGT" | bash "$DIR/commit-fixup-into.sh" "$SRC" >/dev/null 2>&1 && ec=0 || ec=$?
count_after=$(git rev-list --count HEAD)
# Source folded → one fewer commit, but file content preserved (c.txt should still exist via fold)
if [ "$ec" -eq 0 ] && [ "$count_after" = "$((count_before - 1))" ] && [ -f c.txt ]; then
  ok "commit-fixup-into: src folded into ancestor"
else
  fail_ "cfixup ec=$ec count $count_before→$count_after"
fi
teardown_sb

# ───────────────────────────────────────────────────────────────
# rebase-i (just verify it starts and exits cleanly via empty editor)
# ───────────────────────────────────────────────────────────────
echo
echo "── rebase-i ──"

setup_sb
SHA=$(git rev-parse HEAD)
HEAD_before=$(git rev-parse HEAD)
# GIT_SEQUENCE_EDITOR=true keeps the existing todo as-is (no-op rebase)
GIT_SEQUENCE_EDITOR=true printf 'y\n' | bash "$DIR/rebase-i.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
# A no-op rebase may or may not change SHA (depends on git version); just check ec=0
[ "$ec" -eq 0 ] && ok "rebase-i no-op (true editor) exits 0" || fail_ "rebase-i ec=$ec"
teardown_sb

# ───────────────────────────────────────────────────────────────
# reset-soft
# ───────────────────────────────────────────────────────────────
echo
echo "── reset-soft ──"

setup_sb
SHA=$(git rev-parse HEAD~1)
printf 'y\n' | bash "$DIR/reset-soft.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
# After soft reset, HEAD moves to SHA, but c.txt should still exist staged
if [ "$ec" -eq 0 ] && [ "$(git rev-parse HEAD)" = "$SHA" ] && git diff --cached --quiet && ! git diff --cached --name-only | grep -q c.txt; then
  # Hmm soft reset puts changes in INDEX so they ARE cached
  : # fix logic below
fi
# Correct: HEAD = SHA, c.txt is in index (cached), and exists on disk
if [ "$ec" -eq 0 ] && [ "$(git rev-parse HEAD)" = "$SHA" ] && [ -f c.txt ] && git diff --cached --name-only | grep -q c.txt; then
  ok "reset-soft: HEAD~ moved, c.txt staged"
else
  fail_ "reset-soft ec=$ec HEAD-match=$([ $(git rev-parse HEAD) = "$SHA" ] && echo y || echo n)"
fi
teardown_sb

# ───────────────────────────────────────────────────────────────
# reset-hard (requires YES uppercase)
# ───────────────────────────────────────────────────────────────
echo
echo "── reset-hard ──"

setup_sb
SHA=$(git rev-parse HEAD~1)
printf 'YES\n' | bash "$DIR/reset-hard.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
# After hard reset, HEAD = SHA, c.txt should be GONE
if [ "$ec" -eq 0 ] && [ "$(git rev-parse HEAD)" = "$SHA" ] && [ ! -f c.txt ]; then
  ok "reset-hard with YES: HEAD~ moved, c.txt gone"
else
  fail_ "reset-hard ec=$ec HEAD-match=$([ $(git rev-parse HEAD) = "$SHA" ] && echo y || echo n) c.txt=$([ -f c.txt ] && echo yes || echo no)"
fi
teardown_sb

setup_sb
SHA=$(git rev-parse HEAD~1)
HEAD_before=$(git rev-parse HEAD)
out=$(printf 'yes\n' | bash "$DIR/reset-hard.sh" "$SHA" 2>&1) && ec=0 || ec=$?
# User-cancel now exits 0 (it's a user choice, not an error). Just verify
# HEAD did NOT actually move — that's the safety we care about.
if [ "$ec" -eq 0 ] && echo "$out" | grep -qE "(YES not typed|未输入 YES)" \
   && [ "$(git rev-parse HEAD)" = "$HEAD_before" ]; then
  ok "reset-hard refuses lowercase yes (HEAD unchanged)"
else
  fail_ "reset-hard lowercase ec=$ec HEAD_changed=$([ $(git rev-parse HEAD) = $HEAD_before ] && echo no || echo YES)"
fi
teardown_sb

# ───────────────────────────────────────────────────────────────
# cherry-pick (happy path — conflict path lives in test-rollback)
# ───────────────────────────────────────────────────────────────
echo
echo "── cherry-pick ──"

setup_sb
# Branch off from second commit, add a unique file there
git switch -q -c side HEAD~1
echo side > side.txt && git add side.txt && git commit -qm "side commit"
SIDE=$(git rev-parse HEAD)
git switch -q main
count_before=$(git rev-list --count HEAD)
printf 'y\n' | bash "$DIR/cherry-pick.sh" "$SIDE" >/dev/null 2>&1 && ec=0 || ec=$?
count_after=$(git rev-list --count HEAD)
if [ "$ec" -eq 0 ] && [ "$count_after" = "$((count_before + 1))" ] && [ -f side.txt ]; then
  ok "cherry-pick: side commit copied, side.txt exists, count+1"
else
  fail_ "cherry-pick ec=$ec count $count_before→$count_after side.txt=$([ -f side.txt ] && echo y || echo n)"
fi
teardown_sb

# ───────────────────────────────────────────────────────────────
# revert (happy path)
# ───────────────────────────────────────────────────────────────
echo
echo "── revert ──"

setup_sb
SHA=$(git rev-parse HEAD)
count_before=$(git rev-list --count HEAD)
printf 'y\n' | bash "$DIR/revert.sh" "$SHA" >/dev/null 2>&1 && ec=0 || ec=$?
count_after=$(git rev-list --count HEAD)
# c.txt was added by HEAD commit; after revert, c.txt should be gone, count+1
if [ "$ec" -eq 0 ] && [ "$count_after" = "$((count_before + 1))" ] && [ ! -f c.txt ]; then
  ok "revert: inverse commit added, c.txt removed, count+1"
else
  fail_ "revert ec=$ec count $count_before→$count_after c.txt=$([ -f c.txt ] && echo yes || echo no)"
fi
teardown_sb

# ───────────────────────────────────────────────────────────────
# rebase-branch-onto (A onto B)
# ───────────────────────────────────────────────────────────────
echo
echo "── rebase-branch-onto ──"

setup_sb
# Branch off from second, make a unique commit
git switch -q -c feat HEAD~1
echo feat > feat.txt && git add feat.txt && git commit -qm "feat commit"
git switch -q main   # main is now at "third"

# rebase feat onto main: stdin: A=feat, B=main, y
git switch -q main
# need to be on neither so script handles cleanly; on main is fine
printf 'feat\nmain\ny\n' | bash "$DIR/rebase-branch-onto.sh" >/dev/null 2>&1 && ec=0 || ec=$?
# After rebase, feat tip should have a NEW SHA, parent = main HEAD
if [ "$ec" -eq 0 ] && [ "$(git rev-parse feat~1)" = "$(git rev-parse main)" ] && [ -f feat.txt ]; then
  ok "rebase-branch-onto: feat replayed on main"
else
  fail_ "rebase-onto ec=$ec feat~=$(git rev-parse feat~1 2>/dev/null) main=$(git rev-parse main 2>/dev/null)"
fi
teardown_sb

# ───────────────────────────────────────────────────────────────
# Root-commit guard — 6 history-rewriting scripts must refuse cleanly
# (they all dereference SHA^ or TARGET^ which is fatal on the root)
# ───────────────────────────────────────────────────────────────
echo
echo "── root-commit guard ──"

root_pat="(root commit|根 commit|root-commit|корневой commit|racine|raíz|raiz|root commit です|root commit입니다)"

setup_sb
ROOT=$(git rev-parse HEAD~2)
out=$(printf 'x\nQ\n' | bash "$DIR/reword.sh" "$ROOT" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qiE "$root_pat" \
  && ok "reword refuses root commit" \
  || fail_ "reword root ec=$ec out='${out:0:120}'"
teardown_sb

setup_sb
ROOT=$(git rev-parse HEAD~2)
out=$(printf 'y\ny\nx\nQ\nn\n' | bash "$DIR/edit-commit.sh" "$ROOT" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qiE "$root_pat" \
  && ok "edit-commit refuses root (old-path)" \
  || fail_ "edit-commit root ec=$ec out='${out:0:120}'"
teardown_sb

setup_sb
HEAD_SHA=$(git rev-parse HEAD)
out=$(printf '3\nQ\ny\n' | bash "$DIR/squash-n.sh" "$HEAD_SHA" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qiE "(ancestor|祖先|Vorfahr|ancêtre|ancestro|предок)" \
  && ok "squash-n refuses n>=total (would include root)" \
  || fail_ "squash-n n>=total ec=$ec out='${out:0:120}'"
teardown_sb

setup_sb
SRC=$(git rev-parse HEAD)
ROOT=$(git rev-parse HEAD~2)
out=$(printf '%s\ny\n' "$ROOT" | bash "$DIR/commit-fixup-into.sh" "$SRC" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qiE "$root_pat" \
  && ok "commit-fixup-into refuses root target" \
  || fail_ "cfix root ec=$ec out='${out:0:120}'"
teardown_sb

setup_sb
ROOT=$(git rev-parse HEAD~2)
out=$(printf 'y\n' | bash "$DIR/rebase-i.sh" "$ROOT" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qiE "$root_pat" \
  && ok "rebase-i refuses root commit" \
  || fail_ "rebase-i root ec=$ec out='${out:0:120}'"
teardown_sb

setup_sb
ROOT=$(git rev-parse HEAD~2)
out=$(printf 'y\n' | bash "$DIR/drop-commit.sh" "$ROOT" 2>&1) && ec=0 || ec=$?
[ "$ec" -ne 0 ] && echo "$out" | grep -qiE "$root_pat" \
  && ok "drop-commit refuses root commit" \
  || fail_ "drop-commit root ec=$ec out='${out:0:120}'"
teardown_sb

echo
echo "── Total ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
