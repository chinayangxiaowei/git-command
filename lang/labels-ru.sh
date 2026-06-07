#!/usr/bin/env bash
# Русские метки для пунктов меню tasks.json.
# Загружается sync-tasks.sh; подставляется в плейсхолдеры __LABEL_*__ в tasks.json.
# Используй ОДИНАРНЫЕ кавычки — $ZED_GIT_SHA_SHORT и подобные должны остаться литералом для Zed.
# shellcheck shell=bash disable=SC2034

# ── 1. Просмотр ─────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Просмотр ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Ветки, содержащие этот commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · Tag, содержащие этот commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · Stat этого commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · Полный diff этого commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · Сравнить с HEAD  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · Открыть все файлы из этого commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · Экспорт снимков файлов из этого commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · Экспорт N предыдущих commit как patch  ($ZED_GIT_SHA_SHORT)'

# ── 2. Изменить этот commit ─────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Изменить этот commit ────'
LABEL_MODIFY_REWORD='Git · Reword сообщения этого commit  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · Редактировать этот commit (сообщение + добавить/убрать файлы)  ($ZED_GIT_SHA_SHORT)'

# ── 3. Переписать историю (rebase) ──────────────────────────────
LABEL_SEP_REWRITE='──── 3. Переписать историю (rebase) ────'
LABEL_REWRITE_SQUASH='Git · Squash N commit вперёд отсюда  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · Drop этого commit из истории  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · Интерактивный rebase до этого commit  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · Soft reset до этого commit (изменения → index)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · Hard reset до этого commit (РАЗРУШИТЕЛЬНО)  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup (влить изменения в этот commit) ────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup (влить изменения в этот commit) ────'
LABEL_FIXUP_INTO_THIS='Git · Влить working/staged изменения в этот commit (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · Влить этот commit в предка (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. Копировать / Отменить ────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Копировать / Отменить ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick на текущую ветку  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · Revert этого commit  ($ZED_GIT_SHA_SHORT)'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Создать новую ветку от этого commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · Разовая try-ветка от этого commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase ветки A на ветку B (стиль CLion)'
LABEL_BRANCH_DELETE='Git · Удалить локальные ветки на этом commit (с опц. remote)  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Поставить tag на этот commit  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · Удалить tag (локально + опц. remote)  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash текущие изменения (с именем)'
LABEL_STASH_POP='Git · Pop самого свежего stash'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree (открыть этот commit в новом каталоге) ────'
LABEL_WT_REVIEW='Worktree · review  (detached, только чтение)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (одноразовая ветка)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (исправление бага)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (новая фича)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · remove  review  (вставь имя для подтверждения)'
LABEL_WT_RM_TRY='Worktree · remove  try     (вставь имя для подтверждения)'
LABEL_WT_RM_FIX='Worktree · remove  fix     (вставь имя для подтверждения)'
LABEL_WT_RM_FEAT='Worktree · remove  feat    (вставь имя для подтверждения)'
LABEL_WT_RM_HOT='Worktree · remove  hot     (вставь имя для подтверждения)'
