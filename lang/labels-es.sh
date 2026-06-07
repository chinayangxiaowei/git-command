#!/usr/bin/env bash
# Etiquetas en español para los elementos del menú de tasks.json (forma concisa).
# Cargado por sync-tasks.sh; sustituido en los marcadores __LABEL_*__ de tasks.json.
# Usa comillas SIMPLES — $ZED_GIT_SHA_SHORT y similares deben quedar literales para Zed.
#
# Regla de diseño: las etiquetas son mínimas — verbo + sustantivo. El contexto del commit
# ya es implícito por la fila con clic derecho. Las explicaciones detalladas viven en
# el show_intro de cada script en tiempo de ejecución.
# shellcheck shell=bash disable=SC2034

# ── 1. Ver ──────────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Ver ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches que contienen'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags que contienen'
LABEL_VIEW_STAT='Git · Stat'
LABEL_VIEW_DIFF='Git · Diff'
LABEL_VIEW_DIFF_HEAD='Git · Diff vs HEAD'
LABEL_VIEW_OPEN_FILES='Git · Abrir archivos'
LABEL_VIEW_EXPORT_FILES='Git · Exportar archivos'
LABEL_VIEW_EXPORT_PATCHES='Git · Exportar parches'

# ── 2. Modificar ────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Modificar ────'
LABEL_MODIFY_REWORD='Git · Reword'
LABEL_MODIFY_EDIT_COMMIT='Git · Editar commit'

# ── 3. Reescribir historia ──────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. Reescribir historia ────'
LABEL_REWRITE_SQUASH='Git · Squash N'
LABEL_REWRITE_DROP='Git · Drop'
LABEL_REWRITE_INTERACTIVE='Git · Rebase -i'
LABEL_REWRITE_RESET_SOFT='Git · Reset suave'
LABEL_REWRITE_RESET_HARD='Git · Reset duro ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup en'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fixup en ancestro'

# ── 5. Copiar / Deshacer ────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Copiar / Deshacer ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Nueva branch'
LABEL_BRANCH_TRY='Git · Probar branch'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase A sobre B'
LABEL_BRANCH_DELETE='Git · Borrar branch'
LABEL_BRANCH_CHECKOUT='Git · Cambiar a branch'
LABEL_BRANCH_RENAME='Git · Renombrar branch'
LABEL_COPY_BRANCH_NAME='Git · Copiar nombre de branch'
LABEL_COPY_COMMIT_MSG='Git · Copiar message de commit'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Tag'
LABEL_TAG_DELETE='Git · Borrar tag'

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
LABEL_WT_RM_REVIEW='Worktree · borrar review'
LABEL_WT_RM_TRY='Worktree · borrar try'
LABEL_WT_RM_FIX='Worktree · borrar fix'
LABEL_WT_RM_FEAT='Worktree · borrar feat'
LABEL_WT_RM_HOT='Worktree · borrar hot'
