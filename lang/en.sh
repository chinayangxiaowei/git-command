#!/usr/bin/env bash
# English message strings for git-command scripts.
# Loaded by lib.sh; do not invoke directly.
# Naming convention: MSG_<SCRIPT>_<KEY>; suffix _FMT for printf templates.
# shellcheck shell=bash

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword (rewrite this commit's message)"
MSG_REWORD_PURPOSE="What:  change only the commit message; file contents and SHA chain stay the same (downstream SHAs will be rewritten)"
MSG_REWORD_WHEN="When:  fix a typo / conform to convention / add an issue ref / tweak the conventional-commit prefix"
MSG_REWORD_CONTRAST="Note:  for HEAD's own message, edit-commit is faster; reword is for older commits"
MSG_REWORD_DIRTY_TREE="Working tree has uncommitted changes; commit or stash first."
MSG_REWORD_NOT_ANCESTOR_FMT='%s is not in the current branch ancestor chain; cannot reword.\n'
MSG_REWORD_OLD_MSG="Old message:"
MSG_REWORD_NEW_MSG_PROMPT="New message (type per line; blank = paragraph break; single 'Q' to submit, ':q' to cancel):"
MSG_REWORD_CANCELLED="Cancelled."
MSG_REWORD_EMPTY_CANCELLED="No input; cancelled."
