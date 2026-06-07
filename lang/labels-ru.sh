#!/usr/bin/env bash
# Русские метки для пунктов меню tasks.json (краткая форма).
# Загружается sync-tasks.sh; подставляется в плейсхолдеры __LABEL_*__ в tasks.json.
# Используй ОДИНАРНЫЕ кавычки — $ZED_GIT_SHA_SHORT и подобные должны остаться литералом для Zed.
#
# Правило: метки минимальны — глагол + ключевое существительное. Контекст коммита
# уже неявно задан строкой по правому клику. Подробности — в show_intro каждого скрипта.
# shellcheck shell=bash disable=SC2034

# ── 1. Просмотр ─────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Просмотр ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Ветки с commit'
LABEL_VIEW_TAGS_CONTAINING='Git · Tag с commit'
LABEL_VIEW_STAT='Git · Stat'
LABEL_VIEW_DIFF='Git · Diff'
LABEL_VIEW_DIFF_HEAD='Git · Diff с HEAD'
LABEL_VIEW_OPEN_FILES='Git · Открыть файлы'
LABEL_VIEW_EXPORT_FILES='Git · Экспорт файлов'
LABEL_VIEW_EXPORT_PATCHES='Git · Экспорт патчей'

# ── 2. Изменить ─────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Изменить ────'
LABEL_MODIFY_REWORD='Git · Reword'
LABEL_MODIFY_EDIT_COMMIT='Git · Править commit'

# ── 3. Переписать историю ───────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. Переписать историю ────'
LABEL_REWRITE_SQUASH='Git · Squash N'
LABEL_REWRITE_DROP='Git · Drop'
LABEL_REWRITE_INTERACTIVE='Git · Rebase -i'
LABEL_REWRITE_RESET_SOFT='Git · Reset soft'
LABEL_REWRITE_RESET_HARD='Git · Reset hard ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup сюда'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fixup в предка'

# ── 5. Копировать / Откат ───────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Копировать / Откат ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Новая branch'
LABEL_BRANCH_TRY='Git · Try branch'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase A на B'
LABEL_BRANCH_DELETE='Git · Удалить branch'
LABEL_BRANCH_CHECKOUT='Git · Переключить branch'
LABEL_BRANCH_RENAME='Git · Переименовать branch'
LABEL_COPY_BRANCH_NAME='Git · Копировать имя branch'
LABEL_COPY_COMMIT_MSG='Git · Копировать commit message'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Tag'
LABEL_TAG_DELETE='Git · Удалить tag'

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
LABEL_WT_RM_REVIEW='Worktree · удалить review'
LABEL_WT_RM_TRY='Worktree · удалить try'
LABEL_WT_RM_FIX='Worktree · удалить fix'
LABEL_WT_RM_FEAT='Worktree · удалить feat'
LABEL_WT_RM_HOT='Worktree · удалить hot'
