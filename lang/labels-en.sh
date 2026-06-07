#!/usr/bin/env bash
# English labels for tasks.json menu items (concise form).
# Loaded by sync-tasks.sh; substituted into tasks.json placeholders __LABEL_*__.
# Use SINGLE quotes — $ZED_GIT_SHA_SHORT and friends must stay literal for Zed.
#
# Design rule: menu labels are minimal — verb + core noun. The commit context
# is already implicit from the right-clicked row. Detailed explanations live in
# each script's show_intro at runtime.
# shellcheck shell=bash disable=SC2034

# ── 1. View ─────────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. View ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches containing'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags containing'
LABEL_VIEW_STAT='Git · Stat'
LABEL_VIEW_DIFF='Git · Diff'
LABEL_VIEW_DIFF_HEAD='Git · Diff vs HEAD'
LABEL_VIEW_OPEN_FILES='Git · Open files'
LABEL_VIEW_EXPORT_FILES='Git · Export files'
LABEL_VIEW_EXPORT_PATCHES='Git · Export patches'

# ── 2. Modify ───────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Modify ────'
LABEL_MODIFY_REWORD='Git · Reword'
LABEL_MODIFY_EDIT_COMMIT='Git · Edit commit'

# ── 3. Rewrite history ──────────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. Rewrite history ────'
LABEL_REWRITE_SQUASH='Git · Squash N'
LABEL_REWRITE_DROP='Git · Drop'
LABEL_REWRITE_INTERACTIVE='Git · Rebase -i'
LABEL_REWRITE_RESET_SOFT='Git · Reset soft'
LABEL_REWRITE_RESET_HARD='Git · Reset hard ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup into'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fixup into ancestor'

# ── 5. Copy / Undo ──────────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Copy / Undo ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · New branch'
LABEL_BRANCH_TRY='Git · Try branch'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase A onto B'
LABEL_BRANCH_DELETE='Git · Delete branch'
LABEL_BRANCH_CHECKOUT='Git · Switch to branch'
LABEL_BRANCH_RENAME='Git · Rename branch'
LABEL_COPY_BRANCH_NAME='Git · Copy branch name'
LABEL_COPY_COMMIT_MSG='Git · Copy commit message'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Tag'
LABEL_TAG_DELETE='Git · Delete tag'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash'
LABEL_STASH_POP='Git · Pop stash'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree ────'
LABEL_WT_REVIEW='Worktree · review'
LABEL_WT_TRY='Worktree · try'
LABEL_WT_FIX='Worktree · fix'
LABEL_WT_FEAT='Worktree · feat'
LABEL_WT_HOT='Worktree · hot'
LABEL_WT_RM_REVIEW='Worktree · remove review'
LABEL_WT_RM_TRY='Worktree · remove try'
LABEL_WT_RM_FIX='Worktree · remove fix'
LABEL_WT_RM_FEAT='Worktree · remove feat'
LABEL_WT_RM_HOT='Worktree · remove hot'
