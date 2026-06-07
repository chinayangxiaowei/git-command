**[English](README.md) | 简体中文**

# git-command

为 [Zed](https://zed.dev) 编辑器的 Git Graph 右键菜单提供 JetBrains 风格的 Git 操作脚本，
覆盖日常 80% 的 commit 级操作（reword / squash / fixup / cherry-pick / revert / branch / tag / stash …）。

## Requirements

| | |
|--|--|
| OS | macOS / Linux |
| Shell | bash ≥ 3.2（macOS 系统自带的 `/bin/bash` 即可） |
| Git | ≥ 2.x |
| 编辑器 | [Zed](https://zed.dev) — 用来出菜单；纯命令行也能直接调脚本 |

**Windows 不支持。** 脚本依赖 POSIX shell 和 Unix 工具链。WSL 下理论可行（bash + git 都有），但 Zed 在 WSL 中的 Git Graph 集成不背书。

## 安装

```bash
git clone https://github.com/chinayangxiaowei/git-command.git ~/git-command   # 路径任意
cd ~/git-command
./sync-tasks.sh           # 默认英文
# 也可以选语言：
./sync-tasks.sh zh        # 简体中文
./sync-tasks.sh zh-TW     # 繁體中文
./sync-tasks.sh ja        # 日本語
# 10 种语言可选: en / zh / zh-TW / ja / ko / pt-BR / es / de / fr / ru
```

`sync-tasks.sh` 做四件事：

1. 把所有 `*.sh` 拷到 `~/.config/zed/git-command/`
2. 把选中的 `lang/<code>.sh` 复制成同目录下的 `lang.sh`（脚本运行时的文案）
3. 用安装目录渲染 `tasks.json` 里的 `__GIT_COMMAND_DIR__` 占位符，
   再用所选语言的菜单文本替换所有 46 个 `__LABEL_*__` 占位符，
   结果写到 `~/.config/zed/tasks.json`
4. 如果 `~/.local/bin/` 在你的 PATH 里，把 `init-bare-tree` symlink 过去，
   让新建 bare+worktree 项目变成一条命令的事

之后在 Zed 里 `Cmd+Shift+P` → `reload window`，所有项目的 Git Graph 右键菜单都会出现这 41 条命令。

需要换装位置？覆盖环境变量：

```bash
TARGET_DIR=~/.local/share/git-command ./sync-tasks.sh zh
```

## 菜单内容

41 个命令分 9 类，由 `tasks.json` 注入到 Zed Git Graph 的 commit 右键菜单。

| 类别 | 命令 |
|------|------|
| 查看 / 浏览 | 列含此 commit 的分支 / tag、stat、完整 diff、与 HEAD 对比、在编辑器中打开此 commit 涉及的所有文件、导出文件历史版本、导出向前 N 条 patch |
| 修改此 commit | reword（只改 message）、edit-commit（改 message + 增删文件） |
| 历史重写 | squash 向前 N 条、drop 此 commit、interactive rebase、soft / hard reset |
| Fixup | 工作区改动并入此 commit（fixup + autosquash）、把此 commit 折叠进祖先 |
| 复制 / 撤销 | cherry-pick、revert |
| 分支 | 从此 commit 创建分支、临时试错分支、把分支 A rebase 到分支 B（CLion 风格）、删除指向此 commit 的本地分支（可选远端）、切换到 / 重命名指向此 commit 的分支、复制分支名 / commit message — 全部支持剪贴板（`pbcopy` / `wl-copy` / `xclip` / `xsel`） |
| Tag | 创建 tag、删除 tag（含远端） |
| Stash | 带名字 stash push、pop 最近 stash |
| Worktree | 从此 commit 在新 worktree 检出（review / try / fix / feat / hot 五种用途，自动命名 + 在新 Zed 窗口打开）；每种用途配套"删除"菜单项，列出该类型现有 worktree，复制粘贴名字确认 |

## 安全设计

任何 `source lib.sh` 的脚本都自动获得以下保证：

- **`ensure_clean_state`** — 启动前如果检测到 rebase / cherry-pick / revert / merge 进行中，直接拒绝运行（防止半成品状态叠加）
- **EXIT trap 自动回滚** — 由 `lib.sh` 顶层注册。非零退出时如果发现还在 rebase 类状态，trap 会自动跑 `git <kind> --abort` 并打印"已自动回滚"提示。对信号则由 `enable_failure_rollback` 注册 `INT` / `TERM` / `HUP` 处理器统一翻成非零退出，再走 EXIT trap。
- **`_GIT_CMD_DONE=1` 短路** — 主流程成功完成后、进入 `wait_to_close` 提示前，trap 把这个标记置位。之后用户 Ctrl+C 或关 pane 都不会触发误回滚——业务已经成功。
- **`run_or_abort`** — 包一层 git 子命令；命令失败时友好报错并跑对应的 `--abort` 再退出

只有 `SIGKILL` / 断电这种不可拦截信号无法回滚（POSIX 限制）。

每个脚本顶部都会用 `show_intro` 打印"做什么 / 何时用 / 注意点"，二次确认后才开干。成功完成后脚本会停在 "按 Enter 关闭" 等你看完输出，然后 Zed 的 `hide: on_success` 把 pane 自动收掉。

## 项目布局

仓库本身用 bare + worktree 布局，由 `init-bare-tree.sh` 创建。这是个独立的便利脚本，
让任何新项目都可以一行命令初始化成这种布局：

```
project/
├── .bare/      ← git 数据
├── .git        ← 指向 .bare 的文件
└── main/       ← 主 worktree
```

好处：feature 分支可以并行检出到 `feature-x/` 等多个 worktree，互不干扰。

新建一个该布局的项目，跑 `init-bare-tree <name> [<clone-url>]`。如果 `~/.local/bin/` 在你的 PATH 里，`sync-tasks.sh` 会自动 symlink 过去；否则它会打印一行 `ln` 命令让你手动装。

## 开发者注意

- 目标 shell 是 macOS 自带的 **bash 3.2.57**。不要用 `mapfile` / `${var^}` / `${var,}` / 关联数组等 bash 4+ 特性。
- 新脚本应该 `source lib.sh` 复用以下工具函数：`show_intro` / `print_header` / `confirm` / `ensure_clean_state` / `enable_failure_rollback` / `run_or_abort` / `require_bare_layout` / `wait_to_close` / `copy_to_clipboard` / `maybe_open_in_zed`。
- 动历史的脚本顶部加 `ensure_clean_state` + `enable_failure_rollback`。EXIT trap 由 `lib.sh` 自身在顶层注册，wait-to-close + 失败自动 abort 行为是自动的。
- 反馈在终端外的脚本（剪贴板 / 在编辑器打开）顶部 `export GIT_COMMAND_NO_PAUSE=1`，跳过结尾的按键提示——没什么 terminal 输出值得读。
- 所有用户可见文本放在 `lang/<code>.sh`（运行时文案 `MSG_*`）和 `lang/labels-<code>.sh`（菜单 label `LABEL_*`）里。加新语言：复制 `lang/en.sh` + `lang/labels-en.sh`，翻译，然后跑 `./test/verify-translations.sh` 会自动检查变量数和 `%s/%d` 一致性。

## 测试

```bash
bash test/test-all.sh                # 42 assertions — 8 个核心脚本的 happy path + 边界
bash test/test-rollback.sh           # 10 assertions — EXIT trap / 自动 abort / ensure_clean_state
bash test/test-chains.sh             # 12 assertions — branch / worktree / stash 链式工作流
bash test/test-edge.sh               #  9 assertions — VIEW wrapper / detached HEAD / 空 commit / CJK+emoji slug
bash test/test-history-rewrite.sh    # 19 assertions — 12 个改历史脚本全覆盖
bash test/verify-translations.sh     # 90 assertions — 10 种语言 i18n 对齐
```

合计 **182 assertions**，纯 bash + git 在 `mktemp` 沙箱里跑——没用任何外部框架，也没网络依赖。

## 已知限制（上游 Zed 待修）

| Issue | 现象 | 状态 |
|-------|------|------|
| [zed-industries/zed#53594](https://github.com/zed-industries/zed/issues/53594) | 外部 git 命令改 tag 后 Git Graph 不刷新，需要 Reload Window | OPEN, P2 |
| [zed-industries/zed#58777](https://github.com/zed-industries/zed/issues/58777) | `tasks.json` 缺 `detail` 字段和原生 `separator` 类型，菜单标签无法对齐右列 | OPEN |
