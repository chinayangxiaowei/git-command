#!/usr/bin/env bash
# ============================================================
# edit-commit.sh — edit a commit's metadata / file list
#
# HEAD fast path (target == HEAD):
#   - working tree may be dirty
#   - add/modify/remove files freely, zero downstream conflict risk
#   - direct git commit --amend, no rebase
#
# Old-commit path (target != HEAD):
#   - working tree must be clean
#   - good for: change message, add new file (untracked), remove file
#   - NOT for: modifying existing file contents → use the fixup menu
#     Reason: this script requires a clean tree, so your edits have
#     nowhere to land; staging "+:tracked-file" only stages the
#     "target commit's version of it", a no-op. Use fixup to apply
#     your delta to the old commit.
# ============================================================
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

tmpdir=""  # lib's EXIT trap cleans this

# ============ Shared: prompt for file +/- list and execute ============
do_file_ops() {
  echo
  echo "$MSG_EDIT_COMMIT_FILE_OPS_HEADER"
  echo "$MSG_EDIT_COMMIT_FILE_OPS_ADD"
  echo "$MSG_EDIT_COMMIT_FILE_OPS_REMOVE"
  echo "$MSG_EDIT_COMMIT_FILE_OPS_DONE"
  echo
  while IFS= read -er line; do
    [[ "$line" == "Q" ]] && break
    [[ -z "$line" ]] && continue
    if [[ ! "$line" =~ ^([-+]):(.+)$ ]]; then
      printf "$MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT" "$line"
      continue
    fi
    local op="${BASH_REMATCH[1]}"
    local path="${BASH_REMATCH[2]}"
    case "$op" in
      +)
        if [[ ! -e "$path" ]]; then
          printf "$MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT" "$path"
        elif git add -- "$path" 2>/dev/null; then
          printf "$MSG_EDIT_COMMIT_FILE_ADD_OK_FMT" "$path"
        else
          printf "$MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT" "$path"
        fi
        ;;
      -)
        if git rm --cached -- "$path" >/dev/null 2>&1; then
          printf "$MSG_EDIT_COMMIT_FILE_RM_OK_FMT" "$path"
        else
          printf "$MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT" "$path"
        fi
        ;;
    esac
  done
}

# ============ Shared: ask for new message ============
ask_new_message() {
  echo "$MSG_EDIT_COMMIT_ASK_MSG" >&2
  local msg="" line
  while IFS= read -er line; do
    [[ "$line" == "Q" ]] && break
    msg+="${line}"$'\n'
  done
  printf '%s' "$msg"
}

show_intro "$MSG_EDIT_COMMIT_TITLE" \
  "$MSG_EDIT_COMMIT_HEAD_PATH" \
  "$MSG_EDIT_COMMIT_OLD_PATH" \
  "$MSG_EDIT_COMMIT_NOT_SUITED"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

HEAD_SHA="$(git rev-parse HEAD)"
TARGET_SHA="$(git rev-parse "$SHA")"

