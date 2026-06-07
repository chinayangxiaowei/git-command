#!/usr/bin/env bash
# 中文（繁體）選單 label for tasks.json（精簡但保留表達力）。
# Loaded by sync-tasks.sh; substituted into tasks.json placeholders __LABEL_*__.
# 用單引號 — $ZED_GIT_SHA_SHORT 等必須以字面形式留給 Zed 解析。
#
# 設計原則:
#   1. label 極簡 — 動詞 + 核心受詞；詳細說明放在腳本的 show_intro 裡執行時再顯示
#   2. commit 上下文已由右鍵來源隱含，不重複 "此 commit"
#   3. 保留 git 行業術語（Squash / Fixup / Rebase / Stash / Cherry-pick / Revert / Reword），
#      用中文雙字動詞修飾（"重寫"、"刪除"、"匯出"、"建立"），避免單字動詞
# shellcheck shell=bash disable=SC2034

# ── 1. 檢視 ─────────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. 檢視 ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · 包含的 branch'
LABEL_VIEW_TAGS_CONTAINING='Git · 包含的 tag'
LABEL_VIEW_STAT='Git · 概覽 stat'
LABEL_VIEW_DIFF='Git · 完整 diff'
LABEL_VIEW_DIFF_HEAD='Git · 與 HEAD 比對'
LABEL_VIEW_OPEN_FILES='Git · 開啟相關檔案'
LABEL_VIEW_EXPORT_FILES='Git · 匯出相關檔案'
LABEL_VIEW_EXPORT_PATCHES='Git · 匯出 patch'

# ── 2. 修改 ─────────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. 修改 ────'
LABEL_MODIFY_REWORD='Git · 重寫 message'
LABEL_MODIFY_EDIT_COMMIT='Git · 編輯 commit'

# ── 3. 歷史重寫 ──────────────────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. 歷史重寫 ────'
LABEL_REWRITE_SQUASH='Git · Squash 前 N 筆'
LABEL_REWRITE_DROP='Git · Drop 此 commit'
LABEL_REWRITE_INTERACTIVE='Git · 互動式 rebase'
LABEL_REWRITE_RESET_SOFT='Git · 軟重置'
LABEL_REWRITE_RESET_HARD='Git · 硬重置 ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup 併入此 commit'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fixup 進祖先 commit'

# ── 5. 複製 / 還原 ───────────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. 複製 / 還原 ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. 分支 ─────────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. 分支 ────'
LABEL_BRANCH_FROM='Git · 建立 branch'
LABEL_BRANCH_TRY='Git · 試做 branch'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase A 到 B'
LABEL_BRANCH_DELETE='Git · 刪除 branch'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · 建立 tag'
LABEL_TAG_DELETE='Git · 刪除 tag'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash 目前變更'
LABEL_STASH_POP='Git · Pop 最近 stash'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree ────'
LABEL_WT_REVIEW='Worktree · review'
LABEL_WT_TRY='Worktree · try'
LABEL_WT_FIX='Worktree · fix'
LABEL_WT_FEAT='Worktree · feat'
LABEL_WT_HOT='Worktree · hot'
LABEL_WT_RM_REVIEW='Worktree · 移除 review'
LABEL_WT_RM_TRY='Worktree · 移除 try'
LABEL_WT_RM_FIX='Worktree · 移除 fix'
LABEL_WT_RM_FEAT='Worktree · 移除 feat'
LABEL_WT_RM_HOT='Worktree · 移除 hot'
