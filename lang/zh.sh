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

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files（在 Zed 打开此 commit 涉及的所有文件）"
MSG_OPEN_FILES_PURPOSE="作用: 列出此 commit 改动的文件，在 Zed 中全部打开（当前 working 版本）"
MSG_OPEN_FILES_WHEN="场景: 调试历史 bug，想看那次改动相关的所有文件"
MSG_OPEN_FILES_PREREQ="前提: PATH 里有 zed 命令；当前不存在的文件会跳过"
MSG_OPEN_FILES_EMPTY="此提交没有文件变更（可能是空 commit）。"
MSG_OPEN_FILES_MISSING="以下文件在当前工作区不存在（可能已删除/重命名），跳过："
MSG_OPEN_FILES_ALL_GONE="此提交涉及的文件在当前工作区都不在了。"
MSG_OPEN_FILES_OPENING_FMT='将在 Zed 中打开 %d 个文件：\n'
MSG_OPEN_FILES_NO_ZED="未找到 zed 命令。"
MSG_OPEN_FILES_INSTALL_HINT="在 Zed 里: cmd+shift+P → 'zed: install cli' 安装 zed 命令到 PATH。"

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files（导出此 commit 涉及的文件到指定文件夹）"
MSG_EXPORT_FILES_PURPOSE="作用: 把此 commit 改动的每个文件的「该 commit 时的版本」拷到指定目录，保留路径结构"
MSG_EXPORT_FILES_WHEN="场景: 文件多不想全开标签页 / 取走某 commit 的产物快照 / 离线对比"
MSG_EXPORT_FILES_CONTRAST="区别: open-files 在 Zed 打开当前 working 版本；本菜单导出此 commit 时的历史版本"
MSG_EXPORT_FILES_EMPTY="此 commit 没有文件变更（可能是空 commit）。"
MSG_EXPORT_FILES_COUNT_FMT='此 commit 涉及 %d 个文件：\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... 还有 %d 个\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='导出目录（相对仓库根，默认 %s）：'
MSG_EXPORT_FILES_DIR_EXISTS_FMT='目录已存在且非空：%s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="继续会覆盖里面同名文件，确认？"
MSG_EXPORT_FILES_DELETED_HINT="(此 commit 里被删除，无内容可导)"
MSG_EXPORT_FILES_DONE_FMT='完成：导出 %d 个，跳过 %d 个 → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="提示：导出目录里是此 commit 时的快照，不是当前 working 版本。"

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches（导出 N 条补丁文件）"
MSG_EXPORT_PATCHES_PURPOSE="作用: 从此 commit 向前导出 N 条，可选 mbox (.patch) 或纯 diff (.diff)"
MSG_EXPORT_PATCHES_WHEN="场景: 邮件协作 / 备份特定改动 / 给别人用 git am / git apply 接收"
MSG_EXPORT_PATCHES_OUTPUT="输出: 自定目录（默认 ./patches）；不会修改任何历史"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="格式 [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply)（默认 f）："
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='无效的格式：%s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="导出几条（从此提交向前 N 条，默认 1）："
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='无效的数量：%s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="输出目录（相对仓库根，默认 ./patches）："
MSG_EXPORT_PATCHES_FORMAT_LABEL="格式："
MSG_EXPORT_PATCHES_RANGE_LABEL="范围："
MSG_EXPORT_PATCHES_OUTPUT_LABEL="输出："
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(根)"
MSG_EXPORT_PATCHES_CONTINUE="继续？"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft（软重置到此 commit · 改动保留到暂存区）"
MSG_RESET_SOFT_PURPOSE="作用: HEAD 移到此 commit；中间 commits 的改动落到暂存区，不丢"
MSG_RESET_SOFT_WHEN="场景: 想重新组织最后 N 条 commit（重新分块 / 改 message / 合并）"
MSG_RESET_SOFT_AFTER="之后: git status 看暂存区，重新 commit 一份新的历史"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s 不在 HEAD 祖先链上，soft reset 没有意义。\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s 就是 HEAD，无需 reset。\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='当前分支：%s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='将丢弃以下 commit（其改动落到暂存区，HEAD → %s）：\n'
MSG_RESET_SOFT_CONFIRM_FMT='soft reset 到 %s？'
MSG_RESET_SOFT_DONE="完成。改动已在暂存区，可 git status 查看，git commit 重新提交。"

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard（硬重置到此 commit · destructive）"
MSG_RESET_HARD_PURPOSE="作用: HEAD 移到此 commit；丢弃中间 commits + 工作区所有改动"
MSG_RESET_HARD_WHEN="场景: 彻底回退到某状态，且确认不要保留任何中间改动"
MSG_RESET_HARD_AFTER="后果: 不可恢复（除非 30 天内 git reflog 还有；要输入 YES 全大写才执行）"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s 不在 HEAD 祖先链上，refuse。\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s 就是 HEAD，无需 reset。\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='当前分支：%s\n'
MSG_RESET_HARD_WILL_DROP="将丢弃以下 commit（不可恢复，除非走 reflog）："
MSG_RESET_HARD_WT_LOST="工作区改动也会被丢弃："
MSG_RESET_HARD_YES_PROMPT_FMT='输入 YES (大写) 确认硬重置到 %s：'
MSG_RESET_HARD_NO_YES="未输入 YES，已取消。"
MSG_RESET_HARD_REFLOG_HINT="提示：reflog 还能救回这些 commit，30 天内 git reflog 找 HEAD@{N}。"

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i（交互式 rebase 到此 commit 之前）"
MSG_REBASE_I_PURPOSE='作用: 启动 git rebase -i SHA^，打开 $EDITOR 让你手动编辑 todo'
MSG_REBASE_I_WHEN="场景: 想手动重排/合并/编辑/drop 多条 commit；超出标准菜单覆盖的复杂操作"
MSG_REBASE_I_PREREQ="前提: 工作区必须干净；中途冲突自己处理或菜单兜底 abort"
MSG_REBASE_I_RANGE_FMT='将启动交互式 rebase，范围：%s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="工作区有未提交改动，请先提交或 stash。"
MSG_REBASE_I_CONTINUE="继续？"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert（生成反向 commit 撤销此 commit）"
MSG_REVERT_PURPOSE="作用: 不改历史，在 HEAD 之上加一条新 commit，内容与此 commit 相反"
MSG_REVERT_WHEN="场景: 已 push 的 commit 想撤销（不能用 reset 改公共历史）"
MSG_REVERT_CONTRAST="对比: reset 是改历史，revert 是加新历史；冲突时自动 abort"
MSG_REVERT_DIRTY_TREE="工作区有未提交改动，请先提交或 stash。"
MSG_REVERT_CONFIRM_FMT='在 HEAD 之上生成反向提交以撤销 %s？\n'
