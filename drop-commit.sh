#!/usr/bin/env bash
# drop-commit.sh — remove this commit from history
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_DROP_TITLE" \
  "$MSG_DROP_PURPOSE" \
  "$MSG_DROP_WHEN" \
  "$MSG_DROP_CONTRAST"

print_header "$SHA"
require_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_DROP_DIRTY_TREE" >&2
  exit 1
fi

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  printf "$MSG_DROP_NOT_ANCESTOR_FMT" "$SHA" >&2
  exit 1
fi

if ! git rev-parse --verify --quiet "${SHA}^" >/dev/null 2>&1; then
  printf "$MSG_DROP_ROOT_COMMIT_FMT" "$SHA" >&2
  echo "$MSG_DROP_ROOT_HINT" >&2
  exit 1
fi

SHA_FULL="$(git rev-parse "$SHA")"
SHA_SHORT="$(git rev-parse --short "$SHA")"

echo "$MSG_DROP_WILL_REMOVE"
echo "  $SHA_SHORT  $(git log -1 --format='%s' "$SHA_FULL")"
echo

downstream_count="$(git rev-list --count "${SHA_FULL}..HEAD" 2>/dev/null || echo 0)"
is_head=0
if (( downstream_count > 0 )); then
  printf "$MSG_DROP_DOWNSTREAM_FMT" "$downstream_count"
  git --no-pager log --oneline --reverse "${SHA_FULL}..HEAD" | sed 's/^/  /' | head -10
  echo "$MSG_DROP_DOWNSTREAM_HINT"
else
  is_head=1
  echo "$MSG_DROP_IS_HEAD_NOTE"
fi
echo

confirm "$MSG_DROP_CONFIRM"

if (( is_head )); then
  git reset --hard "${SHA_FULL}^"
  echo
  echo "$MSG_DROP_DONE_HEAD"
  git --no-pager log --oneline -5
  exit 0
fi

tmpdir="$(mktemp -d)"

cat > "$tmpdir/seq" <<'SHELL_EOF'
#!/usr/bin/env bash
set -e
todo="$1"

awk -v drop="$DROP_SHA" '
  BEGIN { found = 0 }
  $1 == "pick" && $2 == drop { found = 1; next }
  { print }
  END {
    if (!found) {
      print "todo rewrite failed: target commit not found in todo (sha=" drop ")" > "/dev/stderr"
      exit 1
    }
  }
' "$todo" > "$todo.tmp"

mv "$todo.tmp" "$todo"
SHELL_EOF
chmod +x "$tmpdir/seq"

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
export DROP_SHA="$SHA_FULL"

run_or_abort rebase git -c core.abbrev=40 rebase -i "${SHA_FULL}^"

echo
echo "$MSG_DROP_DONE_REBASE"
git --no-pager log --oneline -5
