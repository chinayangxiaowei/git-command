#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_REWORD_TITLE" \
  "$MSG_REWORD_PURPOSE" \
  "$MSG_REWORD_WHEN" \
  "$MSG_REWORD_CONTRAST"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_REWORD_DIRTY_TREE" >&2
  exit 1
fi

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  printf "$MSG_REWORD_NOT_ANCESTOR_FMT" "$SHA" >&2
  exit 1
fi

echo "$MSG_REWORD_OLD_MSG"
git --no-pager log -1 --format='%B' "$SHA" | sed 's/^/  /'
echo

echo "$MSG_REWORD_NEW_MSG_PROMPT"
new_msg=""
while IFS= read -er line; do
  [[ "$line" == "Q" ]] && break
  [[ "$line" == ":q" ]] && { echo "$MSG_REWORD_CANCELLED"; exit 0; }
  new_msg+="${line}"$'\n'
done

if [[ -z "$new_msg" ]]; then
  echo "$MSG_REWORD_EMPTY_CANCELLED"
  exit 0
fi

tmpdir="$(mktemp -d)"

printf '%s' "$new_msg" > "$tmpdir/msg"
cat > "$tmpdir/seq" <<EOF
#!/bin/sh
sed -i.bak '1s/^pick /reword /' "\$1" && rm -f "\$1.bak"
EOF
chmod +x "$tmpdir/seq"

cat > "$tmpdir/ed" <<EOF
#!/bin/sh
cp "$tmpdir/msg" "\$1"
EOF
chmod +x "$tmpdir/ed"

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
export GIT_EDITOR="$tmpdir/ed"
run_or_abort rebase git rebase -i "${SHA}^"
