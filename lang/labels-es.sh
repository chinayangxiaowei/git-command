#!/usr/bin/env bash
# Etiquetas en español para los elementos del menú de tasks.json.
# Cargado por sync-tasks.sh; sustituido en los marcadores __LABEL_*__ de tasks.json.
# Usa comillas SIMPLES — $ZED_GIT_SHA_SHORT y similares deben quedar literales para Zed.
# shellcheck shell=bash disable=SC2034

# ── 1. Ver / Explorar ───────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Ver / Explorar ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches que contienen este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags que contienen este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · Stat de este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · Diff completo de este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · Comparar con HEAD  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · Abrir todos los archivos del commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · Exportar archivos de este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · Exportar N commits previos como parches  ($ZED_GIT_SHA_SHORT)'

# ── 2. Modificar este commit ────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Modificar este commit ────'
LABEL_MODIFY_REWORD='Git · Reword el mensaje de este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · Editar este commit (mensaje + agregar/quitar)  ($ZED_GIT_SHA_SHORT)'

# ── 3. Reescribir historia (rebase) ─────────────────────────────
LABEL_SEP_REWRITE='──── 3. Reescribir historia (rebase) ────'
LABEL_REWRITE_SQUASH='Git · Squash de N commits desde aquí  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · Eliminar este commit de la historia  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · Rebase interactivo hasta este commit  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · Reset suave a este commit (cambios → index)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · Reset duro a este commit (DESTRUCTIVO)  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup (fundir cambios en este commit) ────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup (fundir cambios en este commit) ────'
LABEL_FIXUP_INTO_THIS='Git · Fundir cambios del working/staged en este commit (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fundir este commit en un ancestro (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. Copiar / Deshacer ────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Copiar / Deshacer ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick sobre la branch actual  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · Revert de este commit  ($ZED_GIT_SHA_SHORT)'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Crear branch nueva desde este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · Try-branch ad-hoc desde este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase de branch A sobre branch B (estilo CLion)'
LABEL_BRANCH_DELETE='Git · Borrar branches locales en este commit (remote opcional)  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Tag a este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · Borrar tag (local + remote opcional)  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash de los cambios actuales (con nombre)'
LABEL_STASH_POP='Git · Pop del stash más reciente'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree (chequear este commit en un nuevo directorio) ────'
LABEL_WT_REVIEW='Worktree · review  (detached, solo lectura)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (branch desechable)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (corrección de bug)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (nueva función)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · borrar  review  (pega el nombre para confirmar)'
LABEL_WT_RM_TRY='Worktree · borrar  try     (pega el nombre para confirmar)'
LABEL_WT_RM_FIX='Worktree · borrar  fix     (pega el nombre para confirmar)'
LABEL_WT_RM_FEAT='Worktree · borrar  feat    (pega el nombre para confirmar)'
LABEL_WT_RM_HOT='Worktree · borrar  hot     (pega el nombre para confirmar)'
