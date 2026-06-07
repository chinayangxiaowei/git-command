#!/usr/bin/env bash
# 中文（简体）菜单 label for tasks.json（精简但保留表达力）。
# Loaded by sync-tasks.sh; substituted into tasks.json placeholders __LABEL_*__.
# 用单引号 — $ZED_GIT_SHA_SHORT 等必须以字面形式留给 Zed 解析。
#
# 设计原则:
#   1. label 极简 — 动词 + 核心宾语；详细解释放在脚本的 show_intro 里运行时再显示
#   2. commit 上下文已由右键来源隐含，不重复 "此 commit"
#   3. 保留 git 行业术语（Squash / Fixup / Rebase / Stash / Cherry-pick / Revert / Reword），
#      用中文双字动词修饰（"重写"、"删除"、"导出"、"创建"），避免单字动词
# shellcheck shell=bash disable=SC2034

# ── 1. 查看 ─────────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. 查看 ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · 含此 commit 的分支'
LABEL_VIEW_TAGS_CONTAINING='Git · 含此 commit 的 tag'
LABEL_VIEW_STAT='Git · 概览 stat'
LABEL_VIEW_DIFF='Git · 完整 diff'
LABEL_VIEW_DIFF_HEAD='Git · 与 HEAD 对比'
LABEL_VIEW_OPEN_FILES='Git · 打开涉及文件'
LABEL_VIEW_EXPORT_FILES='Git · 导出涉及文件'
LABEL_VIEW_EXPORT_PATCHES='Git · 导出向前 N 条补丁'

# ── 2. 修改 ─────────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. 修改 ────'
LABEL_MODIFY_REWORD='Git · 重写 message'
LABEL_MODIFY_EDIT_COMMIT='Git · 编辑 commit'

# ── 3. 历史重写 ──────────────────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. 历史重写 ────'
LABEL_REWRITE_SQUASH='Git · Squash 向前 N 条'
LABEL_REWRITE_DROP='Git · 删除此 commit'
LABEL_REWRITE_INTERACTIVE='Git · 交互式 rebase'
LABEL_REWRITE_RESET_SOFT='Git · 软重置'
LABEL_REWRITE_RESET_HARD='Git · 硬重置 ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup 并入此 commit'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fixup 进祖先 commit'

# ── 5. 复制 / 撤销 ───────────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. 复制 / 撤销 ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. 分支 ─────────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. 分支 ────'
LABEL_BRANCH_FROM='Git · 新建分支'
LABEL_BRANCH_TRY='Git · 试错分支'
LABEL_BRANCH_REBASE_ONTO='Git · 分支 A 变基到 B'
LABEL_BRANCH_DELETE='Git · 删除分支'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · 创建 tag'
LABEL_TAG_DELETE='Git · 删除 tag'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash 当前改动'
LABEL_STASH_POP='Git · Pop 最近 stash'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree ────'
LABEL_WT_REVIEW='Worktree · review'
LABEL_WT_TRY='Worktree · try'
LABEL_WT_FIX='Worktree · fix'
LABEL_WT_FEAT='Worktree · feat'
LABEL_WT_HOT='Worktree · hot'
LABEL_WT_RM_REVIEW='Worktree · 删除 review'
LABEL_WT_RM_TRY='Worktree · 删除 try'
LABEL_WT_RM_FIX='Worktree · 删除 fix'
LABEL_WT_RM_FEAT='Worktree · 删除 feat'
LABEL_WT_RM_HOT='Worktree · 删除 hot'
