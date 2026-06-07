#!/usr/bin/env bash
# English message strings for git-command scripts.
# Loaded by lib.sh; do not invoke directly.
# Naming convention: MSG_<SCRIPT>_<KEY>; suffix _FMT for printf templates.
# shellcheck shell=bash

# ── lib.sh (shared internals) ───────────────────────────────────
MSG_LIB_IN_PROGRESS_FMT='An unfinished %s is in progress. Run "%s" or --continue first.\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s failed; auto-running git %s --abort (workspace restored to pre-op state).\n'
MSG_LIB_NOT_IN_REPO='Not inside a git repository.'
MSG_LIB_NOT_BARE_LAYOUT='Current project is not in bare + worktrees layout; worktree menu disabled.'
MSG_LIB_INIT_HINT='To enable, create a new project with: bash git-command/init-bare-tree.sh <name> [<url>]'
MSG_LIB_MIGRATE_HINT='For existing projects: migrate-to-bare-tree.sh (not implemented yet; migrate manually).'
MSG_LIB_CLEANUP_FMT='Script exited unexpectedly (exit %d); auto-running git %s --abort to roll back.\n'

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
