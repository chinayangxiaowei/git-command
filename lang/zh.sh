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

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick（复制此 commit 到当前分支顶部）"
MSG_CHERRY_PICK_PURPOSE="作用: 把此 commit 的改动复制到当前分支顶上，形成新 commit (新 SHA)"
MSG_CHERRY_PICK_WHEN="场景: 跨分支搬 hotfix / 从同事分支偷一条 / 从 reflog 救回 commit"
MSG_CHERRY_PICK_NOTE="注意: 源 commit 不被删除；同分支无意义；冲突时自动 abort"
MSG_CHERRY_PICK_CURRENT_FMT='当前分支：%s\n'
MSG_CHERRY_PICK_DIRTY_TREE="工作区有未提交改动，请先提交或 stash。"
MSG_CHERRY_PICK_CONFIRM_FMT='把 %s cherry-pick 到 %s？'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from（从此 commit 创建新分支）"
MSG_BRANCH_FROM_PURPOSE="作用: 在此 commit 处创建新分支并切换过去"
MSG_BRANCH_FROM_WHEN="场景: 想从老 commit 起一条新支线 / 给特定状态保留命名引用"
MSG_BRANCH_FROM_CONTRAST="区别: 临时试错请用 try-branch（自动 try/前缀 + 清理提示）"
MSG_BRANCH_FROM_NAME_PROMPT="新分支名（基于此提交）："
MSG_BRANCH_FROM_NO_NAME="未输入分支名，已取消。"

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch（从此 commit 起临时分支测试）"
MSG_TRY_BRANCH_PURPOSE="作用: 在此 commit 创建 try/<branch-slug>-<sha> 命名的分支，可立即切换过去"
MSG_TRY_BRANCH_WHEN="场景: 想试错而不污染当前分支；测某个老 commit 的状态"
MSG_TRY_BRANCH_HINT="提示: 结尾打印「回原分支」+「删此分支」的命令，避免用完忘了清理"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # 之前是 detached，用 reflog 查"
MSG_TRY_BRANCH_FROM_FMT='原分支：%s\n起点：  %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='新分支名（回车=%s）：'
MSG_TRY_BRANCH_EXISTS_FMT='分支已存在：%s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="创建后立即切换过去？[Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='已创建 %s（未切换）\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="用完清理："
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  回原分支：    %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  删此临时分支：git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push（收起当前改动到带名字的 stash）"
MSG_STASH_PUSH_PURPOSE="作用: 把已跟踪文件的改动收进 stash，工作区清空；输入一个名字方便日后找"
MSG_STASH_PUSH_WHEN="场景: 想切分支但有 WIP 改动 / 暂时收起做别的事 / 暂存好让 reset 干净"
MSG_STASH_PUSH_NOTE="不带 -u: untracked 文件留在工作区（避免 Graph 多出 untracked snapshot 节点）"
MSG_STASH_PUSH_CLEAN="工作区干净，没改动可 stash。"
MSG_STASH_PUSH_WILL_STASH="将 stash 以下改动："
MSG_STASH_PUSH_NAME_PROMPT="起个名字（之后好认）："
MSG_STASH_PUSH_NO_NAME="未输入名字，已取消。"
MSG_STASH_PUSH_DONE_HINT="完成。回看：git stash list 或菜单「Pop 最近的 stash」"
MSG_STASH_PUSH_UNTRACKED_NOTE="提示：未跟踪文件（untracked）没被 stash 进来，仍在工作区。"

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop（应用最近的 stash 到工作区）"
MSG_STASH_POP_PURPOSE="作用: 把 stash@{0} 的改动应用回工作区，pop 成功则 stash 自动 drop"
MSG_STASH_POP_WHEN="场景: 之前用 stash-push 收起了改动，现在想拿回来继续"
MSG_STASH_POP_NOTE="注意: 冲突时 stash 不会自动 drop；手动解决冲突后再 git stash drop"
MSG_STASH_POP_EMPTY="当前没有 stash 可 pop。"
MSG_STASH_POP_LIST_HEADER="最近的 stash 列表："
MSG_STASH_POP_PREVIEW_HEADER="stash@{0} 内容预览："
MSG_STASH_POP_CONFIRM="把 stash@{0} pop 到当前工作区？"
MSG_STASH_POP_CONFLICT="pop 出现冲突——stash 还在（不会自动 drop）。"
MSG_STASH_POP_CONFLICT_HINT="解决冲突 + git add 后，运行  git stash drop  扔掉这条 stash。"

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete [删除指向此 commit 的本地分支]"
MSG_BRANCH_DELETE_PURPOSE="作用: 删本地分支（可选同时删远端）"
MSG_BRANCH_DELETE_WHEN="场景: 清理已合并 / 试错完的分支；批量删 try/* feat/* 等"
MSG_BRANCH_DELETE_NOTE="注意: 用 git branch -D 强删，不检查是否 merged"
MSG_BRANCH_DELETE_NONE="此 commit 上没有本地分支可删。"
MSG_BRANCH_DELETE_ONE_FMT='此 commit 上唯一分支: %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="此 commit 上的本地分支:"
MSG_BRANCH_DELETE_SELECT_PROMPT="选哪个？(分支名或编号): "
MSG_BRANCH_DELETE_NO_INPUT="未输入，已取消。"
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="分支 '%s' 不在指向此 commit 的分支列表里。\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="无法删当前所在分支 '%s'。\n"
MSG_BRANCH_DELETE_CURRENT_HINT="先切到别的分支: git switch <other-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="删除本地分支 '%s'？"
MSG_BRANCH_DELETE_LOCAL_DONE="本地分支已删除。"
MSG_BRANCH_DELETE_NO_REMOTE="(没有 remote，跳过远端)"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="(远端 [%s] 上没有此分支，跳过)"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="也从远端 [%s] 删除？[y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="远端分支已删除。"

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit（编辑此 commit 的元数据/文件清单）"
MSG_EDIT_COMMIT_HEAD_PATH="HEAD 路径: 工作区可脏；直接 amend；可改 message / 加文件 / 删文件 / 改内容"
MSG_EDIT_COMMIT_OLD_PATH="老 commit 路径: 工作区必须干净；适用 message / 新增（untracked）/ 删文件"
MSG_EDIT_COMMIT_NOT_SUITED="不适用（老 commit）: 修改已有文件内容 → 用 fixup 菜单（详细原因见脚本顶部）"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="每行一个操作，输完 Q 单独成行："
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:path/to/file    git add（加入 / 更新 / 暂存任何变化）"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:path/to/file    从此 commit 移除（disk 保留，git rm --cached）"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                 完成"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  skip 格式错误：%s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  skip +%s  (文件不存在)\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  add  %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  skip +%s  (git add 失败)\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  rm   %s  (从 commit 移除，disk 保留)\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  skip -%s  (不在此 commit 里)\n'
MSG_EDIT_COMMIT_ASK_MSG="新 message（逐行；单独一行 Q 提交；直接 Q = 不改）："
MSG_EDIT_COMMIT_HEAD_HEADER="─── HEAD 快路径 ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="目标是 HEAD，无需 rebase："
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · 工作区可以脏（改动会作为 amend 候选）"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · 修改 / 新增 / 删除文件随意，没有下游冲突风险"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── 当前 message ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── 当前工作区/暂存区改动 ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="改 message？[y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="改文件（增/删/改）？[y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="（无改动，不 amend，退出。）"
MSG_EDIT_COMMIT_UNSTAGED_HINT="提示：工作区还有未 git add 的改动，amend 不会包含它们。"
MSG_EDIT_COMMIT_AMEND_MSG_FILES="已 amend (新 message + 文件改动)"
MSG_EDIT_COMMIT_AMEND_MSG="已 amend (新 message)"
MSG_EDIT_COMMIT_AMEND_FILES="已 amend (文件改动)"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='工作区有未提交改动。

如果你想把这些改动并入此 commit → 请改用菜单：
  「把工作区/暂存区改动并入此提交 (fixup+autosquash)」

如果你确实想用本菜单（改 message / 加新文件 / 删文件），请先 commit 或 stash。'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s 不在当前分支祖先链上。\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── 老 commit 路径 (rebase) ───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="适用：改 message / 加新文件（untracked）/ 删文件"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="不适用：修改已有文件内容（请用 fixup 菜单）"
MSG_EDIT_COMMIT_OLD_CONTINUE="继续？"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="rebase 没进入 edit 状态。"
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── 当前 commit message ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="改 message？[y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="改文件（增/删）？[y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="(无改动，直接收尾)"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue 失败（多半是下游 commit 改了你刚删的文件 → modify/delete 冲突）。"
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase 完成"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n（从此 commit 向前 N 条合并）"
MSG_SQUASH_PURPOSE="作用: 把此 commit 和向前 N-1 条合并成 1 条，下游 commit 在新顶上 replay"
MSG_SQUASH_WHEN="场景: 整理 WIP commits / 压缩噪音 / 合并主题相关的多个小 commit"
MSG_SQUASH_PREREQ="前提: 工作区必须干净；下游 SHA 全变；冲突时自动 abort"
MSG_SQUASH_DIRTY_TREE="工作区有未提交改动，请先提交或 stash。"
MSG_SQUASH_COUNT_PROMPT="合并几条（含此提交，向前 N 条，默认 2）："
MSG_SQUASH_MIN_TWO="至少 2 条才有合并意义。"
MSG_SQUASH_TOO_MANY_FMT='此提交只有 %d 个祖先（含自身），最多合并 %d 条。\n'
MSG_SQUASH_PREVIEW_FMT='将合并以下 %d 条提交（旧 → 新）：\n'
MSG_SQUASH_MSG_PROMPT="新 commit message（逐行输入；单独一行 Q 提交；直接 Q = 走编辑器拼接默认；:q 取消）："
MSG_SQUASH_CANCELLED="已取消。"
MSG_SQUASH_CONTINUE="继续？"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit（从历史中删除此 commit）"
MSG_DROP_PURPOSE="作用: 把此 commit 从分支历史里抽掉，下游 commit 重新 replay (新 SHA)"
MSG_DROP_WHEN="场景: 误提交（密码/调试代码） / 完全没用的 WIP / 重复 commit / 想抹掉的尝试"
MSG_DROP_CONTRAST="对比: revert 是加反向 commit（保留历史）；drop 是真删（重写历史）"
MSG_DROP_DIRTY_TREE="工作区有未提交改动，请先提交或 stash。"
MSG_DROP_NOT_ANCESTOR_FMT='%s 不在当前分支祖先链上。\n'
MSG_DROP_ROOT_COMMIT_FMT='%s 是根 commit，没有父，rebase 无法移除。\n'
MSG_DROP_ROOT_HINT="真要删根 commit 需要 git update-ref 等手段，手动处理。"
MSG_DROP_WILL_REMOVE="将移除："
MSG_DROP_DOWNSTREAM_FMT='下游 %d 条 commit 会 replay（SHA 会变）：\n'
MSG_DROP_DOWNSTREAM_HINT="  （若下游改动依赖此 commit → 冲突时自动 abort）"
MSG_DROP_IS_HEAD_NOTE="（此 commit 就是 HEAD → 走 git reset --hard HEAD~ 快路径，不动 rebase）"
MSG_DROP_CONFIRM="确认移除？"
MSG_DROP_DONE_HEAD="完成。HEAD 已回到上一条 commit。"
MSG_DROP_DONE_REBASE="完成。此 commit 已从历史中移除。"

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup（把工作区改动并入此 commit）"
MSG_FIXUP_PURPOSE="作用: 创建 fixup commit + 自动 autosquash，把工作区改动合进此 commit"
MSG_FIXUP_WHEN="场景: 改完文件想合进某老 commit（最常用）；不想产生新 commit 污染历史"
MSG_FIXUP_PREREQ="前提: 工作区/暂存区必须有改动；冲突时自动 abort"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s 不在当前分支祖先链上。\n'
MSG_FIXUP_NO_CHANGES="工作区干净，没改动可 fixup。"
MSG_FIXUP_WORKFLOW_HINT="工作流：先改文件 → 点此菜单 → 选目标 commit → 自动 fixup + autosquash。"
MSG_FIXUP_WILL_FOLD="将并入此 commit 的改动："
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="暂存区已有内容；连未 add 的也一起 fixup 吗？[y/N] "
MSG_FIXUP_ASK_ADD_ALL="没东西在暂存区，全部 git add 后再 fixup？[Y/n] "
MSG_FIXUP_EMPTY_INDEX="暂存区为空，没东西 fixup，已取消。"
MSG_FIXUP_TARGET_FMT='目标：%s  "%s"\n'
MSG_FIXUP_CONFIRM="确认 fixup + autosquash？[Y/n] "
MSG_FIXUP_CANCELLED="已取消，暂存区状态保持不变。"
MSG_FIXUP_CREATED="  + fixup commit 已创建"
MSG_FIXUP_DONE_FMT='完成。改动已合入原 %s（autosquash 后 SHA 已更新）。\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup（把此 commit 折叠进祖先 commit）"
MSG_CFIX_PURPOSE="作用: 把此 commit 作为 fixup 折进同分支某个更早的 commit"
MSG_CFIX_WHEN="场景: HEAD 上发现某 fix 应该属于早期 commit，想放回正确位置"
MSG_CFIX_CONTRAST="区别: fixup.sh 用工作区改动；本菜单用已存在的 commit"
MSG_CFIX_DIRTY_TREE="工作区有未提交改动，请先提交或 stash。"
MSG_CFIX_NOT_ANCESTOR_SRC="源 commit 不在当前分支祖先链上。"
MSG_CFIX_HEADER="把此 commit 折叠 (fixup) 进另一个 commit。"
MSG_CFIX_TARGET_HINT="目标必须是源的祖先（在历史上更早）。提示：从 Zed Graph 复制目标 commit 的 SHA。"
MSG_CFIX_TARGET_PROMPT="目标 commit SHA（短/长都可）："
MSG_CFIX_NO_INPUT="未输入，已取消。"
MSG_CFIX_INVALID_SHA_FMT='无效 SHA：%s\n'
MSG_CFIX_SAME_COMMIT="目标和源相同，无意义。"
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s 不是源 commit 的祖先（无法 fixup 到那里）。\n'
MSG_CFIX_PREVIEW="─── 预览 ───"
MSG_CFIX_SOURCE_LABEL="源:"
MSG_CFIX_TARGET_LABEL="目标:"
MSG_CFIX_RANGE_LABEL="rebase 范围 (旧→新):"
MSG_CFIX_CONTINUE="继续？"
MSG_CFIX_DONE="完成。源已折叠进目标 (目标 commit 已更新 SHA)。"

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto（把分支 A 变基到分支 B 上）"
MSG_RBO_PURPOSE="作用: git switch A && git rebase B；A 的独有 commit 会重放到 B 顶部"
MSG_RBO_WHEN="场景: A 是 feature 分支、B 是 main/develop；想把 A 跟上 B 的最新进度"
MSG_RBO_NOTE="注意: A 上的 commit 会被重写 (新 SHA)；冲突时自动 abort 回滚"
MSG_RBO_DIRTY_TREE="工作区有未提交改动，请先 commit 或 stash。"
MSG_RBO_LOCAL_BRANCHES="本地分支："
MSG_RBO_A_PROMPT_FMT='分支 A（要被变基的分支，回车=当前 %s）：'
MSG_RBO_DETACHED_ERR="当前是 detached HEAD，必须明确指定分支 A。"
MSG_RBO_NO_LOCAL_FMT='本地不存在分支：%s\n'
MSG_RBO_B_PROMPT="分支 B（变基的目标基准；可以是本地分支 / 远端分支 / tag）："
MSG_RBO_NO_INPUT="未输入，已取消。"
MSG_RBO_INVALID_REF_FMT='无效的目标 ref：%s\n'
MSG_RBO_SAME="A 和 B 指向同一 commit，无需变基。"
MSG_RBO_PREVIEW="─── 预览 ───"
MSG_RBO_NO_EXCLUSIVE="A 没有 B 之外的 commit（A 是 B 的祖先或同一点）。"
MSG_RBO_FF_OR_NOOP="rebase 会变成 fast-forward 或 no-op。"
MSG_RBO_REPLAY_FMT='A 上将被重放的 commit (%d 条)：\n'
MSG_RBO_CONFIRM_FMT='继续：git switch %s && git rebase %s ？'
MSG_RBO_SWITCHING_FMT='切换到 %s...\n'
MSG_RBO_DONE="完成。"

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag（给此 commit 打 tag）"
MSG_TAG_PURPOSE="作用: 创建轻量或 annotated tag 指向此 commit；可选立即 push 到远端"
MSG_TAG_WHEN="场景: release 节点 / 重要里程碑 / 给某 commit 一个稳定的命名引用"
MSG_TAG_CONTRAST="区别: annotated 带 message+作者+时间（推荐 release）；lightweight 只是个 ref"
MSG_TAG_NAME_PROMPT="tag 名字（例：v1.0.0 / release-2024-01）："
MSG_TAG_NO_INPUT="未输入，已取消。"
MSG_TAG_EXISTS_FMT='tag 已存在：%s\n'
MSG_TAG_KIND_PROMPT="annotated（带 message）还是 lightweight？[a]/l（默认 a）："
MSG_TAG_MSG_PROMPT="tag message（回车 = 用 tag 名字）："
MSG_TAG_CREATED_FMT='已创建 tag：%s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='推送到远端 [%s]？[y/N] '
MSG_TAG_NO_REMOTE="（没有 remote，跳过 push）"
MSG_TAG_REFRESH_HINT="提示：Zed Git Graph 不监听 tag 变化，需手动刷新（cmd+shift+P → reload window 或下次 commit 时自动刷）。"

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete（删除 tag）"
MSG_TAG_DELETE_PURPOSE="作用: 删本地 tag，可选同时删远端 tag"
MSG_TAG_DELETE_WHEN="场景: 错打 / release 重发 / 清理无用 tag"
MSG_TAG_DELETE_NOTE="注意: 已 push 的远端 tag 删除会影响其他人；本地+远端分两步问"
MSG_TAG_DELETE_AT_HEADER="此 commit 上的 tag："
MSG_TAG_DELETE_NONE="  (无)"
MSG_TAG_DELETE_NAME_PROMPT="要删的 tag 名字（也可以是其它 commit 上的 tag）："
MSG_TAG_DELETE_NO_INPUT="未输入，已取消。"
MSG_TAG_DELETE_NOT_EXIST_FMT='tag 不存在：%s\n'
MSG_TAG_DELETE_ANNOTATED="(annotated tag)"
MSG_TAG_DELETE_PREVIEW_FMT="tag '%s' → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="删除本地 tag '%s'？"
MSG_TAG_DELETE_LOCAL_DONE="本地 tag 已删除。"
MSG_TAG_DELETE_NO_REMOTE="（没有 remote，跳过远端）"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="（远端 [%s] 上没有此 tag，跳过）\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="也从远端 [%s] 删除？[y/N] "
MSG_TAG_DELETE_REMOTE_DONE="远端 tag 已删除。"

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="作用: 从此 commit 在新 worktree 检出（按 purpose 分组）"
MSG_WT_FROM_NOTE_FMT='purpose: %s'
MSG_WT_FROM_PATH_EXISTS_FMT='路径已存在: %s\n'
MSG_WT_FROM_PATH_HINT="提示: 跑  git worktree list  查看现有 worktree"
MSG_WT_FROM_BRANCH_EXISTS_FMT='分支已存在: %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree 已创建: %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  分支: %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  清理: git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  清理: git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='分支名（回车=%s）: '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="作用: 列出 [%s] 下的 worktree，由用户复制粘贴名字来删除"
MSG_WT_RM_USAGE_FMT="用法: 看下面列表，复制要删的那一行的名字（含 %s/ 前缀），粘贴到输入框"
MSG_WT_RM_EMPTY_FMT='[%s] 下没有 worktree 可删。\n'
MSG_WT_RM_LIST_HEADER_FMT='[%s] 下的 worktree:\n'
MSG_WT_RM_NAME_PROMPT="粘贴要删的 worktree 名字（完整复制上面某一行）: "
MSG_WT_RM_NO_INPUT="未输入，已取消。"
MSG_WT_RM_NOT_IN_LIST_FMT="'%s' 不在 [%s] worktree 列表里。\n"
MSG_WT_RM_REMOVING_FMT='正在删除: %s\n'
MSG_WT_RM_DONE="✓ worktree 已删除。"
MSG_WT_RM_REVIEW_NO_BRANCH="(review 是 detached，无分支需要清理)"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="也删本地分支 '%s'？[y/N] "
MSG_WT_RM_BRANCH_DONE="✓ 本地分支已删除。"
MSG_WT_RM_BRANCH_ABSENT_FMT="(分支 '%s' 不存在，可能 git worktree remove 已带走)\n"
