#!/usr/bin/env bash
# English labels for tasks.json menu items.
# Loaded by sync-tasks.sh; substituted into tasks.json placeholders __LABEL_*__.
# Use SINGLE quotes — $ZED_GIT_SHA_SHORT and friends must stay literal for Zed.
# shellcheck shell=bash disable=SC2034

# ── 1. View / Browse ────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. View / Browse ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches containing this commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags containing this commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · Stat of this commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · Full diff of this commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · Compare to HEAD  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · Open every file touched by this commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · Export file snapshots from this commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · Export N previous commits as patches  ($ZED_GIT_SHA_SHORT)'

# ── 2. Modify this commit ───────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Modify this commit ────'
LABEL_MODIFY_REWORD='Git · Reword this commit'\''s message  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · Edit this commit (message + add/remove files)  ($ZED_GIT_SHA_SHORT)'

# ── 3. Rewrite history (rebase) ─────────────────────────────────
LABEL_SEP_REWRITE='──── 3. Rewrite history (rebase) ────'
LABEL_REWRITE_SQUASH='Git · Squash N commits forward from here  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · Drop this commit from history  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · Interactive rebase up to this commit  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · Soft reset to this commit (changes → index)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · Hard reset to this commit (DESTRUCTIVE)  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup (merge changes into this commit) ───────────────────
LABEL_SEP_FIXUP='──── 4. Fixup (merge changes into this commit) ────'
LABEL_FIXUP_INTO_THIS='Git · Fold working/staged changes into this commit (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fold this commit into an ancestor (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. Copy / Undo ──────────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Copy / Undo ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick onto current branch  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · Revert this commit  ($ZED_GIT_SHA_SHORT)'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Create new branch from this commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · Ad-hoc try-branch from this commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase branch A onto branch B (CLion-style)'
LABEL_BRANCH_DELETE='Git · Delete local branches at this commit (with optional remote)  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Tag this commit  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · Delete tag (local + optional remote)  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash current changes (named)'
LABEL_STASH_POP='Git · Pop most recent stash'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree (check out this commit in a new directory) ────'
LABEL_WT_REVIEW='Worktree · review  (detached, read-only)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (throwaway branch)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (bug fix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (new feature)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · remove  review  (paste name to confirm)'
LABEL_WT_RM_TRY='Worktree · remove  try     (paste name to confirm)'
LABEL_WT_RM_FIX='Worktree · remove  fix     (paste name to confirm)'
LABEL_WT_RM_FEAT='Worktree · remove  feat    (paste name to confirm)'
LABEL_WT_RM_HOT='Worktree · remove  hot     (paste name to confirm)'
