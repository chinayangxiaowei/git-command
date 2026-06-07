#!/usr/bin/env bash
# Rótulos em Português Brasileiro para os itens do menu do tasks.json.
# Carregado por sync-tasks.sh; substituído nos placeholders __LABEL_*__ do tasks.json.
# Use aspas SIMPLES — $ZED_GIT_SHA_SHORT e similares precisam ficar literais para o Zed.
# shellcheck shell=bash disable=SC2034

# ── 1. Visualizar / Navegar ─────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Visualizar / Navegar ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches que contêm este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags que contêm este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · Stat deste commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · Diff completo deste commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · Comparar com HEAD  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · Abrir todos os arquivos tocados por este commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · Exportar snapshots dos arquivos deste commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · Exportar N commits anteriores como patches  ($ZED_GIT_SHA_SHORT)'

# ── 2. Modificar este commit ────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Modificar este commit ────'
LABEL_MODIFY_REWORD='Git · Reword da mensagem deste commit  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · Editar este commit (mensagem + add/remove arquivos)  ($ZED_GIT_SHA_SHORT)'

# ── 3. Reescrever histórico (rebase) ────────────────────────────
LABEL_SEP_REWRITE='──── 3. Reescrever histórico (rebase) ────'
LABEL_REWRITE_SQUASH='Git · Squash de N commits a partir daqui  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · Drop deste commit do histórico  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · Rebase interativo até este commit  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · Soft reset para este commit (alterações → index)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · Hard reset para este commit (DESTRUTIVO)  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup (mesclar alterações neste commit) ──────────────────
LABEL_SEP_FIXUP='──── 4. Fixup (mesclar alterações neste commit) ────'
LABEL_FIXUP_INTO_THIS='Git · Mesclar alterações working/staged neste commit (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · Mesclar este commit em um ancestral (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. Copiar / Desfazer ────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Copiar / Desfazer ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick para a branch atual  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · Revert deste commit  ($ZED_GIT_SHA_SHORT)'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Criar nova branch a partir deste commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · Try-branch ad-hoc a partir deste commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase da branch A sobre a branch B (estilo CLion)'
LABEL_BRANCH_DELETE='Git · Deletar branches locais neste commit (com remote opcional)  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Criar tag neste commit  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · Deletar tag (local + remote opcional)  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Guardar alterações atuais no stash (nomeado)'
LABEL_STASH_POP='Git · Pop do stash mais recente'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree (checkout deste commit em um novo diretório) ────'
LABEL_WT_REVIEW='Worktree · review  (detached, somente leitura)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (branch descartável)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (correção de bug)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (nova feature)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · remove  review  (cole o nome para confirmar)'
LABEL_WT_RM_TRY='Worktree · remove  try     (cole o nome para confirmar)'
LABEL_WT_RM_FIX='Worktree · remove  fix     (cole o nome para confirmar)'
LABEL_WT_RM_FEAT='Worktree · remove  feat    (cole o nome para confirmar)'
LABEL_WT_RM_HOT='Worktree · remove  hot     (cole o nome para confirmar)'
