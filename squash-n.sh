#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_SQUASH_TITLE" \
  "$MSG_SQUASH_PURPOSE" \
  "$MSG_SQUASH_WHEN" \
  "$MSG_SQUASH_PREREQ"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_SQUASH_DIRTY_TREE" >&2
  exit 1
fi

read -erp "$MSG_SQUASH_COUNT_PROMPT" n
n="${n:-2}"
if ! [[ "$n" =~ ^[0-9]+$ ]] || (( n < 2 )); then
  echo "$MSG_SQUASH_MIN_TWO" >&2
  exit 1
fi

total="$(git rev-list --count "$SHA")"
if (( n > total )); then
  printf "$MSG_SQUASH_TOO_MANY_FMT" "$total" "$total" >&2
  exit 1
fi

echo
printf "$MSG_SQUASH_PREVIEW_FMT" "$n"
git --no-pager log --oneline --reverse "${SHA}~${n}..${SHA}"
echo

echo "$MSG_SQUASH_MSG_PROMPT"
new_msg=""
while IFS= read -er line; do
  [[ "$line" == "Q" ]] && break
  [[ "$line" == ":q" ]] && { echo "$MSG_SQUASH_CANCELLED"; exit 0; }
  new_msg+="${line}"$'\n'
done

confirm "$MSG_SQUASH_CONTINUE"

tmpdir="$(mktemp -d)"

cat > "$tmpdir/seq" <<EOF
#!/bin/sh
sed -i.bak '2,${n}s/^pick /squash /' "\$1" && rm -f "\$1.bak"
EOF
chmod +x "$tmpdir/seq"

if [[ -n "$new_msg" ]]; then
  printf '%s' "$new_msg" > "$tmpdir/msg"
  cat > "$tmpdir/ed" <<EOF
#!/bin/sh
cp "$tmpdir/msg" "\$1"
EOF
  chmod +x "$tmpdir/ed"
  export GIT_EDITOR="$tmpdir/ed"
fi

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
run_or_abort rebase git rebase -i "${SHA}~${n}"
