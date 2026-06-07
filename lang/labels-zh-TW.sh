#!/usr/bin/env bash
# 繁體中文（台灣）選單 label for tasks.json.
# Loaded by sync-tasks.sh; substituted into tasks.json placeholders __LABEL_*__.
# 用單引號 — $ZED_GIT_SHA_SHORT 等必須以字面形式留給 Zed 解析。
# shellcheck shell=bash disable=SC2034

# ── 1. 檢視 / 瀏覽 ──────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. 檢視 / 瀏覽 ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · 包含此 commit 的分支  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · 包含此 commit 的 tag  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · 此 commit 概覽 (stat)  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · 此 commit 完整 diff  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · 與 HEAD 比較  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · 在 Zed 開啟此 commit 涉及的所有檔案  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · 匯出此 commit 涉及的檔案到資料夾（快照）  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · 將此 commit 往前 N 條匯出為 patch 檔案  ($ZED_GIT_SHA_SHORT)'

# ── 2. 修改此 commit ────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. 修改此 commit ────'
LABEL_MODIFY_REWORD='Git · 重寫此 commit 的 message  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · 編輯此 commit（改 message / 新增-移除檔案）  ($ZED_GIT_SHA_SHORT)'

# ── 3. 改寫歷史（rebase 類）─────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. 改寫歷史（rebase 類）────'
LABEL_REWRITE_SQUASH='Git · 從此 commit 往前合併 N 條 (squash)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · 從歷史中刪除此 commit (drop)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · 互動式 rebase 到此 commit 之前  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · 軟重置到此 commit（變更入暫存區）  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · 硬重置到此 commit（具破壞性）  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. 把變更併進此 commit (fixup 類) ────'
LABEL_FIXUP_INTO_THIS='Git · 把工作區/暫存區變更併入此 commit (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · 把此 commit 折疊進某個祖先 commit (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. 複製 / 撤銷 ──────────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. 複製 / 撤銷 ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick 到目前分支  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · Revert 此 commit  ($ZED_GIT_SHA_SHORT)'

# ── 6. 分支 ─────────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. 分支 ────'
LABEL_BRANCH_FROM='Git · 從此 commit 建立新分支  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · 從此 commit 建立一次性試做分支  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · 把分支 A rebase 到分支 B 上 (CLion 風格)'
LABEL_BRANCH_DELETE='Git · 刪除指向此 commit 的本地分支（可選遠端）  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · 為此 commit 打 tag  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · 刪除 tag（本地+可選遠端）  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash 目前變更（帶名稱）'
LABEL_STASH_POP='Git · Pop 最近的 stash'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree（在新資料夾檢出此 commit）────'
LABEL_WT_REVIEW='Worktree · review  (detached，唯讀檢視)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (一次性試做分支)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (修 bug)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (新功能)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · 刪除  review  (貼上名稱確認)'
LABEL_WT_RM_TRY='Worktree · 刪除  try     (貼上名稱確認)'
LABEL_WT_RM_FIX='Worktree · 刪除  fix     (貼上名稱確認)'
LABEL_WT_RM_FEAT='Worktree · 刪除  feat    (貼上名稱確認)'
LABEL_WT_RM_HOT='Worktree · 刪除  hot     (貼上名稱確認)'
