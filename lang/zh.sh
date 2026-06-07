#!/usr/bin/env bash
# 中文（简体）文案 for git-command scripts.
# Loaded by lib.sh; do not invoke directly.
# 命名规范: MSG_<SCRIPT>_<KEY>；带 %s 内插的用 _FMT 后缀。
# shellcheck shell=bash

# ── lib.sh (公共内部) ───────────────────────────────────────────
MSG_LIB_IN_PROGRESS_FMT='已有未完成的 %s。先 "%s" 或 --continue 处理掉再试。\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s 失败，自动 git %s --abort（你的工作区已回滚到操作前）。\n'
MSG_LIB_NOT_IN_REPO='不在 git repo 内。'
MSG_LIB_NOT_BARE_LAYOUT='当前不在 bare + worktrees 布局下，worktree 菜单已禁用。'
MSG_LIB_INIT_HINT='如需启用，新项目用: bash git-command/init-bare-tree.sh <name> [<url>]'
MSG_LIB_MIGRATE_HINT='已有项目用 migrate-to-bare-tree.sh（暂未实现，先手动迁移）。'
MSG_LIB_CLEANUP_FMT='脚本异常退出 (exit %d)，自动 git %s --abort 回滚到操作前。\n'

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword（重写此 commit 的 message）"
MSG_REWORD_PURPOSE="作用: 只改 commit message，文件内容/SHA 关系不变（下游 SHA 会变）"
MSG_REWORD_WHEN="场景: typo 修复 / 改成规范格式 / 加 issue 引用 / 改 conventional commit 前缀"
MSG_REWORD_CONTRAST="对比: HEAD 的 message 改 → 直接 edit-commit 更快；老 commit 只改 message 用这个"
MSG_REWORD_DIRTY_TREE="工作区有未提交改动，请先提交或 stash。"
MSG_REWORD_NOT_ANCESTOR_FMT='%s 不在当前分支祖先链上，无法 reword。\n'
MSG_REWORD_OLD_MSG="原 message："
MSG_REWORD_NEW_MSG_PROMPT="新 message（逐行输入；空行 = 段落分隔；单独一行 Q 提交，:q 取消）："
MSG_REWORD_CANCELLED="已取消。"
MSG_REWORD_EMPTY_CANCELLED="未输入内容，已取消。"
