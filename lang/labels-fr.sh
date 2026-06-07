#!/usr/bin/env bash
# Labels français pour les items de menu de tasks.json.
# Loaded by sync-tasks.sh; substituted into tasks.json placeholders __LABEL_*__.
# Utiliser des guillemets SIMPLES — $ZED_GIT_SHA_SHORT et consorts doivent rester littéraux pour Zed.
# shellcheck shell=bash disable=SC2034

# ── 1. Voir / Parcourir ─────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Voir / Parcourir ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches contenant ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags contenant ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · Stat de ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · Diff complet de ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · Comparer à HEAD  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · Ouvrir tous les fichiers touchés par ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · Exporter les snapshots de fichiers de ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · Exporter les N commits précédents en patches  ($ZED_GIT_SHA_SHORT)'

# ── 2. Modifier ce commit ───────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Modifier ce commit ────'
LABEL_MODIFY_REWORD='Git · Reword le message de ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · Éditer ce commit (message + ajout/retrait fichiers)  ($ZED_GIT_SHA_SHORT)'

# ── 3. Réécrire l’historique (rebase) ───────────────────────────
LABEL_SEP_REWRITE='──── 3. Réécrire l’historique (rebase) ────'
LABEL_REWRITE_SQUASH='Git · Squash N commits vers l’avant d’ici  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · Drop ce commit de l’historique  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · Rebase interactif jusqu’à ce commit  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · Soft reset vers ce commit (changements → index)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · Hard reset vers ce commit (DESTRUCTIF)  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup (fusionner des changements dans ce commit) ─────────
LABEL_SEP_FIXUP='──── 4. Fixup (fusionner des changements dans ce commit) ────'
LABEL_FIXUP_INTO_THIS='Git · Fusionner working/staged dans ce commit (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fusionner ce commit dans un ancêtre (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. Copier / Annuler ─────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Copier / Annuler ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick sur la branche courante  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · Revert ce commit  ($ZED_GIT_SHA_SHORT)'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Créer une nouvelle branch depuis ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · Try-branch ad-hoc depuis ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase branch A sur branch B (style CLion)'
LABEL_BRANCH_DELETE='Git · Supprimer branches locales sur ce commit (remote optionnel)  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Taguer ce commit  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · Supprimer un tag (local + remote optionnel)  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash les changements courants (nommé)'
LABEL_STASH_POP='Git · Pop le stash le plus récent'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree (checkout ce commit dans un nouveau dossier) ────'
LABEL_WT_REVIEW='Worktree · review  (detached, lecture seule)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (branch jetable)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (correctif bug)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (nouvelle feature)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · remove  review  (coller le nom pour confirmer)'
LABEL_WT_RM_TRY='Worktree · remove  try     (coller le nom pour confirmer)'
LABEL_WT_RM_FIX='Worktree · remove  fix     (coller le nom pour confirmer)'
LABEL_WT_RM_FEAT='Worktree · remove  feat    (coller le nom pour confirmer)'
LABEL_WT_RM_HOT='Worktree · remove  hot     (coller le nom pour confirmer)'
