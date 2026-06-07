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

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files (open every file touched by this commit in Zed)"
MSG_OPEN_FILES_PURPOSE="What:  list files changed by this commit and open them all in Zed (current working version)"
MSG_OPEN_FILES_WHEN="When:  debugging a historical bug; want to see every file involved in that change"
MSG_OPEN_FILES_PREREQ="Needs: zed CLI on PATH; files not in current tree are skipped"
MSG_OPEN_FILES_EMPTY="This commit has no file changes (possibly an empty commit)."
MSG_OPEN_FILES_MISSING="The following files are no longer in the working tree (deleted/renamed), skipping:"
MSG_OPEN_FILES_ALL_GONE="None of the files touched by this commit remain in the working tree."
MSG_OPEN_FILES_OPENING_FMT='Opening %d files in Zed:\n'
MSG_OPEN_FILES_NO_ZED="zed command not found."
MSG_OPEN_FILES_INSTALL_HINT="In Zed: Cmd+Shift+P → 'zed: install cli' to install the zed CLI."

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files (export files at this commit into a folder)"
MSG_EXPORT_FILES_PURPOSE="What:  copy each file changed by this commit (at THIS commit's version) into a folder, preserving paths"
MSG_EXPORT_FILES_WHEN="When:  too many files to open as tabs / take a snapshot of a commit's artifacts / offline diff"
MSG_EXPORT_FILES_CONTRAST="Note:  open-files opens current working version; this one exports the historical version at this commit"
MSG_EXPORT_FILES_EMPTY="This commit has no file changes (possibly an empty commit)."
MSG_EXPORT_FILES_COUNT_FMT='This commit touches %d file(s):\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... and %d more\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='Export directory (relative to repo root, default %s): '
MSG_EXPORT_FILES_DIR_EXISTS_FMT='Directory exists and is non-empty: %s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="Continuing may overwrite same-named files. Continue?"
MSG_EXPORT_FILES_DELETED_HINT="(deleted in this commit; nothing to export)"
MSG_EXPORT_FILES_DONE_FMT='Done: exported %d, skipped %d → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="Note: contents reflect the snapshot at this commit, not the current working version."

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches (export N patch files)"
MSG_EXPORT_PATCHES_PURPOSE="What:  export N commits backward from here as mbox (.patch) or plain diff (.diff)"
MSG_EXPORT_PATCHES_WHEN="When:  email collaboration / back up specific changes / send to others for git am / git apply"
MSG_EXPORT_PATCHES_OUTPUT="Output: chosen directory (default ./patches); history is never modified"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="Format [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply) (default f): "
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='Invalid format: %s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="How many commits backward (default 1): "
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='Invalid count: %s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="Output directory (relative to repo root, default ./patches): "
MSG_EXPORT_PATCHES_FORMAT_LABEL="Format:"
MSG_EXPORT_PATCHES_RANGE_LABEL="Range:"
MSG_EXPORT_PATCHES_OUTPUT_LABEL="Output:"
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(root)"
MSG_EXPORT_PATCHES_CONTINUE="Continue?"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft (soft reset to this commit · changes go to staging)"
MSG_RESET_SOFT_PURPOSE="What:  move HEAD to this commit; in-between commits' changes land in the index (nothing lost)"
MSG_RESET_SOFT_WHEN="When:  want to repack the last N commits (re-split / change message / merge)"
MSG_RESET_SOFT_AFTER="After: git status to inspect the index, then commit a new history"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s is not in the HEAD ancestor chain; soft reset is meaningless.\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s is already HEAD; no reset needed.\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='Current branch: %s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='Will drop these commits (their changes go to the index, HEAD → %s):\n'
MSG_RESET_SOFT_CONFIRM_FMT='Soft reset to %s?'
MSG_RESET_SOFT_DONE="Done. Changes are in the index; check with git status, commit again to re-record."

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard (hard reset to this commit · DESTRUCTIVE)"
MSG_RESET_HARD_PURPOSE="What:  move HEAD to this commit; DISCARD in-between commits AND all working-tree changes"
MSG_RESET_HARD_WHEN="When:  completely roll back to a state and you're sure you want to lose all intermediate changes"
MSG_RESET_HARD_AFTER="After: unrecoverable (unless git reflog within 30 days; requires typing YES in caps)"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s is not in the HEAD ancestor chain; refuse.\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s is already HEAD; no reset needed.\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='Current branch: %s\n'
MSG_RESET_HARD_WILL_DROP="Will drop these commits (unrecoverable except via reflog):"
MSG_RESET_HARD_WT_LOST="Working-tree changes will also be discarded:"
MSG_RESET_HARD_YES_PROMPT_FMT='Type YES (uppercase) to confirm hard reset to %s: '
MSG_RESET_HARD_NO_YES="YES not typed; cancelled."
MSG_RESET_HARD_REFLOG_HINT="Hint: reflog can still recover these commits; within 30 days check git reflog → HEAD@{N}."

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i (interactive rebase up to this commit)"
MSG_REBASE_I_PURPOSE='What:  start git rebase -i SHA^, open $EDITOR for manual todo edit'
MSG_REBASE_I_WHEN="When:  manually reorder/merge/edit/drop multiple commits; complex beyond standard menu coverage"
MSG_REBASE_I_PREREQ="Needs: working tree must be clean; if conflicts arise, handle them manually or rely on the EXIT trap abort"
MSG_REBASE_I_RANGE_FMT='Will start interactive rebase, range: %s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="Working tree has uncommitted changes; commit or stash first."
MSG_REBASE_I_CONTINUE="Continue?"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert (create an inverse commit to undo this one)"
MSG_REVERT_PURPOSE="What:  do not rewrite history; add a new commit on top of HEAD with the inverse of this commit's changes"
MSG_REVERT_WHEN="When:  an already-pushed commit needs to be undone (reset would rewrite public history)"
MSG_REVERT_CONTRAST="Note:  reset rewrites history; revert appends to it. Auto-aborts on conflicts."
MSG_REVERT_DIRTY_TREE="Working tree has uncommitted changes; commit or stash first."
MSG_REVERT_CONFIRM_FMT='Generate an inverse commit on top of HEAD to undo %s?\n'
