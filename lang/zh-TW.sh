#!/usr/bin/env bash
# 中文（繁體・台灣）文案 for git-command scripts.
# Loaded by lib.sh; do not invoke directly.
# 命名規範: MSG_<SCRIPT>_<KEY>；帶 %s 內插的用 _FMT 後綴。
# shellcheck shell=bash

# ── lib.sh (共用內部) ───────────────────────────────────────────
MSG_LIB_IN_PROGRESS_FMT='已有未完成的 %s。請先用「%s」或 --continue 處理掉再試。\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s 失敗，自動執行 git %s --abort（工作區已回復到操作前）。\n'
MSG_LIB_NOT_IN_REPO='不在 git repo 內。'
MSG_LIB_NOT_BARE_LAYOUT='目前不在 bare + worktrees 配置下，worktree 選單已停用。'
MSG_LIB_INIT_HINT='如需啟用，新專案請執行: bash git-command/init-bare-tree.sh <name> [<url>]'
MSG_LIB_MIGRATE_HINT='既有專案請用 migrate-to-bare-tree.sh（尚未實作，請先手動遷移）。'
MSG_LIB_CLEANUP_FMT='指令稿異常結束 (exit %d)，自動執行 git %s --abort 回復到操作前。\n'
MSG_LIB_PRESS_ENTER="── 按 Enter 關閉 ──"

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword（重寫此 commit 的 message）"
MSG_REWORD_PURPOSE="作用: 只改 commit message，檔案內容/SHA 關係不變（下游 SHA 會被改寫）"
MSG_REWORD_WHEN="情境: typo 修正 / 改成規範格式 / 加 issue 引用 / 改 conventional commit 前綴"
MSG_REWORD_CONTRAST="對比: HEAD 的 message → 直接 edit-commit 比較快；舊 commit 只改 message 用這個"
MSG_REWORD_DIRTY_TREE="工作區有未提交的變更，請先 commit 或 stash。"
MSG_REWORD_NOT_ANCESTOR_FMT='%s 不在目前分支的祖先鏈上，無法 reword。\n'
MSG_REWORD_OLD_MSG="原 message："
MSG_REWORD_NEW_MSG_PROMPT="新 message（逐行輸入；空行 = 段落分隔；單獨一行 Q 送出，:q 取消）："
MSG_REWORD_CANCELLED="已取消。"
MSG_REWORD_EMPTY_CANCELLED="未輸入任何內容，已取消。"

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files（在 Zed 開啟此 commit 涉及的所有檔案）"
MSG_OPEN_FILES_PURPOSE="作用: 列出此 commit 變更過的檔案，並在 Zed 中全部開啟（目前 working 版本）"
MSG_OPEN_FILES_WHEN="情境: 除錯歷史 bug，想看那次變更牽涉的所有檔案"
MSG_OPEN_FILES_PREREQ="前置: PATH 內要有 zed 指令；目前不存在的檔案會略過"
MSG_OPEN_FILES_EMPTY="此 commit 沒有檔案變更（可能是空 commit）。"
MSG_OPEN_FILES_MISSING="以下檔案在目前工作區不存在（已刪除/已重新命名），略過："
MSG_OPEN_FILES_ALL_GONE="此 commit 涉及的檔案在目前工作區都已不存在。"
MSG_OPEN_FILES_OPENING_FMT='將在 Zed 中開啟 %d 個檔案：\n'
MSG_OPEN_FILES_NO_ZED="找不到 zed 指令。"
MSG_OPEN_FILES_INSTALL_HINT="請在 Zed 內: Cmd+Shift+P → 'zed: install cli' 將 zed 指令安裝到 PATH。"

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files（匯出此 commit 涉及的檔案到資料夾）"
MSG_EXPORT_FILES_PURPOSE="作用: 把此 commit 變更的每個檔案「在此 commit 當下的版本」複製到指定資料夾，保留路徑結構"
MSG_EXPORT_FILES_WHEN="情境: 檔案太多不想全開分頁 / 取出某 commit 的產物快照 / 離線比對"
MSG_EXPORT_FILES_CONTRAST="區別: open-files 在 Zed 開啟目前 working 版本；本選單則匯出此 commit 當下的歷史版本"
MSG_EXPORT_FILES_EMPTY="此 commit 沒有檔案變更（可能是空 commit）。"
MSG_EXPORT_FILES_COUNT_FMT='此 commit 涉及 %d 個檔案：\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... 還有 %d 個\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='匯出資料夾（相對於 repo 根，預設 %s）：'
MSG_EXPORT_FILES_DIR_EXISTS_FMT='資料夾已存在且非空：%s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="繼續會覆蓋裡面同名檔案，要繼續嗎？"
MSG_EXPORT_FILES_DELETED_HINT="(此 commit 中已被刪除，沒有內容可匯出)"
MSG_EXPORT_FILES_DONE_FMT='完成：匯出 %d 個，略過 %d 個 → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="提示：匯出資料夾內是此 commit 當下的快照，不是目前 working 版本。"

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches（匯出 N 個 patch 檔案）"
MSG_EXPORT_PATCHES_PURPOSE="作用: 從此 commit 往前匯出 N 條，可選 mbox (.patch) 或純 diff (.diff)"
MSG_EXPORT_PATCHES_WHEN="情境: 透過 email 協作 / 備份特定變更 / 交給他人用 git am / git apply 接收"
MSG_EXPORT_PATCHES_OUTPUT="輸出: 自訂資料夾（預設 ./patches）；不會修改任何歷史"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="格式 [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply)（預設 f）："
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='無效的格式：%s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="匯出幾條（從此 commit 往前 N 條，預設 1）："
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='無效的數量：%s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="輸出資料夾（相對於 repo 根，預設 ./patches）："
MSG_EXPORT_PATCHES_FORMAT_LABEL="格式："
MSG_EXPORT_PATCHES_RANGE_LABEL="範圍："
MSG_EXPORT_PATCHES_OUTPUT_LABEL="輸出："
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(根目錄)"
MSG_EXPORT_PATCHES_CONTINUE="繼續？"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft（軟重置到此 commit · 變更保留至暫存區）"
MSG_RESET_SOFT_PURPOSE="作用: HEAD 移到此 commit；中間 commits 的變更會落到暫存區，不會遺失"
MSG_RESET_SOFT_WHEN="情境: 想重新整理最後 N 條 commit（重新切塊 / 改 message / 合併）"
MSG_RESET_SOFT_AFTER="之後: 用 git status 檢視暫存區，再 commit 出新的歷史"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s 不在 HEAD 祖先鏈上，soft reset 沒有意義。\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s 就是 HEAD，不需要 reset。\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='目前分支：%s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='將丟掉以下 commit（其變更落到暫存區，HEAD → %s）：\n'
MSG_RESET_SOFT_CONFIRM_FMT='soft reset 到 %s？'
MSG_RESET_SOFT_DONE="完成。變更已在暫存區，可用 git status 檢視，再 git commit 重新提交。"

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard（硬重置到此 commit · 具破壞性）"
MSG_RESET_HARD_PURPOSE="作用: HEAD 移到此 commit；丟棄中間 commits + 工作區所有變更"
MSG_RESET_HARD_WHEN="情境: 徹底回復到某狀態，且確認不需要保留任何中間變更"
MSG_RESET_HARD_AFTER="後果: 不可復原（除非 30 天內 git reflog 還有；必須輸入全大寫 YES 才會執行）"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s 不在 HEAD 祖先鏈上，拒絕執行。\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s 就是 HEAD，不需要 reset。\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='目前分支：%s\n'
MSG_RESET_HARD_WILL_DROP="將丟掉以下 commit（不可復原，除非透過 reflog）："
MSG_RESET_HARD_WT_LOST="工作區變更也會一併被丟棄："
MSG_RESET_HARD_YES_PROMPT_FMT='請輸入 YES（全大寫）以確認硬重置到 %s：'
MSG_RESET_HARD_NO_YES="未輸入 YES，已取消。"
MSG_RESET_HARD_REFLOG_HINT="提示：reflog 還能救回這些 commit，30 天內可用 git reflog 查 HEAD@{N}。"

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i（互動式 rebase 到此 commit 之前）"
MSG_REBASE_I_PURPOSE='作用: 啟動 git rebase -i SHA^，開啟 $EDITOR 讓你手動編輯 todo'
MSG_REBASE_I_WHEN="情境: 想手動重排/合併/編輯/drop 多條 commit；超出標準選單能涵蓋的複雜操作"
MSG_REBASE_I_PREREQ="前置: 工作區必須乾淨；中途遇到衝突請自行處理，或由選單兜底 abort"
MSG_REBASE_I_RANGE_FMT='將啟動互動式 rebase，範圍：%s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="工作區有未提交的變更，請先 commit 或 stash。"
MSG_REBASE_I_CONTINUE="繼續？"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert（產生反向 commit 以撤銷此 commit）"
MSG_REVERT_PURPOSE="作用: 不改寫歷史，在 HEAD 之上加一條新 commit，內容與此 commit 相反"
MSG_REVERT_WHEN="情境: 已 push 過的 commit 想撤銷（不能用 reset 改公共歷史）"
MSG_REVERT_CONTRAST="對比: reset 是改寫歷史，revert 是追加歷史；衝突時自動 abort"
MSG_REVERT_DIRTY_TREE="工作區有未提交的變更，請先 commit 或 stash。"
MSG_REVERT_CONFIRM_FMT='要在 HEAD 之上產生反向 commit 以撤銷 %s 嗎？\n'

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick（複製此 commit 到目前分支頂端）"
MSG_CHERRY_PICK_PURPOSE="作用: 把此 commit 的變更複製到目前分支頂端，形成新 commit（新 SHA）"
MSG_CHERRY_PICK_WHEN="情境: 跨分支搬 hotfix / 從同事分支撿一條過來 / 從 reflog 救回 commit"
MSG_CHERRY_PICK_NOTE="注意: 來源 commit 不會被刪除；同分支沒意義；衝突時自動 abort"
MSG_CHERRY_PICK_CURRENT_FMT='目前分支：%s\n'
MSG_CHERRY_PICK_DIRTY_TREE="工作區有未提交的變更，請先 commit 或 stash。"
MSG_CHERRY_PICK_CONFIRM_FMT='將 %s cherry-pick 到 %s？'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from（從此 commit 建立新分支）"
MSG_BRANCH_FROM_PURPOSE="作用: 在此 commit 建立新分支並切換過去"
MSG_BRANCH_FROM_WHEN="情境: 想從舊 commit 開一條新支線 / 為特定狀態保留命名 ref"
MSG_BRANCH_FROM_CONTRAST="區別: 一次性試做請改用 try-branch（自動 try/ 前綴 + 清理提示）"
MSG_BRANCH_FROM_NAME_PROMPT="新分支名稱（基於此 commit）："
MSG_BRANCH_FROM_NO_NAME="未輸入分支名稱，已取消。"

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch（從此 commit 建立一次性試做分支）"
MSG_TRY_BRANCH_PURPOSE="作用: 在此 commit 建立 try/<base-slug>-<sha> 分支並立即切換過去"
MSG_TRY_BRANCH_WHEN="情境: 想試做但不想汙染目前分支 / 檢視某舊 commit 的狀態"
MSG_TRY_BRANCH_HINT="提示: 結束時會印出「回到原分支」+「刪除此分支」的指令，避免用完忘了清理"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # 先前是 detached，請查 reflog"
MSG_TRY_BRANCH_FROM_FMT='原分支：%s\n起點：  %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='新分支名稱（Enter = %s）：'
MSG_TRY_BRANCH_EXISTS_FMT='分支已存在：%s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="建立後立即切換過去？[Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='已建立 %s（未切換）\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="用完後請以下列指令清理："
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  回到原分支：    %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  刪除此分支：    git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push（將目前變更收進帶名稱的 stash）"
MSG_STASH_PUSH_PURPOSE="作用: 把已追蹤檔案的變更收進 stash，工作區回到乾淨狀態；可加上名稱方便日後查找"
MSG_STASH_PUSH_WHEN="情境: 要切換分支但有 WIP 變更 / 暫時放下手邊工作 / 在 reset 前清乾淨工作區"
MSG_STASH_PUSH_NOTE="說明: 不加 -u，untracked 檔案留在工作區（避免 Git Graph 多出 untracked snapshot 節點）"
MSG_STASH_PUSH_CLEAN="工作區是乾淨的，沒有可 stash 的變更。"
MSG_STASH_PUSH_WILL_STASH="將 stash 下列變更："
MSG_STASH_PUSH_NAME_PROMPT="取個名稱（之後好辨識）："
MSG_STASH_PUSH_NO_NAME="未輸入名稱，已取消。"
MSG_STASH_PUSH_DONE_HINT="完成。檢視: git stash list，或使用選單「Pop 最近的 stash」。"
MSG_STASH_PUSH_UNTRACKED_NOTE="提示：未追蹤檔案（untracked）沒有被 stash，仍留在工作區。"

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop（套用最近的 stash 到工作區）"
MSG_STASH_POP_PURPOSE="作用: 將 stash@{0} 套用回工作區；成功則自動 drop 該 stash"
MSG_STASH_POP_WHEN="情境: 先前 stash 起來的變更需要拿回來繼續用"
MSG_STASH_POP_NOTE="注意: 發生衝突時 stash 不會自動 drop；請手動解衝突後再 git stash drop"
MSG_STASH_POP_EMPTY="目前沒有可 pop 的 stash。"
MSG_STASH_POP_LIST_HEADER="最近的 stash 列表："
MSG_STASH_POP_PREVIEW_HEADER="stash@{0} 內容預覽："
MSG_STASH_POP_CONFIRM="要把 stash@{0} pop 到目前工作區嗎？"
MSG_STASH_POP_CONFLICT="pop 發生衝突——stash 仍保留（不會自動 drop）。"
MSG_STASH_POP_CONFLICT_HINT="請解決衝突 + git add，再執行  git stash drop  將其丟棄。"

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete（刪除指向此 commit 的本地分支）"
MSG_BRANCH_DELETE_PURPOSE="作用: 刪除本地分支（可選同時刪除 remote 上的對應分支）"
MSG_BRANCH_DELETE_WHEN="情境: 清理已合併 / 試做完成的分支；批次清掉 try/* feat/* 等"
MSG_BRANCH_DELETE_NOTE="注意: 使用 git branch -D 強制刪除（不檢查是否已 merged）"
MSG_BRANCH_DELETE_NONE="此 commit 上沒有可刪除的本地分支。"
MSG_BRANCH_DELETE_ONE_FMT='此 commit 上唯一的分支: %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="此 commit 上的本地分支:"
MSG_BRANCH_DELETE_SELECT_PROMPT="選擇一個（分支名稱或編號）: "
MSG_BRANCH_DELETE_NO_INPUT="未輸入內容，已取消。"
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="分支 '%s' 不在指向此 commit 的分支列表中。\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="無法刪除目前所在的分支 '%s'。\n"
MSG_BRANCH_DELETE_CURRENT_HINT="請先切換到其他分支: git switch <other-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="刪除本地分支 '%s'？"
MSG_BRANCH_DELETE_LOCAL_DONE="本地分支已刪除。"
MSG_BRANCH_DELETE_NO_REMOTE="(未設定 remote，略過遠端)"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="(remote [%s] 上沒有此分支，略過)"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="也從 remote [%s] 刪除？[y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="遠端分支已刪除。"

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit（編輯此 commit 的後設資料 / 檔案清單）"
MSG_EDIT_COMMIT_HEAD_PATH="HEAD 路徑: 工作區可以髒；直接 amend；可改 message / 新增 / 移除 / 修改檔案"
MSG_EDIT_COMMIT_OLD_PATH="舊 commit 路徑: 工作區必須乾淨；適用於 message / 新增（untracked）/ 移除檔案"
MSG_EDIT_COMMIT_NOT_SUITED="不適用（舊 commit）: 修改既有檔案內容 → 請改用 fixup 選單（原因見指令稿頂部註解）"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="每行一個操作，輸入完畢後以單獨一行 'Q' 結束："
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:path/to/file    git add（新增 / 更新 / 暫存任何變化）"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:path/to/file    從此 commit 移除（磁碟上保留，git rm --cached）"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                 完成"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  skip 格式錯誤：%s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  skip +%s  (檔案不存在)\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  add  %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  skip +%s  (git add 失敗)\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  rm   %s  (已從 commit 移除，磁碟上保留)\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  skip -%s  (不在此 commit 中)\n'
MSG_EDIT_COMMIT_ASK_MSG="新 message（逐行輸入；單獨一行 Q 送出；只輸 Q = 維持原樣）："
MSG_EDIT_COMMIT_HEAD_HEADER="─── HEAD 快路徑 ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="目標就是 HEAD，不需要 rebase："
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · 工作區可以髒（變更會作為 amend 候選）"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · 可任意新增 / 修改 / 移除檔案，沒有下游衝突風險"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── 目前 message ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── 目前工作區/暫存區變更 ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="要改 message 嗎？[y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="要改檔案（新增/移除/修改）嗎？[y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="（沒有變更，不執行 amend，結束。）"
MSG_EDIT_COMMIT_UNSTAGED_HINT="提示：工作區還有未 git add 的變更，amend 不會包含進去。"
MSG_EDIT_COMMIT_AMEND_MSG_FILES="已 amend（新 message + 檔案變更）"
MSG_EDIT_COMMIT_AMEND_MSG="已 amend（新 message）"
MSG_EDIT_COMMIT_AMEND_FILES="已 amend（檔案變更）"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='工作區有未提交的變更。

若你想把這些變更併入此 commit → 請改用選單：
  「把工作區/暫存區變更併入此 commit (fixup+autosquash)」

若你確實要使用本選單（改 message / 加新檔案 / 移除檔案），請先 commit 或 stash。'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s 不在目前分支的祖先鏈上。\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── 舊 commit 路徑（rebase）───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="適用於：改 message / 新增檔案（untracked）/ 移除檔案"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="不適用於：修改既有檔案內容（請改用 fixup 選單）"
MSG_EDIT_COMMIT_OLD_CONTINUE="繼續？"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="rebase 沒有進入 edit 狀態。"
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── 目前 commit message ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="要改 message 嗎？[y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="要改檔案（新增/移除）嗎？[y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="（沒有變更，直接收尾）"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue 失敗（多半是下游 commit 動到你剛移除的檔案 → modify/delete 衝突）。"
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase 完成"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n（從此 commit 往前合併 N 條）"
MSG_SQUASH_PURPOSE="作用: 把此 commit 與往前 N-1 條合併成 1 條；下游 commit 會在新頂端 replay"
MSG_SQUASH_WHEN="情境: 整理 WIP commits / 壓縮雜訊 / 合併主題相關的數個小 commit"
MSG_SQUASH_PREREQ="前置: 工作區必須乾淨；下游 SHA 都會改變；衝突時自動 abort"
MSG_SQUASH_DIRTY_TREE="工作區有未提交的變更，請先 commit 或 stash。"
MSG_SQUASH_COUNT_PROMPT="要合併幾條（包含此 commit，往前 N 條，預設 2）："
MSG_SQUASH_MIN_TWO="至少需要 2 條才有合併的意義。"
MSG_SQUASH_TOO_MANY_FMT='此 commit 連同自身只有 %d 個祖先，最多可合併 %d 條。\n'
MSG_SQUASH_PREVIEW_FMT='將合併下列 %d 條 commit（舊 → 新）：\n'
MSG_SQUASH_MSG_PROMPT="新 commit message（逐行輸入；單獨一行 Q 送出；只輸 Q = 開啟編輯器並串接預設內容；:q 取消）："
MSG_SQUASH_CANCELLED="已取消。"
MSG_SQUASH_CONTINUE="繼續？"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit（從歷史中刪除此 commit）"
MSG_DROP_PURPOSE="作用: 把此 commit 從分支歷史中抽掉；下游 commit 會重新 replay（新 SHA）"
MSG_DROP_WHEN="情境: 誤提交（密碼／除錯程式碼）/ 無用 WIP / 重複 commit / 想抹掉的試做"
MSG_DROP_CONTRAST="對比: revert 是加一條反向 commit（保留歷史）；drop 是真的刪掉（改寫歷史）"
MSG_DROP_DIRTY_TREE="工作區有未提交的變更，請先 commit 或 stash。"
MSG_DROP_NOT_ANCESTOR_FMT='%s 不在目前分支的祖先鏈上。\n'
MSG_DROP_ROOT_COMMIT_FMT='%s 是根 commit，沒有父節點，rebase 無法移除。\n'
MSG_DROP_ROOT_HINT="若真要刪除根 commit，需要 git update-ref 等手段，請手動處理。"
MSG_DROP_WILL_REMOVE="將移除："
MSG_DROP_DOWNSTREAM_FMT='下游 %d 條 commit 會被 replay（SHA 會改變）：\n'
MSG_DROP_DOWNSTREAM_HINT="  （若下游變更依賴此 commit → 衝突時自動 abort）"
MSG_DROP_IS_HEAD_NOTE="（此 commit 就是 HEAD → 走 git reset --hard HEAD~ 快路徑，不動 rebase）"
MSG_DROP_CONFIRM="確認移除？"
MSG_DROP_DONE_HEAD="完成。HEAD 已回到上一個 commit。"
MSG_DROP_DONE_REBASE="完成。此 commit 已從歷史中移除。"

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup（把工作區變更併入此 commit）"
MSG_FIXUP_PURPOSE="作用: 建立 fixup commit + 自動 autosquash，把工作區變更合進此 commit"
MSG_FIXUP_WHEN="情境: 改完檔案想合進某個舊 commit（最常用）；不想多生一條 commit 汙染歷史"
MSG_FIXUP_PREREQ="前置: 工作區/暫存區必須有變更；衝突時自動 abort"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s 不在目前分支的祖先鏈上。\n'
MSG_FIXUP_NO_CHANGES="工作區是乾淨的，沒有可 fixup 的變更。"
MSG_FIXUP_WORKFLOW_HINT="工作流：先改檔案 → 點此選單 → 選目標 commit → 自動 fixup + autosquash。"
MSG_FIXUP_WILL_FOLD="將併入此 commit 的變更："
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="暫存區已有內容；要連未 add 的也一起 fixup 嗎？[y/N] "
MSG_FIXUP_ASK_ADD_ALL="暫存區是空的；要全部 git add -A 後再 fixup 嗎？[Y/n] "
MSG_FIXUP_EMPTY_INDEX="暫存區是空的，沒東西可 fixup，已取消。"
MSG_FIXUP_TARGET_FMT='目標：%s  "%s"\n'
MSG_FIXUP_CONFIRM="確認 fixup + autosquash？[Y/n] "
MSG_FIXUP_CANCELLED="已取消，暫存區狀態維持不變。"
MSG_FIXUP_CREATED="  + fixup commit 已建立"
MSG_FIXUP_DONE_FMT='完成。變更已合入 %s（autosquash 後 SHA 已更新）。\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup（把此 commit 折疊進祖先 commit）"
MSG_CFIX_PURPOSE="作用: 把此 commit 作為 fixup 折進同分支較早的某個 commit"
MSG_CFIX_WHEN="情境: HEAD 上的修正其實該歸屬於早期 commit，把它放回正確位置"
MSG_CFIX_CONTRAST="區別: fixup.sh 用工作區變更；本選單用既有 commit"
MSG_CFIX_DIRTY_TREE="工作區有未提交的變更，請先 commit 或 stash。"
MSG_CFIX_NOT_ANCESTOR_SRC="來源 commit 不在目前分支的祖先鏈上。"
MSG_CFIX_HEADER="把此 commit 折疊（fixup）進另一個 commit。"
MSG_CFIX_TARGET_HINT="目標必須是來源的祖先（在歷史上更早）。提示：可從 Zed Graph 複製目標 commit 的 SHA。"
MSG_CFIX_TARGET_PROMPT="目標 commit SHA（短或長皆可）："
MSG_CFIX_NO_INPUT="未輸入內容，已取消。"
MSG_CFIX_INVALID_SHA_FMT='無效的 SHA：%s\n'
MSG_CFIX_SAME_COMMIT="目標與來源相同，沒有意義。"
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s 不是來源 commit 的祖先（無法 fixup 過去）。\n'
MSG_CFIX_PREVIEW="─── 預覽 ───"
MSG_CFIX_SOURCE_LABEL="來源:"
MSG_CFIX_TARGET_LABEL="目標:"
MSG_CFIX_RANGE_LABEL="rebase 範圍（舊 → 新）:"
MSG_CFIX_CONTINUE="繼續？"
MSG_CFIX_DONE="完成。來源已折疊進目標（目標 commit 的 SHA 已更新）。"

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto（把分支 A 變基到分支 B 上）"
MSG_RBO_PURPOSE="作用: git switch A && git rebase B；A 獨有的 commit 會重放到 B 的頂端"
MSG_RBO_WHEN="情境: A 是 feature 分支，B 是 main/develop；想把 A 跟上 B 的最新進度"
MSG_RBO_NOTE="注意: A 上的 commit 會被改寫（新 SHA）；衝突時自動 abort 回復"
MSG_RBO_DIRTY_TREE="工作區有未提交的變更，請先 commit 或 stash。"
MSG_RBO_LOCAL_BRANCHES="本地分支："
MSG_RBO_A_PROMPT_FMT='分支 A（要被變基的分支，Enter = 目前的 %s）：'
MSG_RBO_DETACHED_ERR="目前在 detached HEAD 狀態，必須明確指定分支 A。"
MSG_RBO_NO_LOCAL_FMT='本地不存在分支：%s\n'
MSG_RBO_B_PROMPT="分支 B（變基的目標基準；可為本地分支 / 遠端分支 / tag）："
MSG_RBO_NO_INPUT="未輸入內容，已取消。"
MSG_RBO_INVALID_REF_FMT='無效的目標 ref：%s\n'
MSG_RBO_SAME="A 與 B 指向同一個 commit，不需要變基。"
MSG_RBO_PREVIEW="─── 預覽 ───"
MSG_RBO_NO_EXCLUSIVE="A 沒有 B 以外的 commit（A 是 B 的祖先或同一點）。"
MSG_RBO_FF_OR_NOOP="rebase 將會是 fast-forward 或 no-op。"
MSG_RBO_REPLAY_FMT='A 將被重放的 commit（%d 條）：\n'
MSG_RBO_CONFIRM_FMT='繼續：git switch %s && git rebase %s ？'
MSG_RBO_SWITCHING_FMT='切換到 %s...\n'
MSG_RBO_DONE="完成。"

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag（為此 commit 打 tag）"
MSG_TAG_PURPOSE="作用: 建立 lightweight 或 annotated tag 指向此 commit；可選擇立即 push 到 remote"
MSG_TAG_WHEN="情境: release 節點 / 重要里程碑 / 為某 commit 留一個穩定的命名 ref"
MSG_TAG_CONTRAST="區別: annotated 帶 message+作者+時間（建議用於 release）；lightweight 只是一個 ref"
MSG_TAG_NAME_PROMPT="tag 名稱（例：v1.0.0 / release-2024-01）："
MSG_TAG_NO_INPUT="未輸入內容，已取消。"
MSG_TAG_EXISTS_FMT='tag 已存在：%s\n'
MSG_TAG_KIND_PROMPT="annotated（帶 message）或 lightweight？[a]/l（預設 a）："
MSG_TAG_MSG_PROMPT="tag message（Enter = 使用 tag 名稱）："
MSG_TAG_CREATED_FMT='已建立 tag：%s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='推送到 remote [%s]？[y/N] '
MSG_TAG_NO_REMOTE="（未設定 remote，略過 push）"
MSG_TAG_REFRESH_HINT="提示：Zed Git Graph 不會監聽 tag 變化，請手動重新整理（Cmd+Shift+P → reload window，或等下次 commit 時自動重整）。"

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete（刪除 tag）"
MSG_TAG_DELETE_PURPOSE="作用: 刪除本地 tag，可選同時刪除 remote 上的 tag"
MSG_TAG_DELETE_WHEN="情境: 打錯 tag / release 重發 / 清理無用 tag"
MSG_TAG_DELETE_NOTE="注意: 已 push 的 remote tag 刪除會影響其他人；本地與遠端分兩步詢問"
MSG_TAG_DELETE_AT_HEADER="此 commit 上的 tag："
MSG_TAG_DELETE_NONE="  (無)"
MSG_TAG_DELETE_NAME_PROMPT="要刪除的 tag 名稱（也可以是其他 commit 上的 tag）："
MSG_TAG_DELETE_NO_INPUT="未輸入內容，已取消。"
MSG_TAG_DELETE_NOT_EXIST_FMT='tag 不存在：%s\n'
MSG_TAG_DELETE_ANNOTATED="(annotated tag)"
MSG_TAG_DELETE_PREVIEW_FMT="tag '%s' → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="刪除本地 tag '%s'？"
MSG_TAG_DELETE_LOCAL_DONE="本地 tag 已刪除。"
MSG_TAG_DELETE_NO_REMOTE="（未設定 remote，略過遠端）"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="（remote [%s] 上沒有此 tag，略過）\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="也從 remote [%s] 刪除？[y/N] "
MSG_TAG_DELETE_REMOTE_DONE="遠端 tag 已刪除。"

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="作用: 從此 commit 在新 worktree 檢出（依用途分組）"
MSG_WT_FROM_NOTE_FMT='purpose: %s'
MSG_WT_FROM_PATH_EXISTS_FMT='路徑已存在: %s\n'
MSG_WT_FROM_PATH_HINT="提示: 執行  git worktree list  檢視現有 worktree"
MSG_WT_FROM_BRANCH_EXISTS_FMT='分支已存在: %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree 已建立: %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  分支: %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  清理: git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  清理: git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='分支名稱（Enter = %s）: '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="作用: 列出 [%s] 之下的 worktree，由使用者貼上名稱來刪除"
MSG_WT_RM_USAGE_FMT="用法: 看下方列表，貼上要刪除的那一行名稱（含 %s/ 前綴），然後確認"
MSG_WT_RM_EMPTY_FMT='[%s] 之下沒有可刪除的 worktree。\n'
MSG_WT_RM_LIST_HEADER_FMT='[%s] 之下的 worktree:\n'
MSG_WT_RM_NAME_PROMPT="貼上要刪除的 worktree 名稱（從上方完整複製一整行）: "
MSG_WT_RM_NO_INPUT="未輸入內容，已取消。"
MSG_WT_RM_NOT_IN_LIST_FMT="'%s' 不在 [%s] worktree 列表中。\n"
MSG_WT_RM_REMOVING_FMT='正在刪除: %s\n'
MSG_WT_RM_DONE="✓ worktree 已刪除。"
MSG_WT_RM_REVIEW_NO_BRANCH="(review 為 detached，沒有分支需要清理)"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="也刪除本地分支 '%s'？[y/N] "
MSG_WT_RM_BRANCH_DONE="✓ 本地分支已刪除。"
MSG_WT_RM_BRANCH_ABSENT_FMT="(分支 '%s' 不存在，可能 git worktree remove 已一併移除)\n"

# ── branch-checkout.sh ──────────────────────────────────────────
MSG_BRANCH_CHECKOUT_TITLE="branch-checkout（切換到指向此 commit 的 branch）"
MSG_BRANCH_CHECKOUT_PURPOSE="作用: 把 HEAD 切換到指向此 commit 的某個本地 branch"
MSG_BRANCH_CHECKOUT_WHEN="情境: 從 Git Graph 直接切換到某 branch，省去把名稱複製到終端機再 switch 的麻煩"
MSG_BRANCH_CHECKOUT_NOTE="注意: 需要工作區乾淨；若已經在目標 branch 上則不動作"
MSG_BRANCH_CHECKOUT_DIRTY_TREE="工作區有未提交的變更，請先 commit 或 stash。"
MSG_BRANCH_CHECKOUT_NONE="此 commit 上沒有可切換的本地 branch。"
MSG_BRANCH_CHECKOUT_ONE_FMT='此 commit 上唯一的 branch: %s\n'
MSG_BRANCH_CHECKOUT_LIST_HEADER="此 commit 上的本地 branch:"
MSG_BRANCH_CHECKOUT_SELECT_PROMPT="請選一個（branch 名稱或編號）: "
MSG_BRANCH_CHECKOUT_NO_INPUT="未輸入內容，已取消。"
MSG_BRANCH_CHECKOUT_NOT_IN_LIST_FMT="branch '%s' 不在指向此 commit 的列表中。\n"
MSG_BRANCH_CHECKOUT_ALREADY_FMT='已經在 %s 上，無須切換。\n'

# ── branch-rename.sh ────────────────────────────────────────────
MSG_BRANCH_RENAME_TITLE="branch-rename（重新命名指向此 commit 的 branch）"
MSG_BRANCH_RENAME_PURPOSE="作用: 重新命名本地 branch；可選擇同步在 remote 重推（push 新名 + 刪除舊名）"
MSG_BRANCH_RENAME_WHEN="情境: 修正 typo / 把 try/* 轉為正式 / 統一命名規範"
MSG_BRANCH_RENAME_NOTE="注意: remote 端的重新命名分兩個動作（push 新名 + 刪除舊名），請與協作者協調"
MSG_BRANCH_RENAME_NONE="此 commit 上沒有可重新命名的本地 branch。"
MSG_BRANCH_RENAME_ONE_FMT='此 commit 上唯一的 branch: %s\n'
MSG_BRANCH_RENAME_LIST_HEADER="此 commit 上的本地 branch:"
MSG_BRANCH_RENAME_SELECT_PROMPT="請選一個重新命名（branch 名稱或編號）: "
MSG_BRANCH_RENAME_NO_INPUT="未輸入內容，已取消。"
MSG_BRANCH_RENAME_NOT_IN_LIST_FMT="branch '%s' 不在指向此 commit 的列表中。\n"
MSG_BRANCH_RENAME_NEW_NAME_PROMPT="新名稱: "
MSG_BRANCH_RENAME_INVALID_NAME_FMT="無效的 branch 名稱: %s\n"
MSG_BRANCH_RENAME_EXISTS_FMT="branch 已存在: %s\n"
MSG_BRANCH_RENAME_DONE_FMT="已重新命名: %s → %s\n"
MSG_BRANCH_RENAME_REMOTE_PROMPT_FMT="也在 remote [%s] 重新命名（push 新 + 刪除舊）？[y/N] "
MSG_BRANCH_RENAME_REMOTE_DONE="remote 端重新命名完成。"

# ── copy-branch-name.sh ─────────────────────────────────────────
MSG_COPY_BRANCH_TITLE="copy-branch-name（將指向此 commit 的 branch 名稱複製到剪貼簿）"
MSG_COPY_BRANCH_PURPOSE="作用: 把 branch 名稱放到系統剪貼簿，方便貼到其他地方"
MSG_COPY_BRANCH_WHEN="情境: 傳給同事 / 貼到 PR 描述 / 在另一個終端機使用"
MSG_COPY_BRANCH_NOTE="注意: 使用 pbcopy（macOS）/ wl-copy / xclip / xsel，依可用順序挑選"
MSG_COPY_BRANCH_NONE="此 commit 上沒有可複製的本地 branch。"
MSG_COPY_BRANCH_LIST_HEADER="此 commit 上的本地 branch:"
MSG_COPY_BRANCH_SELECT_PROMPT="請選一個（branch 名稱或編號）: "
MSG_COPY_BRANCH_NO_INPUT="未輸入內容，已取消。"
MSG_COPY_BRANCH_NOT_IN_LIST_FMT="branch '%s' 不在指向此 commit 的列表中。\n"
MSG_COPY_BRANCH_DONE_FMT="已複製: %s\n"
MSG_COPY_BRANCH_NO_CLIPBOARD="找不到剪貼簿工具（需要 pbcopy / wl-copy / xclip / xsel）。branch 名稱顯示如下:"

# ── copy-commit-message.sh ──────────────────────────────────────
MSG_COPY_MSG_TITLE="copy-commit-message（將此 commit 的 message 複製到剪貼簿）"
MSG_COPY_MSG_PURPOSE="作用: 把 commit 的 subject（首行）或完整 message 放到系統剪貼簿"
MSG_COPY_MSG_WHEN="情境: 貼到 release note / PR / 聊天 / 郵件"
MSG_COPY_MSG_NOTE="注意: 使用 pbcopy（macOS）/ wl-copy / xclip / xsel，依可用順序挑選"
MSG_COPY_MSG_KIND_PROMPT="複製 [s]ubject（預設）/ [f]ull message: "
MSG_COPY_MSG_KIND_INVALID_FMT="無效選項: %s\n"
MSG_COPY_MSG_DONE_FMT='已複製: %s\n'
MSG_COPY_MSG_NO_CLIPBOARD="找不到剪貼簿工具（需要 pbcopy / wl-copy / xclip / xsel）。message 顯示如下:"
