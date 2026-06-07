#!/usr/bin/env bash
# Étiquettes françaises pour les items de menu de tasks.json (forme concise).
# Chargé par sync-tasks.sh ; substitué dans les placeholders __LABEL_*__ de tasks.json.
# Utiliser des guillemets SIMPLES — $ZED_GIT_SHA_SHORT et consorts doivent rester littéraux pour Zed.
#
# Règle de design : les étiquettes du menu sont minimales — verbe + nom essentiel.
# Le contexte du commit est implicite via la ligne cliquée. Les explications
# détaillées vivent dans show_intro de chaque script à l'exécution.
# shellcheck shell=bash disable=SC2034

# ── 1. Voir ─────────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Voir ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches contenant'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags contenant'
LABEL_VIEW_STAT='Git · Stat'
LABEL_VIEW_DIFF='Git · Diff'
LABEL_VIEW_DIFF_HEAD='Git · Diff vs HEAD'
LABEL_VIEW_OPEN_FILES='Git · Ouvrir fichiers'
LABEL_VIEW_EXPORT_FILES='Git · Exporter fichiers'
LABEL_VIEW_EXPORT_PATCHES='Git · Exporter patches'

# ── 2. Modifier ─────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Modifier ────'
LABEL_MODIFY_REWORD='Git · Reword'
LABEL_MODIFY_EDIT_COMMIT='Git · Éditer commit'

# ── 3. Réécrire historique ──────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. Réécrire historique ────'
LABEL_REWRITE_SQUASH='Git · Squash N'
LABEL_REWRITE_DROP='Git · Drop'
LABEL_REWRITE_INTERACTIVE='Git · Rebase -i'
LABEL_REWRITE_RESET_SOFT='Git · Reset soft'
LABEL_REWRITE_RESET_HARD='Git · Reset hard ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup vers'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fixup vers ancêtre'

# ── 5. Copier / Annuler ─────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Copier / Annuler ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Nouvelle branch'
LABEL_BRANCH_TRY='Git · Tester branch'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase A sur B'
LABEL_BRANCH_DELETE='Git · Supprimer branch'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Tag'
LABEL_TAG_DELETE='Git · Supprimer tag'

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
LABEL_WT_RM_REVIEW='Worktree · supprimer review'
LABEL_WT_RM_TRY='Worktree · supprimer try'
LABEL_WT_RM_FIX='Worktree · supprimer fix'
LABEL_WT_RM_FEAT='Worktree · supprimer feat'
LABEL_WT_RM_HOT='Worktree · supprimer hot'
