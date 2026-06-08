#!/usr/bin/env bash
# Fold "this commit" (arg SHA = source) into another ancestor commit (target).
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_CFIX_TITLE" \
  "$MSG_CFIX_PURPOSE" \
  "$MSG_CFIX_WHEN" \
  "$MSG_CFIX_CONTRAST"

print_header "$SHA"
require_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_CFIX_DIRTY_TREE" >&2
  exit 1
fi

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  echo "$MSG_CFIX_NOT_ANCESTOR_SRC" >&2
  exit 1
fi

echo "$MSG_CFIX_HEADER"
echo "$MSG_CFIX_TARGET_HINT"
echo
read -erp "$MSG_CFIX_TARGET_PROMPT" TARGET_INPUT
TARGET_INPUT="${TARGET_INPUT// /}"
if [[ -z "$TARGET_INPUT" ]]; then
  echo "$MSG_CFIX_NO_INPUT"
  exit_ok
fi

TARGET_FULL="$(git rev-parse --verify --quiet "$TARGET_INPUT" 2>/dev/null || true)"
if [[ -z "$TARGET_FULL" ]]; then
  printf "$MSG_CFIX_INVALID_SHA_FMT" "$TARGET_INPUT" >&2
  exit 1
fi

SRC_FULL="$(git rev-parse "$SHA")"

if [[ "$TARGET_FULL" == "$SRC_FULL" ]]; then
  echo "$MSG_CFIX_SAME_COMMIT" >&2
  exit 1
fi

if ! git merge-base --is-ancestor "$TARGET_FULL" "$SRC_FULL"; then
  printf "$MSG_CFIX_NOT_ANCESTOR_TGT_FMT" "$TARGET_INPUT" >&2
  exit 1
fi

if ! git rev-parse --verify --quiet "${TARGET_FULL}^" >/dev/null 2>&1; then
  printf "$MSG_COMMON_ROOT_COMMIT_FMT" "$TARGET_INPUT" >&2
  echo "$MSG_COMMON_ROOT_HINT" >&2
  exit 1
fi

SRC_SHORT="$(git rev-parse --short "$SRC_FULL")"
TGT_SHORT="$(git rev-parse --short "$TARGET_FULL")"

echo
echo "$MSG_CFIX_PREVIEW"
echo "$MSG_CFIX_SOURCE_LABEL   $SRC_SHORT  $(git log -1 --format='%s' "$SRC_FULL")"
echo "$MSG_CFIX_TARGET_LABEL $TGT_SHORT  $(git log -1 --format='%s' "$TARGET_FULL")"
echo
echo "$MSG_CFIX_RANGE_LABEL"
git --no-pager log --oneline --reverse "${TARGET_FULL}^..HEAD" | sed 's/^/  /'
echo

confirm "$MSG_CFIX_CONTINUE"

tmpdir="$(mktemp -d)"

cat > "$tmpdir/seq" <<'SHELL_EOF'
#!/usr/bin/env bash
set -e
todo="$1"

awk -v src="$SRC_SHA" -v tgt="$TGT_SHA" '
  { lines[++n] = $0 }
  $1 == "pick" && $2 == src {
    src_subj = ""
    for (i=3; i<=NF; i++) src_subj = src_subj (i==3?"":" ") $i
  }

  END {
    inserted = 0
    for (i=1; i<=n; i++) {
      line = lines[i]
      split(line, parts, " ")
      if (parts[1] == "pick" && parts[2] == src) continue
      print line
      if (parts[1] == "pick" && parts[2] == tgt) {
        print "fixup " src " " src_subj
        inserted = 1
      }
    }
    if (!inserted) {
      print "todo rewrite failed: src or tgt not found in todo (src=" src " tgt=" tgt ")" > "/dev/stderr"
      exit 1
    }
  }
' "$todo" > "$todo.tmp"

mv "$todo.tmp" "$todo"
SHELL_EOF
chmod +x "$tmpdir/seq"

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
export SRC_SHA="$SRC_FULL"
export TGT_SHA="$TARGET_FULL"

run_or_abort rebase git -c core.abbrev=40 rebase -i "${TARGET_FULL}^"

echo
echo "$MSG_CFIX_DONE"
git --no-pager log --oneline -5