# ============================================================
# HEAD fast path
# ============================================================
if [[ "$HEAD_SHA" == "$TARGET_SHA" ]]; then
  echo "$MSG_EDIT_COMMIT_HEAD_HEADER"
  echo "$MSG_EDIT_COMMIT_HEAD_NOTE_TARGET"
  echo "$MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY"
  echo "$MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES"
  echo

  echo "$MSG_EDIT_COMMIT_HEAD_CUR_MSG"
  git --no-pager log -1 --format='%B' | sed 's/^/  /'
  echo

  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "$MSG_EDIT_COMMIT_HEAD_CUR_CHANGES"
    git --no-pager status --short | sed 's/^/  /'
    echo
  fi

  new_msg=""
  read -erp "$MSG_EDIT_COMMIT_HEAD_ASK_MSG" ans
  if [[ "$ans" =~ ^[yY] ]]; then
    new_msg="$(ask_new_message)"
  fi

  read -erp "$MSG_EDIT_COMMIT_HEAD_ASK_FILES" ans
  if [[ "$ans" =~ ^[yY] ]]; then
    do_file_ops
  fi

  have_msg=0
  have_staged=0
  [[ -n "$new_msg" ]] && have_msg=1
  git diff --cached --quiet || have_staged=1

  if (( ! have_msg && ! have_staged )); then
    echo
    echo "$MSG_EDIT_COMMIT_NO_CHANGES"
    exit 0
  fi

  if ! git diff --quiet; then
    echo
    echo "$MSG_EDIT_COMMIT_UNSTAGED_HINT"
  fi

  tmpdir="$(mktemp -d)"

  echo
  if (( have_msg )); then
    msg_file="$tmpdir/msg"
    printf '%s' "$new_msg" > "$msg_file"
    git commit --amend -F "$msg_file" >/dev/null
    if (( have_staged )); then
      echo "$MSG_EDIT_COMMIT_AMEND_MSG_FILES"
    else
      echo "$MSG_EDIT_COMMIT_AMEND_MSG"
    fi
  else
    git commit --amend --no-edit >/dev/null
    echo "$MSG_EDIT_COMMIT_AMEND_FILES"
  fi

  git --no-pager log -1 --oneline
  exit 0
fi

# ============================================================
# Old-commit path (rebase)
# ============================================================
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "$MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK" >&2
  exit 1
fi

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  printf "$MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT" "$SHA" >&2
  exit 1
fi

echo "$MSG_EDIT_COMMIT_OLD_HEADER"
echo "$MSG_EDIT_COMMIT_OLD_NOTE_APPLIES"
echo "$MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES"
echo
confirm "$MSG_EDIT_COMMIT_OLD_CONTINUE"

tmpdir="$(mktemp -d)"

cat > "$tmpdir/seq" <<EOF
#!/bin/sh
sed -i.bak '1s/^pick /edit /' "\$1" && rm -f "\$1.bak"
EOF
chmod +x "$tmpdir/seq"

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
git rebase -i "${SHA}^" || true

gitdir="$(git rev-parse --git-dir)"
if [ ! -d "$gitdir/rebase-merge" ] && [ ! -d "$gitdir/rebase-apply" ]; then
  echo "$MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT" >&2
  exit 1
fi

echo
echo "$MSG_EDIT_COMMIT_OLD_CUR_MSG"
git --no-pager log -1 --format='%B' | sed 's/^/  /'
echo

new_msg=""
read -erp "$MSG_EDIT_COMMIT_OLD_ASK_MSG" ans
if [[ "$ans" =~ ^[yY] ]]; then
  new_msg="$(ask_new_message)"
fi

read -erp "$MSG_EDIT_COMMIT_OLD_ASK_FILES" ans
if [[ "$ans" =~ ^[yY] ]]; then
  do_file_ops
fi

have_msg=0
have_staged=0
[[ -n "$new_msg" ]] && have_msg=1
git diff --cached --quiet || have_staged=1

echo
if (( have_msg )); then
  msg_file="$tmpdir/msg"
  printf '%s' "$new_msg" > "$msg_file"
  git commit --amend -F "$msg_file" >/dev/null
  if (( have_staged )); then
    echo "$MSG_EDIT_COMMIT_AMEND_MSG_FILES"
  else
    echo "$MSG_EDIT_COMMIT_AMEND_MSG"
  fi
elif (( have_staged )); then
  git commit --amend --no-edit >/dev/null
  echo "$MSG_EDIT_COMMIT_AMEND_FILES"
else
  echo "$MSG_EDIT_COMMIT_OLD_NO_CHANGES"
fi

if ! git rebase --continue; then
  echo >&2
  echo "$MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL" >&2
  exit 1
fi

echo "$MSG_EDIT_COMMIT_OLD_REBASE_DONE"
