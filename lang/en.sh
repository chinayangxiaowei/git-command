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

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick (copy this commit to the top of current branch)"
MSG_CHERRY_PICK_PURPOSE="What:  copy this commit's changes onto the current branch tip as a new commit (new SHA)"
MSG_CHERRY_PICK_WHEN="When:  carry a hotfix across branches / grab a single commit from a coworker / recover via reflog"
MSG_CHERRY_PICK_NOTE="Note:  source commit is not deleted; same-branch is meaningless; auto-aborts on conflict"
MSG_CHERRY_PICK_CURRENT_FMT='Current branch: %s\n'
MSG_CHERRY_PICK_DIRTY_TREE="Working tree has uncommitted changes; commit or stash first."
MSG_CHERRY_PICK_CONFIRM_FMT='Cherry-pick %s onto %s?'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from (create a new branch from this commit)"
MSG_BRANCH_FROM_PURPOSE="What:  create a new branch at this commit and switch to it"
MSG_BRANCH_FROM_WHEN="When:  start a new line of work from an old commit / keep a named ref to a specific state"
MSG_BRANCH_FROM_CONTRAST="Note:  for throwaway experiments use try-branch (auto try/ prefix + cleanup hint)"
MSG_BRANCH_FROM_NAME_PROMPT="New branch name (based on this commit): "
MSG_BRANCH_FROM_NO_NAME="No branch name given; cancelled."

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch (throwaway branch from this commit)"
MSG_TRY_BRANCH_PURPOSE="What:  create a branch named try/<base-slug>-<sha> from this commit, switch immediately"
MSG_TRY_BRANCH_WHEN="When:  experiment without polluting current branch / inspect the state at an old commit"
MSG_TRY_BRANCH_HINT="Hint:  on exit, prints 'return to original' + 'delete this branch' commands as reminders"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # was detached; consult reflog"
MSG_TRY_BRANCH_FROM_FMT='Original branch: %s\nStart point:     %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='New branch name (Enter = %s): '
MSG_TRY_BRANCH_EXISTS_FMT='Branch already exists: %s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="Switch to it after creating? [Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='Created %s (not switched)\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="When done, clean up with:"
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  return to original: %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  delete this branch: git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push (stash current changes with a name)"
MSG_STASH_PUSH_PURPOSE="What:  stash tracked changes with a label, leaving the working tree clean"
MSG_STASH_PUSH_WHEN="When:  about to switch branches with WIP / set work aside briefly / pre-clean before reset"
MSG_STASH_PUSH_NOTE="Note:  -u is NOT used; untracked files stay in the working tree (avoids spurious Git Graph snapshot nodes)"
MSG_STASH_PUSH_CLEAN="Working tree is clean; nothing to stash."
MSG_STASH_PUSH_WILL_STASH="Will stash the following changes:"
MSG_STASH_PUSH_NAME_PROMPT="Pick a name (helps you find it later): "
MSG_STASH_PUSH_NO_NAME="No name given; cancelled."
MSG_STASH_PUSH_DONE_HINT="Done. View: git stash list, or use the menu 'Pop most recent stash'."
MSG_STASH_PUSH_UNTRACKED_NOTE="Note: untracked files were NOT stashed and remain in the working tree."

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop (apply the most recent stash to the working tree)"
MSG_STASH_POP_PURPOSE="What:  apply stash@{0} to the working tree; on success, the stash is auto-dropped"
MSG_STASH_POP_WHEN="When:  earlier stashed changes need to come back"
MSG_STASH_POP_NOTE="Note:  on conflict the stash is NOT auto-dropped; resolve conflicts then run git stash drop"
MSG_STASH_POP_EMPTY="No stash available to pop."
MSG_STASH_POP_LIST_HEADER="Recent stashes:"
MSG_STASH_POP_PREVIEW_HEADER="stash@{0} preview:"
MSG_STASH_POP_CONFIRM="Pop stash@{0} into the current working tree?"
MSG_STASH_POP_CONFLICT="Pop hit conflicts — the stash is preserved (not auto-dropped)."
MSG_STASH_POP_CONFLICT_HINT="Resolve conflicts + git add, then run  git stash drop  to discard it."

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete (delete local branches pointing at this commit)"
MSG_BRANCH_DELETE_PURPOSE="What:  delete a local branch (optionally also the remote one)"
MSG_BRANCH_DELETE_WHEN="When:  tidy up merged/throwaway branches; bulk-prune try/* feat/* etc."
MSG_BRANCH_DELETE_NOTE="Note:  uses git branch -D (force delete; ignores merged status)"
MSG_BRANCH_DELETE_NONE="No local branches at this commit to delete."
MSG_BRANCH_DELETE_ONE_FMT='Sole branch at this commit: %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="Local branches at this commit:"
MSG_BRANCH_DELETE_SELECT_PROMPT="Pick one (branch name or number): "
MSG_BRANCH_DELETE_NO_INPUT="No input; cancelled."
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="Branch '%s' is not in the at-this-commit list.\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="Cannot delete the currently checked-out branch '%s'.\n"
MSG_BRANCH_DELETE_CURRENT_HINT="Switch to another branch first: git switch <other-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="Delete local branch '%s'?"
MSG_BRANCH_DELETE_LOCAL_DONE="Local branch deleted."
MSG_BRANCH_DELETE_NO_REMOTE="(no remote configured; skipping remote)"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="(branch not present on remote [%s]; skipping)"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="Also delete from remote [%s]? [y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="Remote branch deleted."

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit (edit this commit's metadata / file list)"
MSG_EDIT_COMMIT_HEAD_PATH="HEAD path:  working tree may be dirty; direct amend; change message / add / remove / modify files"
MSG_EDIT_COMMIT_OLD_PATH="Old commit: working tree must be clean; supports message / add (untracked) / remove files"
MSG_EDIT_COMMIT_NOT_SUITED="Not suited (old commit): modifying existing files' contents → use the fixup menu (see header comment for why)"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="One operation per line, finish with 'Q' on its own line:"
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:path/to/file    git add (add / update / stage any change)"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:path/to/file    remove from this commit (disk preserved, git rm --cached)"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                 done"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  skip format error: %s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  skip +%s  (file does not exist)\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  add  %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  skip +%s  (git add failed)\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  rm   %s  (removed from commit, kept on disk)\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  skip -%s  (not in this commit)\n'
MSG_EDIT_COMMIT_ASK_MSG="New message (per line; single 'Q' to submit; just Q = keep unchanged):"
MSG_EDIT_COMMIT_HEAD_HEADER="─── HEAD fast path ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="Target is HEAD, no rebase needed:"
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · working tree may be dirty (changes become amend candidates)"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · add / modify / remove files freely; no downstream conflict risk"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── current message ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── current working/staged changes ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="Change the message? [y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="Change files (add/remove/modify)? [y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="(no changes; not amending; exit.)"
MSG_EDIT_COMMIT_UNSTAGED_HINT="Note: working tree still has unstaged changes; amend will NOT include them."
MSG_EDIT_COMMIT_AMEND_MSG_FILES="Amended (new message + file changes)"
MSG_EDIT_COMMIT_AMEND_MSG="Amended (new message)"
MSG_EDIT_COMMIT_AMEND_FILES="Amended (file changes)"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='Working tree has uncommitted changes.

If you want to merge those changes into this commit → use the menu:
  "Fold working/staged changes into this commit (fixup+autosquash)"

If you really want this menu (change message / add new files / remove files), commit or stash first.'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s is not in the current branch ancestor chain.\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── Old-commit path (rebase) ───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="Applies to: message / add new files (untracked) / remove files"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="Does NOT apply to: modifying existing file contents (use the fixup menu)"
MSG_EDIT_COMMIT_OLD_CONTINUE="Continue?"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="rebase did not enter edit state."
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── current commit message ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="Change message? [y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="Change files (add/remove)? [y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="(no changes; wrapping up)"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue failed (likely a downstream modify/delete conflict against a file you just removed)."
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase complete"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n (squash N commits forward from this commit)"
MSG_SQUASH_PURPOSE="What:  squash this commit and N-1 ancestors into one; downstream commits replay on top"
MSG_SQUASH_WHEN="When:  tidy WIP commits / compress noise / merge several related small commits"
MSG_SQUASH_PREREQ="Needs: working tree must be clean; downstream SHAs change; auto-aborts on conflict"
MSG_SQUASH_DIRTY_TREE="Working tree has uncommitted changes; commit or stash first."
MSG_SQUASH_COUNT_PROMPT="How many to squash (including this commit, default 2): "
MSG_SQUASH_MIN_TWO="Need at least 2 commits to make squash meaningful."
MSG_SQUASH_TOO_MANY_FMT='This commit has only %d ancestor(s) including itself; at most %d.\n'
MSG_SQUASH_PREVIEW_FMT='Will squash these %d commit(s) (old → new):\n'
MSG_SQUASH_MSG_PROMPT="New commit message (per line; single Q to submit; bare Q = open editor with default concatenation; :q to cancel):"
MSG_SQUASH_CANCELLED="Cancelled."
MSG_SQUASH_CONTINUE="Continue?"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit (delete this commit from history)"
MSG_DROP_PURPOSE="What:  remove this commit from the branch history; downstream commits replay (new SHAs)"
MSG_DROP_WHEN="When:  accidental commit (passwords / debug code) / useless WIP / duplicate / experiment to wipe"
MSG_DROP_CONTRAST="Note:  revert adds an inverse commit (keeps history); drop truly removes (rewrites history)"
MSG_DROP_DIRTY_TREE="Working tree has uncommitted changes; commit or stash first."
MSG_DROP_NOT_ANCESTOR_FMT='%s is not in the current branch ancestor chain.\n'
MSG_DROP_ROOT_COMMIT_FMT='%s is the root commit, has no parent; rebase cannot remove it.\n'
MSG_DROP_ROOT_HINT="Truly removing the root commit requires git update-ref etc.; handle manually."
MSG_DROP_WILL_REMOVE="Will remove:"
MSG_DROP_DOWNSTREAM_FMT='%d downstream commit(s) will replay (SHAs change):\n'
MSG_DROP_DOWNSTREAM_HINT="  (if downstream changes depend on this commit → auto-abort on conflict)"
MSG_DROP_IS_HEAD_NOTE="(this commit is HEAD → fast path via git reset --hard HEAD~; no rebase)"
MSG_DROP_CONFIRM="Confirm removal?"
MSG_DROP_DONE_HEAD="Done. HEAD moved to the previous commit."
MSG_DROP_DONE_REBASE="Done. The commit has been removed from history."

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup (fold working-tree changes into this commit)"
MSG_FIXUP_PURPOSE="What:  create a fixup commit + autosquash, merging working-tree changes into this commit"
MSG_FIXUP_WHEN="When:  you've edited files and want them to land on an old commit (very common); avoid polluting history"
MSG_FIXUP_PREREQ="Needs: working / staging tree must have changes; auto-aborts on conflict"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s is not in the current branch ancestor chain.\n'
MSG_FIXUP_NO_CHANGES="Working tree is clean; nothing to fold."
MSG_FIXUP_WORKFLOW_HINT="Workflow: edit files → use this menu → pick the target commit → auto fixup + autosquash."
MSG_FIXUP_WILL_FOLD="Changes to fold into this commit:"
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="Index already has content; also include unstaged changes? [y/N] "
MSG_FIXUP_ASK_ADD_ALL="Index is empty; git add -A everything then fixup? [Y/n] "
MSG_FIXUP_EMPTY_INDEX="Index is empty; nothing to fixup; cancelled."
MSG_FIXUP_TARGET_FMT='Target: %s  "%s"\n'
MSG_FIXUP_CONFIRM="Confirm fixup + autosquash? [Y/n] "
MSG_FIXUP_CANCELLED="Cancelled; index state preserved."
MSG_FIXUP_CREATED="  + fixup commit created"
MSG_FIXUP_DONE_FMT='Done. Changes merged into %s (SHA updated after autosquash).\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup (fold this commit into an ancestor)"
MSG_CFIX_PURPOSE="What:  take this commit and apply it as a fixup onto an earlier commit on the same branch"
MSG_CFIX_WHEN="When:  a fix on HEAD really belongs to an earlier commit; move it home"
MSG_CFIX_CONTRAST="Note:  fixup.sh uses working-tree changes; this menu uses an existing commit"
MSG_CFIX_DIRTY_TREE="Working tree has uncommitted changes; commit or stash first."
MSG_CFIX_NOT_ANCESTOR_SRC="Source commit is not in the current branch ancestor chain."
MSG_CFIX_HEADER="Fold this commit (fixup) into another commit."
MSG_CFIX_TARGET_HINT="Target must be an ancestor of the source (earlier in history). Hint: copy the target SHA from the Zed Graph."
MSG_CFIX_TARGET_PROMPT="Target commit SHA (short or long): "
MSG_CFIX_NO_INPUT="No input; cancelled."
MSG_CFIX_INVALID_SHA_FMT='Invalid SHA: %s\n'
MSG_CFIX_SAME_COMMIT="Target and source are the same; meaningless."
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s is not an ancestor of the source commit (cannot fixup onto it).\n'
MSG_CFIX_PREVIEW="─── preview ───"
MSG_CFIX_SOURCE_LABEL="Source:"
MSG_CFIX_TARGET_LABEL="Target:"
MSG_CFIX_RANGE_LABEL="rebase range (old → new):"
MSG_CFIX_CONTINUE="Continue?"
MSG_CFIX_DONE="Done. Source folded into target (target commit's SHA updated)."

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto (rebase branch A onto branch B)"
MSG_RBO_PURPOSE="What:  git switch A && git rebase B; A's exclusive commits replay onto B's tip"
MSG_RBO_WHEN="When:  A is a feature branch, B is main/develop; bring A up to B's latest"
MSG_RBO_NOTE="Note:  A's commits get rewritten (new SHAs); auto-aborts on conflict"
MSG_RBO_DIRTY_TREE="Working tree has uncommitted changes; commit or stash first."
MSG_RBO_LOCAL_BRANCHES="Local branches:"
MSG_RBO_A_PROMPT_FMT='Branch A (to be rebased; Enter = current %s): '
MSG_RBO_DETACHED_ERR="Currently on detached HEAD; you must name branch A explicitly."
MSG_RBO_NO_LOCAL_FMT='No local branch named: %s\n'
MSG_RBO_B_PROMPT="Branch B (rebase target; local / remote / tag): "
MSG_RBO_NO_INPUT="No input; cancelled."
MSG_RBO_INVALID_REF_FMT='Invalid target ref: %s\n'
MSG_RBO_SAME="A and B point at the same commit; nothing to rebase."
MSG_RBO_PREVIEW="─── Preview ───"
MSG_RBO_NO_EXCLUSIVE="A has no commits beyond B (A is an ancestor of B, or the same)."
MSG_RBO_FF_OR_NOOP="rebase will be a fast-forward or a no-op."
MSG_RBO_REPLAY_FMT='A commits to replay (%d):\n'
MSG_RBO_CONFIRM_FMT='Proceed: git switch %s && git rebase %s ?'
MSG_RBO_SWITCHING_FMT='Switching to %s...\n'
MSG_RBO_DONE="Done."

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag (tag this commit)"
MSG_TAG_PURPOSE="What:  create a lightweight or annotated tag pointing at this commit; optionally push to remote"
MSG_TAG_WHEN="When:  release point / milestone / a stable named reference to a commit"
MSG_TAG_CONTRAST="Note:  annotated carries message+author+time (recommended for releases); lightweight is just a ref"
MSG_TAG_NAME_PROMPT="Tag name (e.g. v1.0.0 / release-2024-01): "
MSG_TAG_NO_INPUT="No input; cancelled."
MSG_TAG_EXISTS_FMT='Tag already exists: %s\n'
MSG_TAG_KIND_PROMPT="annotated (with message) or lightweight? [a]/l (default a): "
MSG_TAG_MSG_PROMPT="Tag message (Enter = use tag name): "
MSG_TAG_CREATED_FMT='Created tag: %s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='Push to remote [%s]? [y/N] '
MSG_TAG_NO_REMOTE="(no remote configured; skipping push)"
MSG_TAG_REFRESH_HINT="Note: Zed Git Graph doesn't watch tag changes; refresh manually (Cmd+Shift+P → reload window, or wait until next commit)."

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete (delete a tag)"
MSG_TAG_DELETE_PURPOSE="What:  delete a local tag; optionally also delete on remote"
MSG_TAG_DELETE_WHEN="When:  bad tag / re-release / cleanup"
MSG_TAG_DELETE_NOTE="Note:  deleting a pushed remote tag affects others; local + remote are asked separately"
MSG_TAG_DELETE_AT_HEADER="Tags on this commit:"
MSG_TAG_DELETE_NONE="  (none)"
MSG_TAG_DELETE_NAME_PROMPT="Tag name to delete (may be on another commit): "
MSG_TAG_DELETE_NO_INPUT="No input; cancelled."
MSG_TAG_DELETE_NOT_EXIST_FMT='Tag does not exist: %s\n'
MSG_TAG_DELETE_ANNOTATED="(annotated tag)"
MSG_TAG_DELETE_PREVIEW_FMT="tag '%s' → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="Delete local tag '%s'?"
MSG_TAG_DELETE_LOCAL_DONE="Local tag deleted."
MSG_TAG_DELETE_NO_REMOTE="(no remote configured; skipping remote)"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="(no such tag on remote [%s]; skipping)\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="Also delete from remote [%s]? [y/N] "
MSG_TAG_DELETE_REMOTE_DONE="Remote tag deleted."

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="What:  check out this commit in a new worktree, grouped by purpose"
MSG_WT_FROM_NOTE_FMT='purpose: %s'
MSG_WT_FROM_PATH_EXISTS_FMT='Path already exists: %s\n'
MSG_WT_FROM_PATH_HINT="Hint: run  git worktree list  to inspect existing worktrees"
MSG_WT_FROM_BRANCH_EXISTS_FMT='Branch already exists: %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree created: %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  branch: %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  cleanup: git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  cleanup: git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='Branch name (Enter = %s): '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="What:  list worktrees under [%s] and let the user paste a name to delete"
MSG_WT_RM_USAGE_FMT="How:   review the list, paste the name (including %s/ prefix), then confirm"
MSG_WT_RM_EMPTY_FMT='[%s] has no worktree to remove.\n'
MSG_WT_RM_LIST_HEADER_FMT='[%s] worktrees:\n'
MSG_WT_RM_NAME_PROMPT="Paste the worktree name to delete (copy a full line from above): "
MSG_WT_RM_NO_INPUT="No input; cancelled."
MSG_WT_RM_NOT_IN_LIST_FMT="'%s' is not in the [%s] worktree list.\n"
MSG_WT_RM_REMOVING_FMT='Removing: %s\n'
MSG_WT_RM_DONE="✓ worktree removed."
MSG_WT_RM_REVIEW_NO_BRANCH="(review is detached; no branch to clean up)"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="Also delete local branch '%s'? [y/N] "
MSG_WT_RM_BRANCH_DONE="✓ Local branch deleted."
MSG_WT_RM_BRANCH_ABSENT_FMT="(branch '%s' does not exist; possibly already removed by git worktree remove)\n"

# ── branch-checkout.sh ──────────────────────────────────────────
MSG_BRANCH_CHECKOUT_TITLE="branch-checkout (switch to a branch pointing at this commit)"
MSG_BRANCH_CHECKOUT_PURPOSE="What:  switch HEAD to a local branch that points at this commit"
MSG_BRANCH_CHECKOUT_WHEN="When:  move to an existing branch from the Git Graph instead of copying its name to the terminal"
MSG_BRANCH_CHECKOUT_NOTE="Note:  requires a clean working tree; will not switch if already on the chosen branch"
MSG_BRANCH_CHECKOUT_DIRTY_TREE="Working tree has uncommitted changes; commit or stash first."
MSG_BRANCH_CHECKOUT_NONE="No local branches at this commit to check out."
MSG_BRANCH_CHECKOUT_ONE_FMT='Sole branch at this commit: %s\n'
MSG_BRANCH_CHECKOUT_LIST_HEADER="Local branches at this commit:"
MSG_BRANCH_CHECKOUT_SELECT_PROMPT="Pick one (branch name or number): "
MSG_BRANCH_CHECKOUT_NO_INPUT="No input; cancelled."
MSG_BRANCH_CHECKOUT_NOT_IN_LIST_FMT="Branch '%s' is not in the at-this-commit list.\n"
MSG_BRANCH_CHECKOUT_ALREADY_FMT='Already on %s; nothing to do.\n'

# ── branch-rename.sh ────────────────────────────────────────────
MSG_BRANCH_RENAME_TITLE="branch-rename (rename a branch pointing at this commit)"
MSG_BRANCH_RENAME_PURPOSE="What:  rename a local branch; optionally re-push it on the remote (delete old name, push new)"
MSG_BRANCH_RENAME_WHEN="When:  fix a typo / re-purpose a try/* / standardize a name"
MSG_BRANCH_RENAME_NOTE="Note:  remote rename is two operations (push new + delete old); coordinate with collaborators"
MSG_BRANCH_RENAME_NONE="No local branches at this commit to rename."
MSG_BRANCH_RENAME_ONE_FMT='Sole branch at this commit: %s\n'
MSG_BRANCH_RENAME_LIST_HEADER="Local branches at this commit:"
MSG_BRANCH_RENAME_SELECT_PROMPT="Pick one to rename (branch name or number): "
MSG_BRANCH_RENAME_NO_INPUT="No input; cancelled."
MSG_BRANCH_RENAME_NOT_IN_LIST_FMT="Branch '%s' is not in the at-this-commit list.\n"
MSG_BRANCH_RENAME_NEW_NAME_PROMPT="New name: "
MSG_BRANCH_RENAME_INVALID_NAME_FMT="Invalid branch name: %s\n"
MSG_BRANCH_RENAME_EXISTS_FMT="Branch already exists: %s\n"
MSG_BRANCH_RENAME_DONE_FMT="Renamed: %s → %s\n"
MSG_BRANCH_RENAME_REMOTE_PROMPT_FMT="Also rename on remote [%s] (push new + delete old)? [y/N] "
MSG_BRANCH_RENAME_REMOTE_DONE="Remote rename complete."

# ── copy-branch-name.sh ─────────────────────────────────────────
MSG_COPY_BRANCH_TITLE="copy-branch-name (copy a branch name pointing at this commit to clipboard)"
MSG_COPY_BRANCH_PURPOSE="What:  put a branch name on the system clipboard for pasting elsewhere"
MSG_COPY_BRANCH_WHEN="When:  send the name in chat / paste into a PR description / use in another terminal"
MSG_COPY_BRANCH_NOTE="Note:  uses pbcopy (macOS) / wl-copy / xclip / xsel — whichever is available"
MSG_COPY_BRANCH_NONE="No local branches at this commit to copy."
MSG_COPY_BRANCH_LIST_HEADER="Local branches at this commit:"
MSG_COPY_BRANCH_SELECT_PROMPT="Pick one (branch name or number): "
MSG_COPY_BRANCH_NO_INPUT="No input; cancelled."
MSG_COPY_BRANCH_NOT_IN_LIST_FMT="Branch '%s' is not in the at-this-commit list.\n"
MSG_COPY_BRANCH_DONE_FMT="Copied: %s\n"
MSG_COPY_BRANCH_NO_CLIPBOARD="No clipboard utility found (need pbcopy / wl-copy / xclip / xsel). Branch name printed below:"

# ── copy-commit-message.sh ──────────────────────────────────────
MSG_COPY_MSG_TITLE="copy-commit-message (copy this commit's message to clipboard)"
MSG_COPY_MSG_PURPOSE="What:  put the commit's subject (one-line) or full message on the system clipboard"
MSG_COPY_MSG_WHEN="When:  paste into a release note / PR / chat / email"
MSG_COPY_MSG_NOTE="Note:  uses pbcopy (macOS) / wl-copy / xclip / xsel — whichever is available"
MSG_COPY_MSG_KIND_PROMPT="Copy [s]ubject (default) / [f]ull message: "
MSG_COPY_MSG_KIND_INVALID_FMT="Invalid choice: %s\n"
MSG_COPY_MSG_DONE_FMT='Copied: %s\n'
MSG_COPY_MSG_NO_CLIPBOARD="No clipboard utility found (need pbcopy / wl-copy / xclip / xsel). Message printed below:"
