#!/usr/bin/env bash
# 日本語ラベル定義 tasks.json メニュー項目用 (簡潔形)。
# sync-tasks.sh が読み込み、tasks.json の __LABEL_*__ 部分に展開される。
# シングルクォート必須 — $ZED_GIT_SHA_SHORT などは Zed 用にリテラル維持。
#
# 設計方針: メニューラベルは最小限 — 動詞 + 中核名詞。commit コンテキストは
# 右クリック行から既に暗黙。詳細説明は各スクリプトの show_intro で実行時に表示。
# shellcheck shell=bash disable=SC2034

# ── 1. 表示 ─────────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. 表示 ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · 含むbranch'
LABEL_VIEW_TAGS_CONTAINING='Git · 含むtag'
LABEL_VIEW_STAT='Git · stat'
LABEL_VIEW_DIFF='Git · diff'
LABEL_VIEW_DIFF_HEAD='Git · diff vs HEAD'
LABEL_VIEW_OPEN_FILES='Git · ファイルを開く'
LABEL_VIEW_EXPORT_FILES='Git · ファイル出力'
LABEL_VIEW_EXPORT_PATCHES='Git · パッチ出力'

# ── 2. 変更 ───────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. 変更 ────'
LABEL_MODIFY_REWORD='Git · Reword'
LABEL_MODIFY_EDIT_COMMIT='Git · commit編集'

# ── 3. 履歴書換 ──────────────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. 履歴書換 ────'
LABEL_REWRITE_SQUASH='Git · Squash N'
LABEL_REWRITE_DROP='Git · Drop'
LABEL_REWRITE_INTERACTIVE='Git · Rebase -i'
LABEL_REWRITE_RESET_SOFT='Git · Reset soft'
LABEL_REWRITE_RESET_HARD='Git · Reset hard ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup先'
LABEL_FIXUP_INTO_ANCESTOR='Git · 祖先へFixup'

# ── 5. 複製 / 取消 ──────────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. 複製 / 取消 ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · 新規branch'
LABEL_BRANCH_TRY='Git · branch試行'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase A onto B'
LABEL_BRANCH_DELETE='Git · branch削除'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · tag作成'
LABEL_TAG_DELETE='Git · tag削除'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash'
LABEL_STASH_POP='Git · Stash Pop'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree ────'
LABEL_WT_REVIEW='Worktree · review'
LABEL_WT_TRY='Worktree · try'
LABEL_WT_FIX='Worktree · fix'
LABEL_WT_FEAT='Worktree · feat'
LABEL_WT_HOT='Worktree · hot'
LABEL_WT_RM_REVIEW='Worktree · review削除'
LABEL_WT_RM_TRY='Worktree · try削除'
LABEL_WT_RM_FIX='Worktree · fix削除'
LABEL_WT_RM_FEAT='Worktree · feat削除'
LABEL_WT_RM_HOT='Worktree · hot削除'
