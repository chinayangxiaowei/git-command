#!/usr/bin/env bash
# Brazilian Portuguese labels for tasks.json menu items (concise form).
# Loaded by sync-tasks.sh; substituted into tasks.json placeholders __LABEL_*__.
# Use SINGLE quotes — $ZED_GIT_SHA_SHORT and friends must stay literal for Zed.
#
# Design rule: menu labels are minimal — verb + core noun. The commit context
# is already implicit from the right-clicked row. Detailed explanations live in
# each script's show_intro at runtime.
# shellcheck shell=bash disable=SC2034

# ── 1. Ver ──────────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Ver ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches contendo'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags contendo'
LABEL_VIEW_STAT='Git · Stat'
LABEL_VIEW_DIFF='Git · Diff'
LABEL_VIEW_DIFF_HEAD='Git · Diff vs HEAD'
LABEL_VIEW_OPEN_FILES='Git · Abrir arquivos'
LABEL_VIEW_EXPORT_FILES='Git · Exportar arquivos'
LABEL_VIEW_EXPORT_PATCHES='Git · Exportar patches'

# ── 2. Modificar ────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Modificar ────'
LABEL_MODIFY_REWORD='Git · Reword'
LABEL_MODIFY_EDIT_COMMIT='Git · Editar commit'

# ── 3. Reescrever histórico ─────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. Reescrever histórico ────'
LABEL_REWRITE_SQUASH='Git · Squash N'
LABEL_REWRITE_DROP='Git · Drop'
LABEL_REWRITE_INTERACTIVE='Git · Rebase -i'
LABEL_REWRITE_RESET_SOFT='Git · Reset soft'
LABEL_REWRITE_RESET_HARD='Git · Reset hard ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup em'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fixup em ancestral'

# ── 5. Copiar / Desfazer ────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Copiar / Desfazer ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Nova branch'
LABEL_BRANCH_TRY='Git · Testar branch'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase A em B'
LABEL_BRANCH_DELETE='Git · Apagar branch'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Tag'
LABEL_TAG_DELETE='Git · Apagar tag'

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
LABEL_WT_RM_REVIEW='Worktree · remover review'
LABEL_WT_RM_TRY='Worktree · remover try'
LABEL_WT_RM_FIX='Worktree · remover fix'
LABEL_WT_RM_FEAT='Worktree · remover feat'
LABEL_WT_RM_HOT='Worktree · remover hot'
