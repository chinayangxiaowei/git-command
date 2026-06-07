#!/usr/bin/env bash
# 中文菜单 label for tasks.json.
# Loaded by sync-tasks.sh; substituted into tasks.json placeholders __LABEL_*__.
# 用单引号 — $ZED_GIT_SHA_SHORT 等必须以字面形式留给 Zed 解析。
# shellcheck shell=bash disable=SC2034

# ── 1. 查看 / 浏览 ──────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. 查看 / 浏览 ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · 包含此提交的分支  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · 包含此提交的 tag  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · 此提交概览 (stat)  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · 此提交完整 diff  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · 与 HEAD 对比  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · 在 Zed 中打开此提交涉及的所有文件  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · 导出此提交涉及的文件到文件夹（快照）  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · 导出此提交向前 N 条为补丁文件  ($ZED_GIT_SHA_SHORT)'

# ── 2. 修改此 commit ────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. 修改此 commit ────'
LABEL_MODIFY_REWORD='Git · 重写此提交的 message  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · 编辑此提交（改 message / 新增-删除文件）  ($ZED_GIT_SHA_SHORT)'

# ── 3. 历史重写（rebase 类）─────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. 历史重写（rebase 类）────'
LABEL_REWRITE_SQUASH='Git · 从此提交向前 N 条合并 (squash)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · 从历史中删除此 commit (drop)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · 交互式 rebase 到此提交之前  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · 软重置到此提交（改动入暂存区）  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · 硬重置到此提交（destructive）  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. 把改动合进此 commit (fixup 类) ────'
LABEL_FIXUP_INTO_THIS='Git · 把工作区/暂存区改动并入此提交 (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · 把此 commit 折叠进某个祖先 commit (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. 复制 / 撤销 ──────────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. 复制 / 撤销 ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick 到当前分支  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · Revert 此提交  ($ZED_GIT_SHA_SHORT)'

# ── 6. 分支 ─────────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. 分支 ────'
LABEL_BRANCH_FROM='Git · 从此提交创建新分支  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · 从此提交起临时分支测试  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · 把分支 A rebase 到分支 B 上 (CLion 风格)'
LABEL_BRANCH_DELETE='Git · 删除指向此 commit 的本地分支（可选远端）  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · 给此提交打 tag  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · 删除 tag（本地+可选远端）  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash 当前改动（带名字）'
LABEL_STASH_POP='Git · Pop 最近的 stash'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree（在新目录检出此 commit）────'
LABEL_WT_REVIEW='Worktree · review  (detached, 看代码)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (临时分支，试错用)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (修 bug)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (新功能)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · 删除  review  (复制粘贴名字确认)'
LABEL_WT_RM_TRY='Worktree · 删除  try     (复制粘贴名字确认)'
LABEL_WT_RM_FIX='Worktree · 删除  fix     (复制粘贴名字确认)'
LABEL_WT_RM_FEAT='Worktree · 删除  feat    (复制粘贴名字确认)'
LABEL_WT_RM_HOT='Worktree · 删除  hot     (复制粘贴名字确认)'
