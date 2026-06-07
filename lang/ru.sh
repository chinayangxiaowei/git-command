#!/usr/bin/env bash
# Русские строки сообщений для скриптов git-command.
# Загружается lib.sh; не запускать напрямую.
# Соглашение об именовании: MSG_<SCRIPT>_<KEY>; суффикс _FMT — шаблоны printf.
# shellcheck shell=bash

# ── lib.sh (общие внутренние функции) ───────────────────────────
MSG_LIB_IN_PROGRESS_FMT='Незавершённый %s в процессе. Сначала запусти "%s" или --continue.\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s завершился ошибкой; автоматически выполняю git %s --abort (рабочая область восстановлена до состояния перед операцией).\n'
MSG_LIB_NOT_IN_REPO='Не внутри git-репозитория.'
MSG_LIB_NOT_BARE_LAYOUT='Текущий проект не в раскладке bare + worktrees; меню worktree отключено.'
MSG_LIB_INIT_HINT='Чтобы включить, создай новый проект командой: bash git-command/init-bare-tree.sh <name> [<url>]'
MSG_LIB_MIGRATE_HINT='Для существующих проектов: migrate-to-bare-tree.sh (пока не реализован; мигрируй вручную).'
MSG_LIB_CLEANUP_FMT='Скрипт завершился неожиданно (exit %d); автоматически выполняю git %s --abort для отката.\n'

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword (переписать сообщение этого commit)"
MSG_REWORD_PURPOSE="Что:        меняется только сообщение commit; содержимое файлов и цепочка SHA остаются прежними (последующие SHA будут переписаны)"
MSG_REWORD_WHEN="Когда:      исправить опечатку / привести к конвенции / добавить ссылку на issue / поправить префикс conventional-commit"
MSG_REWORD_CONTRAST="Примечание: для сообщения самого HEAD быстрее edit-commit; reword нужен для более старых commit"
MSG_REWORD_DIRTY_TREE="В рабочем дереве есть незакоммиченные изменения; сначала сделай commit или stash."
MSG_REWORD_NOT_ANCESTOR_FMT='%s не в цепочке предков текущей ветки; reword невозможен.\n'
MSG_REWORD_OLD_MSG="Старое сообщение:"
MSG_REWORD_NEW_MSG_PROMPT="Новое сообщение (по строке; пустая строка = разрыв абзаца; одна 'Q' для отправки, ':q' для отмены):"
MSG_REWORD_CANCELLED="Отменено."
MSG_REWORD_EMPTY_CANCELLED="Нет ввода; отменено."

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files (открыть в Zed все файлы, затронутые этим commit)"
MSG_OPEN_FILES_PURPOSE="Что:        перечислить файлы, изменённые этим commit, и открыть их все в Zed (текущая рабочая версия)"
MSG_OPEN_FILES_WHEN="Когда:      отладка исторического бага; нужно посмотреть все файлы, участвовавшие в том изменении"
MSG_OPEN_FILES_PREREQ="Нужно:      zed CLI в PATH; файлы, отсутствующие в текущем дереве, пропускаются"
MSG_OPEN_FILES_EMPTY="В этом commit нет изменений файлов (возможно, пустой commit)."
MSG_OPEN_FILES_MISSING="Следующие файлы больше не в рабочем дереве (удалены/переименованы), пропускаю:"
MSG_OPEN_FILES_ALL_GONE="Ни один из файлов, затронутых этим commit, не остался в рабочем дереве."
MSG_OPEN_FILES_OPENING_FMT='Открываю %d файл(ов) в Zed:\n'
MSG_OPEN_FILES_NO_ZED="Команда zed не найдена."
MSG_OPEN_FILES_INSTALL_HINT="В Zed: Cmd+Shift+P → 'zed: install cli' чтобы установить zed CLI."

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files (экспорт файлов на этом commit в папку)"
MSG_EXPORT_FILES_PURPOSE="Что:        скопировать каждый файл, изменённый этим commit (в версии ЭТОГО commit), в папку с сохранением путей"
MSG_EXPORT_FILES_WHEN="Когда:      слишком много файлов чтобы открывать вкладками / снимок артефактов commit / offline-diff"
MSG_EXPORT_FILES_CONTRAST="Примечание: open-files открывает текущую рабочую версию; этот же экспортирует историческую версию на этом commit"
MSG_EXPORT_FILES_EMPTY="В этом commit нет изменений файлов (возможно, пустой commit)."
MSG_EXPORT_FILES_COUNT_FMT='Этот commit затрагивает %d файл(ов):\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... и ещё %d\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='Каталог экспорта (относительно корня репо, по умолчанию %s): '
MSG_EXPORT_FILES_DIR_EXISTS_FMT='Каталог существует и не пуст: %s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="Продолжение может перезаписать одноимённые файлы. Продолжить?"
MSG_EXPORT_FILES_DELETED_HINT="(удалён в этом commit; экспортировать нечего)"
MSG_EXPORT_FILES_DONE_FMT='Готово: экспортировано %d, пропущено %d → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="Примечание: содержимое отражает снимок на этом commit, а не текущую рабочую версию."

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches (экспортировать N patch-файлов)"
MSG_EXPORT_PATCHES_PURPOSE="Что:        экспортировать N commit назад отсюда как mbox (.patch) или обычный diff (.diff)"
MSG_EXPORT_PATCHES_WHEN="Когда:      совместная работа по email / резервная копия конкретных изменений / отправка другим для git am / git apply"
MSG_EXPORT_PATCHES_OUTPUT="Вывод:      выбранный каталог (по умолчанию ./patches); история никогда не меняется"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="Формат [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply) (по умолчанию f): "
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='Недопустимый формат: %s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="Сколько commit назад (по умолчанию 1): "
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='Недопустимое число: %s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="Каталог вывода (относительно корня репо, по умолчанию ./patches): "
MSG_EXPORT_PATCHES_FORMAT_LABEL="Формат:"
MSG_EXPORT_PATCHES_RANGE_LABEL="Диапазон:"
MSG_EXPORT_PATCHES_OUTPUT_LABEL="Вывод:"
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(корень)"
MSG_EXPORT_PATCHES_CONTINUE="Продолжить?"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft (мягкий reset до этого commit · изменения уходят в staging)"
MSG_RESET_SOFT_PURPOSE="Что:        переместить HEAD на этот commit; изменения промежуточных commit попадают в индекс (ничего не теряется)"
MSG_RESET_SOFT_WHEN="Когда:      хочешь перепаковать последние N commit (разделить / поменять сообщение / объединить)"
MSG_RESET_SOFT_AFTER="После:      git status — посмотреть индекс, затем закоммитить новую историю"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s не в цепочке предков HEAD; soft reset бессмыслен.\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s уже HEAD; reset не нужен.\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='Текущая ветка: %s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='Будут отброшены эти commit (их изменения уйдут в индекс, HEAD → %s):\n'
MSG_RESET_SOFT_CONFIRM_FMT='Soft reset до %s?'
MSG_RESET_SOFT_DONE="Готово. Изменения в индексе; проверь через git status, сделай commit снова чтобы перезаписать."

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard (жёсткий reset до этого commit · РАЗРУШИТЕЛЬНО)"
MSG_RESET_HARD_PURPOSE="Что:        переместить HEAD на этот commit; ОТБРОСИТЬ промежуточные commit И все изменения рабочего дерева"
MSG_RESET_HARD_WHEN="Когда:      полностью откатиться к состоянию и ты уверен, что готов потерять все промежуточные изменения"
MSG_RESET_HARD_AFTER="После:      невосстановимо (если только git reflog в течение 30 дней; требует ввода YES заглавными)"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s не в цепочке предков HEAD; отказ.\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s уже HEAD; reset не нужен.\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='Текущая ветка: %s\n'
MSG_RESET_HARD_WILL_DROP="Будут отброшены эти commit (невосстановимо, кроме как через reflog):"
MSG_RESET_HARD_WT_LOST="Изменения рабочего дерева также будут отброшены:"
MSG_RESET_HARD_YES_PROMPT_FMT='Введи YES (заглавными) чтобы подтвердить hard reset до %s: '
MSG_RESET_HARD_NO_YES="YES не введено; отменено."
MSG_RESET_HARD_REFLOG_HINT="Подсказка: reflog ещё может восстановить эти commit; в течение 30 дней проверь git reflog → HEAD@{N}."

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i (интерактивный rebase до этого commit)"
MSG_REBASE_I_PURPOSE='Что:        запустить git rebase -i SHA^, открыть $EDITOR для ручного редактирования todo'
MSG_REBASE_I_WHEN="Когда:      вручную переупорядочить/объединить/отредактировать/удалить несколько commit; сложнее, чем покрывает стандартное меню"
MSG_REBASE_I_PREREQ="Нужно:      рабочее дерево должно быть чистым; при возникновении конфликтов разруливай вручную или полагайся на abort из EXIT trap"
MSG_REBASE_I_RANGE_FMT='Запускаю интерактивный rebase, диапазон: %s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="В рабочем дереве есть незакоммиченные изменения; сначала сделай commit или stash."
MSG_REBASE_I_CONTINUE="Продолжить?"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert (создать обратный commit чтобы отменить этот)"
MSG_REVERT_PURPOSE="Что:        не переписывать историю; добавить новый commit поверх HEAD с обратными изменениями этого commit"
MSG_REVERT_WHEN="Когда:      уже запушенный commit нужно отменить (reset переписал бы публичную историю)"
MSG_REVERT_CONTRAST="Примечание: reset переписывает историю; revert дописывает к ней. Авто-abort при конфликтах."
MSG_REVERT_DIRTY_TREE="В рабочем дереве есть незакоммиченные изменения; сначала сделай commit или stash."
MSG_REVERT_CONFIRM_FMT='Создать обратный commit поверх HEAD чтобы отменить %s?\n'

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick (скопировать этот commit на вершину текущей ветки)"
MSG_CHERRY_PICK_PURPOSE="Что:        скопировать изменения этого commit на верхушку текущей ветки как новый commit (новый SHA)"
MSG_CHERRY_PICK_WHEN="Когда:      перенести hotfix между веток / забрать один commit у коллеги / восстановить через reflog"
MSG_CHERRY_PICK_NOTE="Примечание: исходный commit не удаляется; в той же ветке бессмысленно; авто-abort при конфликте"
MSG_CHERRY_PICK_CURRENT_FMT='Текущая ветка: %s\n'
MSG_CHERRY_PICK_DIRTY_TREE="В рабочем дереве есть незакоммиченные изменения; сначала сделай commit или stash."
MSG_CHERRY_PICK_CONFIRM_FMT='Cherry-pick %s на %s?'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from (создать новую ветку от этого commit)"
MSG_BRANCH_FROM_PURPOSE="Что:        создать новую ветку на этом commit и переключиться на неё"
MSG_BRANCH_FROM_WHEN="Когда:      начать новую линию работы от старого commit / держать именованную ссылку на конкретное состояние"
MSG_BRANCH_FROM_CONTRAST="Примечание: для одноразовых экспериментов используй try-branch (авто-префикс try/ + подсказка по очистке)"
MSG_BRANCH_FROM_NAME_PROMPT="Имя новой ветки (на основе этого commit): "
MSG_BRANCH_FROM_NO_NAME="Имя ветки не задано; отменено."

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch (одноразовая ветка от этого commit)"
MSG_TRY_BRANCH_PURPOSE="Что:        создать ветку с именем try/<base-slug>-<sha> от этого commit, сразу переключиться"
MSG_TRY_BRANCH_WHEN="Когда:      эксперимент без загрязнения текущей ветки / посмотреть состояние на старом commit"
MSG_TRY_BRANCH_HINT="Подсказка:  на выходе печатает команды 'вернуться на исходную' + 'удалить эту ветку' как напоминания"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # был detached; смотри reflog"
MSG_TRY_BRANCH_FROM_FMT='Исходная ветка: %s\nТочка старта:   %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='Имя новой ветки (Enter = %s): '
MSG_TRY_BRANCH_EXISTS_FMT='Ветка уже существует: %s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="Переключиться на неё после создания? [Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='Создано %s (без переключения)\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="Когда закончишь, очисти так:"
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  вернуться на исходную: %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  удалить эту ветку: git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push (положить текущие изменения в stash с именем)"
MSG_STASH_PUSH_PURPOSE="Что:        отправить отслеживаемые изменения в stash с меткой, оставив рабочее дерево чистым"
MSG_STASH_PUSH_WHEN="Когда:      собираешься переключить ветку с WIP / ненадолго отложить работу / предочистка перед reset"
MSG_STASH_PUSH_NOTE="Примечание: -u НЕ используется; неотслеживаемые файлы остаются в рабочем дереве (избегаем лишних snapshot-узлов в Git Graph)"
MSG_STASH_PUSH_CLEAN="Рабочее дерево чистое; в stash положить нечего."
MSG_STASH_PUSH_WILL_STASH="В stash попадут следующие изменения:"
MSG_STASH_PUSH_NAME_PROMPT="Выбери имя (поможет найти позже): "
MSG_STASH_PUSH_NO_NAME="Имя не задано; отменено."
MSG_STASH_PUSH_DONE_HINT="Готово. Посмотреть: git stash list, или используй меню 'Pop most recent stash'."
MSG_STASH_PUSH_UNTRACKED_NOTE="Примечание: неотслеживаемые файлы НЕ были положены в stash и остаются в рабочем дереве."

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop (применить самый свежий stash к рабочему дереву)"
MSG_STASH_POP_PURPOSE="Что:        применить stash@{0} к рабочему дереву; при успехе stash автоматически удаляется"
MSG_STASH_POP_WHEN="Когда:      ранее отложенные в stash изменения должны вернуться"
MSG_STASH_POP_NOTE="Примечание: при конфликте stash НЕ удаляется автоматически; разреши конфликты, затем выполни git stash drop"
MSG_STASH_POP_EMPTY="Нет stash для pop."
MSG_STASH_POP_LIST_HEADER="Последние stash:"
MSG_STASH_POP_PREVIEW_HEADER="превью stash@{0}:"
MSG_STASH_POP_CONFIRM="Сделать pop stash@{0} в текущее рабочее дерево?"
MSG_STASH_POP_CONFLICT="Pop столкнулся с конфликтами — stash сохранён (не удалён автоматически)."
MSG_STASH_POP_CONFLICT_HINT="Разреши конфликты + git add, затем выполни  git stash drop  чтобы его отбросить."

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete (удалить локальные ветки, указывающие на этот commit)"
MSG_BRANCH_DELETE_PURPOSE="Что:        удалить локальную ветку (опционально и удалённую тоже)"
MSG_BRANCH_DELETE_WHEN="Когда:      прибрать смерженные/одноразовые ветки; массово почистить try/* feat/* и т.п."
MSG_BRANCH_DELETE_NOTE="Примечание: использует git branch -D (принудительное удаление; игнорирует статус merged)"
MSG_BRANCH_DELETE_NONE="На этом commit нет локальных веток для удаления."
MSG_BRANCH_DELETE_ONE_FMT='Единственная ветка на этом commit: %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="Локальные ветки на этом commit:"
MSG_BRANCH_DELETE_SELECT_PROMPT="Выбери одну (имя ветки или номер): "
MSG_BRANCH_DELETE_NO_INPUT="Нет ввода; отменено."
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="Ветка '%s' не в списке на этом commit.\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="Нельзя удалить ветку '%s', на которой сейчас находишься.\n"
MSG_BRANCH_DELETE_CURRENT_HINT="Сначала переключись на другую ветку: git switch <other-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="Удалить локальную ветку '%s'?"
MSG_BRANCH_DELETE_LOCAL_DONE="Локальная ветка удалена."
MSG_BRANCH_DELETE_NO_REMOTE="(remote не настроен; пропускаю удалённую)"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="(ветки нет на remote [%s]; пропускаю)"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="Удалить также с remote [%s]? [y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="Удалённая ветка удалена."

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit (редактировать метаданные / список файлов этого commit)"
MSG_EDIT_COMMIT_HEAD_PATH="Путь HEAD:    рабочее дерево может быть грязным; прямой amend; смена сообщения / добавление / удаление / правка файлов"
MSG_EDIT_COMMIT_OLD_PATH="Старый commit: рабочее дерево должно быть чистым; поддерживается сообщение / добавление (неотслеживаемых) / удаление файлов"
MSG_EDIT_COMMIT_NOT_SUITED="Не подходит (старый commit): изменение содержимого существующих файлов → используй меню fixup (причина — в комментарии в заголовке)"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="По одной операции на строке, закончи 'Q' на отдельной строке:"
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:path/to/file    git add (добавить / обновить / поставить в stage любое изменение)"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:path/to/file    убрать из этого commit (на диске остаётся, git rm --cached)"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                 готово"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  пропуск, ошибка формата: %s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  пропуск +%s  (файл не существует)\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  add  %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  пропуск +%s  (git add не удался)\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  rm   %s  (убран из commit, на диске оставлен)\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  пропуск -%s  (не в этом commit)\n'
MSG_EDIT_COMMIT_ASK_MSG="Новое сообщение (по строке; одна 'Q' для отправки; просто Q = оставить без изменений):"
MSG_EDIT_COMMIT_HEAD_HEADER="─── быстрый путь HEAD ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="Цель — HEAD, rebase не нужен:"
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · рабочее дерево может быть грязным (изменения становятся кандидатами на amend)"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · свободно добавляй / меняй / удаляй файлы; нет риска конфликтов ниже по истории"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── текущее сообщение ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── текущие изменения в working/staged ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="Сменить сообщение? [y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="Изменить файлы (добавить/удалить/править)? [y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="(изменений нет; amend не делаю; выход.)"
MSG_EDIT_COMMIT_UNSTAGED_HINT="Примечание: в рабочем дереве остаются unstaged изменения; amend их НЕ включит."
MSG_EDIT_COMMIT_AMEND_MSG_FILES="Сделан amend (новое сообщение + изменения файлов)"
MSG_EDIT_COMMIT_AMEND_MSG="Сделан amend (новое сообщение)"
MSG_EDIT_COMMIT_AMEND_FILES="Сделан amend (изменения файлов)"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='В рабочем дереве есть незакоммиченные изменения.

Если хочешь влить эти изменения в этот commit → используй меню:
  "Fold working/staged changes into this commit (fixup+autosquash)"

Если действительно нужно это меню (смена сообщения / добавление новых файлов / удаление файлов), сначала сделай commit или stash.'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s не в цепочке предков текущей ветки.\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── Путь для старого commit (rebase) ───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="Применимо к: сообщению / добавлению новых файлов (неотслеживаемых) / удалению файлов"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="НЕ применимо к: изменению содержимого существующих файлов (используй меню fixup)"
MSG_EDIT_COMMIT_OLD_CONTINUE="Продолжить?"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="rebase не вошёл в состояние edit."
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── текущее сообщение commit ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="Сменить сообщение? [y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="Изменить файлы (добавить/удалить)? [y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="(изменений нет; завершаю)"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue не удался (вероятно, downstream-конфликт modify/delete с файлом, который ты только что удалил)."
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase завершён"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n (сжать N commit вперёд от этого commit)"
MSG_SQUASH_PURPOSE="Что:        сжать этот commit и N-1 предков в один; последующие commit переигрываются сверху"
MSG_SQUASH_WHEN="Когда:      прибрать WIP commit / сжать шум / объединить несколько связанных мелких commit"
MSG_SQUASH_PREREQ="Нужно:      рабочее дерево должно быть чистым; SHA последующих меняются; авто-abort при конфликте"
MSG_SQUASH_DIRTY_TREE="В рабочем дереве есть незакоммиченные изменения; сначала сделай commit или stash."
MSG_SQUASH_COUNT_PROMPT="Сколько сжать (включая этот commit, по умолчанию 2): "
MSG_SQUASH_MIN_TWO="Нужно минимум 2 commit чтобы squash имел смысл."
MSG_SQUASH_TOO_MANY_FMT='У этого commit только %d предок(ов) включая его самого; максимум %d.\n'
MSG_SQUASH_PREVIEW_FMT='Будут сжаты эти %d commit (старый → новый):\n'
MSG_SQUASH_MSG_PROMPT="Новое сообщение commit (по строке; одна Q для отправки; одиночная Q = открыть редактор со стандартной конкатенацией; :q для отмены):"
MSG_SQUASH_CANCELLED="Отменено."
MSG_SQUASH_CONTINUE="Продолжить?"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit (удалить этот commit из истории)"
MSG_DROP_PURPOSE="Что:        убрать этот commit из истории ветки; последующие commit переигрываются (новые SHA)"
MSG_DROP_WHEN="Когда:      случайный commit (пароли / отладочный код) / бесполезный WIP / дубликат / эксперимент на стирание"
MSG_DROP_CONTRAST="Примечание: revert добавляет обратный commit (сохраняет историю); drop по-настоящему удаляет (переписывает историю)"
MSG_DROP_DIRTY_TREE="В рабочем дереве есть незакоммиченные изменения; сначала сделай commit или stash."
MSG_DROP_NOT_ANCESTOR_FMT='%s не в цепочке предков текущей ветки.\n'
MSG_DROP_ROOT_COMMIT_FMT='%s — корневой commit, без родителя; rebase не может его удалить.\n'
MSG_DROP_ROOT_HINT="Настоящее удаление корневого commit требует git update-ref и т.п.; делай вручную."
MSG_DROP_WILL_REMOVE="Будут удалены:"
MSG_DROP_DOWNSTREAM_FMT='%d последующих commit будут переиграны (SHA изменятся):\n'
MSG_DROP_DOWNSTREAM_HINT="  (если последующие изменения зависят от этого commit → авто-abort при конфликте)"
MSG_DROP_IS_HEAD_NOTE="(этот commit — HEAD → быстрый путь через git reset --hard HEAD~; без rebase)"
MSG_DROP_CONFIRM="Подтвердить удаление?"
MSG_DROP_DONE_HEAD="Готово. HEAD передвинут на предыдущий commit."
MSG_DROP_DONE_REBASE="Готово. Commit удалён из истории."

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup (влить изменения рабочего дерева в этот commit)"
MSG_FIXUP_PURPOSE="Что:        создать fixup commit + autosquash, влив изменения рабочего дерева в этот commit"
MSG_FIXUP_WHEN="Когда:      ты поправил файлы и хочешь, чтобы они попали в старый commit (очень частый случай); избегать загрязнения истории"
MSG_FIXUP_PREREQ="Нужно:      в рабочем / staging-дереве должны быть изменения; авто-abort при конфликте"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s не в цепочке предков текущей ветки.\n'
MSG_FIXUP_NO_CHANGES="Рабочее дерево чистое; вливать нечего."
MSG_FIXUP_WORKFLOW_HINT="Поток: поправь файлы → используй это меню → выбери целевой commit → авто fixup + autosquash."
MSG_FIXUP_WILL_FOLD="Изменения для вливания в этот commit:"
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="В индексе уже есть содержимое; включить также unstaged изменения? [y/N] "
MSG_FIXUP_ASK_ADD_ALL="Индекс пуст; сделать git add -A и затем fixup? [Y/n] "
MSG_FIXUP_EMPTY_INDEX="Индекс пуст; делать fixup нечем; отменено."
MSG_FIXUP_TARGET_FMT='Цель: %s  "%s"\n'
MSG_FIXUP_CONFIRM="Подтвердить fixup + autosquash? [Y/n] "
MSG_FIXUP_CANCELLED="Отменено; состояние индекса сохранено."
MSG_FIXUP_CREATED="  + fixup commit создан"
MSG_FIXUP_DONE_FMT='Готово. Изменения влиты в %s (SHA обновлён после autosquash).\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup (влить этот commit в предка)"
MSG_CFIX_PURPOSE="Что:        взять этот commit и применить как fixup к более раннему commit в той же ветке"
MSG_CFIX_WHEN="Когда:      исправление на HEAD на самом деле относится к более раннему commit; верни его на место"
MSG_CFIX_CONTRAST="Примечание: fixup.sh использует изменения рабочего дерева; это меню — существующий commit"
MSG_CFIX_DIRTY_TREE="В рабочем дереве есть незакоммиченные изменения; сначала сделай commit или stash."
MSG_CFIX_NOT_ANCESTOR_SRC="Исходный commit не в цепочке предков текущей ветки."
MSG_CFIX_HEADER="Влить этот commit (fixup) в другой commit."
MSG_CFIX_TARGET_HINT="Цель должна быть предком источника (раньше в истории). Подсказка: скопируй SHA цели из Zed Graph."
MSG_CFIX_TARGET_PROMPT="SHA целевого commit (короткий или полный): "
MSG_CFIX_NO_INPUT="Нет ввода; отменено."
MSG_CFIX_INVALID_SHA_FMT='Недопустимый SHA: %s\n'
MSG_CFIX_SAME_COMMIT="Цель и источник совпадают; бессмысленно."
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s не является предком исходного commit (нельзя сделать fixup на него).\n'
MSG_CFIX_PREVIEW="─── превью ───"
MSG_CFIX_SOURCE_LABEL="Источник:"
MSG_CFIX_TARGET_LABEL="Цель:"
MSG_CFIX_RANGE_LABEL="диапазон rebase (старый → новый):"
MSG_CFIX_CONTINUE="Продолжить?"
MSG_CFIX_DONE="Готово. Источник влит в цель (SHA целевого commit обновлён)."

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto (rebase ветки A на ветку B)"
MSG_RBO_PURPOSE="Что:        git switch A && git rebase B; эксклюзивные commit A переигрываются на верхушке B"
MSG_RBO_WHEN="Когда:      A — feature-ветка, B — main/develop; подтянуть A к свежайшему B"
MSG_RBO_NOTE="Примечание: commit A переписываются (новые SHA); авто-abort при конфликте"
MSG_RBO_DIRTY_TREE="В рабочем дереве есть незакоммиченные изменения; сначала сделай commit или stash."
MSG_RBO_LOCAL_BRANCHES="Локальные ветки:"
MSG_RBO_A_PROMPT_FMT='Ветка A (которую rebase-им; Enter = текущая %s): '
MSG_RBO_DETACHED_ERR="Сейчас на detached HEAD; ветку A нужно явно назвать."
MSG_RBO_NO_LOCAL_FMT='Нет локальной ветки с именем: %s\n'
MSG_RBO_B_PROMPT="Ветка B (цель rebase; локальная / удалённая / tag): "
MSG_RBO_NO_INPUT="Нет ввода; отменено."
MSG_RBO_INVALID_REF_FMT='Недопустимая целевая ref: %s\n'
MSG_RBO_SAME="A и B указывают на один commit; rebase-ить нечего."
MSG_RBO_PREVIEW="─── Превью ───"
MSG_RBO_NO_EXCLUSIVE="У A нет commit поверх B (A является предком B, или совпадает)."
MSG_RBO_FF_OR_NOOP="rebase будет fast-forward или no-op."
MSG_RBO_REPLAY_FMT='Commit A для переигрывания (%d):\n'
MSG_RBO_CONFIRM_FMT='Выполнить: git switch %s && git rebase %s ?'
MSG_RBO_SWITCHING_FMT='Переключаюсь на %s...\n'
MSG_RBO_DONE="Готово."

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag (поставить tag на этот commit)"
MSG_TAG_PURPOSE="Что:        создать lightweight или annotated tag, указывающий на этот commit; опционально запушить на remote"
MSG_TAG_WHEN="Когда:      релизная точка / веха / стабильная именованная ссылка на commit"
MSG_TAG_CONTRAST="Примечание: annotated несёт сообщение+автора+время (рекомендуется для релизов); lightweight — просто ref"
MSG_TAG_NAME_PROMPT="Имя tag (например, v1.0.0 / release-2024-01): "
MSG_TAG_NO_INPUT="Нет ввода; отменено."
MSG_TAG_EXISTS_FMT='Tag уже существует: %s\n'
MSG_TAG_KIND_PROMPT="annotated (с сообщением) или lightweight? [a]/l (по умолчанию a): "
MSG_TAG_MSG_PROMPT="Сообщение tag (Enter = взять имя tag): "
MSG_TAG_CREATED_FMT='Создан tag: %s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='Запушить на remote [%s]? [y/N] '
MSG_TAG_NO_REMOTE="(remote не настроен; пропускаю push)"
MSG_TAG_REFRESH_HINT="Примечание: Zed Git Graph не отслеживает изменения tag; обнови вручную (Cmd+Shift+P → reload window, или дождись следующего commit)."

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete (удалить tag)"
MSG_TAG_DELETE_PURPOSE="Что:        удалить локальный tag; опционально удалить и на remote"
MSG_TAG_DELETE_WHEN="Когда:      плохой tag / переиздание / уборка"
MSG_TAG_DELETE_NOTE="Примечание: удаление запушенного remote tag затрагивает других; локально + remote запрашиваются отдельно"
MSG_TAG_DELETE_AT_HEADER="Tag на этом commit:"
MSG_TAG_DELETE_NONE="  (нет)"
MSG_TAG_DELETE_NAME_PROMPT="Имя tag для удаления (может быть на другом commit): "
MSG_TAG_DELETE_NO_INPUT="Нет ввода; отменено."
MSG_TAG_DELETE_NOT_EXIST_FMT='Tag не существует: %s\n'
MSG_TAG_DELETE_ANNOTATED="(annotated tag)"
MSG_TAG_DELETE_PREVIEW_FMT="tag '%s' → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="Удалить локальный tag '%s'?"
MSG_TAG_DELETE_LOCAL_DONE="Локальный tag удалён."
MSG_TAG_DELETE_NO_REMOTE="(remote не настроен; пропускаю remote)"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="(такого tag нет на remote [%s]; пропускаю)\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="Удалить также с remote [%s]? [y/N] "
MSG_TAG_DELETE_REMOTE_DONE="Remote tag удалён."

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="Что:        переключиться на этот commit в новом worktree, сгруппированном по назначению"
MSG_WT_FROM_NOTE_FMT='назначение: %s'
MSG_WT_FROM_PATH_EXISTS_FMT='Путь уже существует: %s\n'
MSG_WT_FROM_PATH_HINT="Подсказка: выполни  git worktree list  чтобы посмотреть существующие worktree"
MSG_WT_FROM_BRANCH_EXISTS_FMT='Ветка уже существует: %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree создан: %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  ветка: %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  очистка: git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  очистка: git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='Имя ветки (Enter = %s): '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="Что:        перечислить worktree под [%s] и дать вставить имя для удаления"
MSG_WT_RM_USAGE_FMT="Как:        просмотри список, вставь имя (включая префикс %s/), затем подтверди"
MSG_WT_RM_EMPTY_FMT='[%s] не имеет worktree для удаления.\n'
MSG_WT_RM_LIST_HEADER_FMT='[%s] worktrees:\n'
MSG_WT_RM_NAME_PROMPT="Вставь имя worktree для удаления (скопируй целую строку выше): "
MSG_WT_RM_NO_INPUT="Нет ввода; отменено."
MSG_WT_RM_NOT_IN_LIST_FMT="'%s' не в списке worktree [%s].\n"
MSG_WT_RM_REMOVING_FMT='Удаляю: %s\n'
MSG_WT_RM_DONE="✓ worktree удалён."
MSG_WT_RM_REVIEW_NO_BRANCH="(review — detached; ветку чистить не нужно)"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="Удалить также локальную ветку '%s'? [y/N] "
MSG_WT_RM_BRANCH_DONE="✓ Локальная ветка удалена."
MSG_WT_RM_BRANCH_ABSENT_FMT="(ветки '%s' не существует; возможно, уже удалена через git worktree remove)\n"

# ── branch-checkout.sh ──────────────────────────────────────────
MSG_BRANCH_CHECKOUT_TITLE="branch-checkout (переключиться на branch, указывающий на этот commit)"
MSG_BRANCH_CHECKOUT_PURPOSE="Что:   переключить HEAD на локальный branch, который указывает на этот commit"
MSG_BRANCH_CHECKOUT_WHEN="Когда: перейти на существующий branch из Git Graph вместо копирования имени в терминал"
MSG_BRANCH_CHECKOUT_NOTE="Заметка: нужен чистый working tree; не переключит, если уже на выбранном branch"
MSG_BRANCH_CHECKOUT_DIRTY_TREE="В working tree есть незакоммиченные изменения; сначала commit или stash."
MSG_BRANCH_CHECKOUT_NONE="На этом commit нет локальных branch для переключения."
MSG_BRANCH_CHECKOUT_ONE_FMT='Единственный branch на этом commit: %s\n'
MSG_BRANCH_CHECKOUT_LIST_HEADER="Локальные branch на этом commit:"
MSG_BRANCH_CHECKOUT_SELECT_PROMPT="Выбери один (имя branch или номер): "
MSG_BRANCH_CHECKOUT_NO_INPUT="Нет ввода; отменено."
MSG_BRANCH_CHECKOUT_NOT_IN_LIST_FMT="Branch '%s' не в списке на этом commit.\n"
MSG_BRANCH_CHECKOUT_ALREADY_FMT='Ты уже на %s; делать нечего.\n'

# ── branch-rename.sh ────────────────────────────────────────────
MSG_BRANCH_RENAME_TITLE="branch-rename (переименовать branch, указывающий на этот commit)"
MSG_BRANCH_RENAME_PURPOSE="Что:   переименовать локальный branch; опционально перезалить на remote (удалить старое имя, push новое)"
MSG_BRANCH_RENAME_WHEN="Когда: исправить опечатку / переназначить try/* / стандартизировать имя"
MSG_BRANCH_RENAME_NOTE="Заметка: переименование на remote — две операции (push нового + удаление старого); согласуй с коллегами"
MSG_BRANCH_RENAME_NONE="На этом commit нет локальных branch для переименования."
MSG_BRANCH_RENAME_ONE_FMT='Единственный branch на этом commit: %s\n'
MSG_BRANCH_RENAME_LIST_HEADER="Локальные branch на этом commit:"
MSG_BRANCH_RENAME_SELECT_PROMPT="Выбери один для переименования (имя branch или номер): "
MSG_BRANCH_RENAME_NO_INPUT="Нет ввода; отменено."
MSG_BRANCH_RENAME_NOT_IN_LIST_FMT="Branch '%s' не в списке на этом commit.\n"
MSG_BRANCH_RENAME_NEW_NAME_PROMPT="Новое имя: "
MSG_BRANCH_RENAME_INVALID_NAME_FMT="Недопустимое имя branch: %s\n"
MSG_BRANCH_RENAME_EXISTS_FMT="Branch уже существует: %s\n"
MSG_BRANCH_RENAME_DONE_FMT="Переименовано: %s → %s\n"
MSG_BRANCH_RENAME_REMOTE_PROMPT_FMT="Переименовать также на remote [%s] (push новое + удалить старое)? [y/N] "
MSG_BRANCH_RENAME_REMOTE_DONE="Переименование на remote выполнено."

# ── copy-branch-name.sh ─────────────────────────────────────────
MSG_COPY_BRANCH_TITLE="copy-branch-name (копировать имя branch с этого commit в буфер обмена)"
MSG_COPY_BRANCH_PURPOSE="Что:   положить имя branch в системный буфер обмена для вставки в другом месте"
MSG_COPY_BRANCH_WHEN="Когда: отправить имя в чат / вставить в описание PR / использовать в другом терминале"
MSG_COPY_BRANCH_NOTE="Заметка: использует pbcopy (macOS) / wl-copy / xclip / xsel — что доступно"
MSG_COPY_BRANCH_NONE="На этом commit нет локальных branch для копирования."
MSG_COPY_BRANCH_LIST_HEADER="Локальные branch на этом commit:"
MSG_COPY_BRANCH_SELECT_PROMPT="Выбери один (имя branch или номер): "
MSG_COPY_BRANCH_NO_INPUT="Нет ввода; отменено."
MSG_COPY_BRANCH_NOT_IN_LIST_FMT="Branch '%s' не в списке на этом commit.\n"
MSG_COPY_BRANCH_DONE_FMT="Скопировано: %s\n"
MSG_COPY_BRANCH_NO_CLIPBOARD="Утилита буфера обмена не найдена (нужен pbcopy / wl-copy / xclip / xsel). Имя branch напечатано ниже:"

# ── copy-commit-message.sh ──────────────────────────────────────
MSG_COPY_MSG_TITLE="copy-commit-message (копировать message этого commit в буфер обмена)"
MSG_COPY_MSG_PURPOSE="Что:   положить subject commit (одна строка) или полный message в системный буфер обмена"
MSG_COPY_MSG_WHEN="Когда: вставить в release note / PR / чат / email"
MSG_COPY_MSG_NOTE="Заметка: использует pbcopy (macOS) / wl-copy / xclip / xsel — что доступно"
MSG_COPY_MSG_KIND_PROMPT="Копировать [s]ubject (по умолчанию) / [f]ull message: "
MSG_COPY_MSG_KIND_INVALID_FMT="Недопустимый выбор: %s\n"
MSG_COPY_MSG_DONE_FMT='Скопировано: %s\n'
MSG_COPY_MSG_NO_CLIPBOARD="Утилита буфера обмена не найдена (нужен pbcopy / wl-copy / xclip / xsel). Message напечатан ниже:"
