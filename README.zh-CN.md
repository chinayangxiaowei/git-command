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
./sync-tasks.sh
```

`sync-tasks.sh` 做两件事：

1. 把所有 `*.sh` 拷到 `~/.config/zed/git-command/`
2. 用上面那个目录渲染 `tasks.json` 里的 `__GIT_COMMAND_DIR__` 占位符，
   结果写到 `~/.config/zed/tasks.json`

之后在 Zed 里 `Cmd+Shift+P` → `reload window`，所有项目的 Git Graph 右键菜单都会出现这 37 条命令。

需要换装位置？覆盖环境变量：

```bash
TARGET_DIR=~/.local/share/git-command ./sync-tasks.sh
```

## 菜单内容

37 个命令分 9 类，由 `tasks.json` 注入到 Zed Git Graph 的 commit 右键菜单。

| 类别 | 命令 |
|------|------|
| 查看 / 浏览 | 列含此 commit 的分支 / tag、stat、完整 diff、与 HEAD 对比、在编辑器中打开此 commit 涉及的所有文件、导出文件历史版本、导出向前 N 条 patch |
| 修改此 commit | reword（只改 message）、edit-commit（改 message + 增删文件） |
| 历史重写 | squash 向前 N 条、drop 此 commit、interactive rebase、soft / hard reset |
| Fixup | 工作区改动并入此 commit（fixup + autosquash）、把此 commit 折叠进祖先 |
| 复制 / 撤销 | cherry-pick、revert |
| 分支 | 从此 commit 创建分支、临时试错分支、把分支 A rebase 到分支 B（CLion 风格）、删除指向此 commit 的本地分支（可选远端） |
| Tag | 创建 tag、删除 tag（含远端） |
| Stash | 带名字 stash push、pop 最近 stash |
| Worktree | 从此 commit 在新 worktree 检出（review / try / fix / feat / hot 五种用途，自动命名 + 在新 Zed 窗口打开）；每种用途配套"删除"菜单项，列出该类型现有 worktree，复制粘贴名字确认 |

## 安全设计

所有改写历史的脚本走两层保护：

- **`ensure_clean_state`** — 启动前如果检测到 rebase / cherry-pick / revert / merge 进行中，直接拒绝运行
- **`enable_failure_rollback`** — 注册 EXIT / INT / TERM / HUP trap，任何非零退出 + 检测到残留 rebase 状态都会自动 `--abort` 清理

只有 `SIGKILL` / 断电这种不可拦截信号无法回滚（POSIX 限制）。

每个脚本顶部都会用 `show_intro` 打印"做什么 / 何时用 / 注意点"，二次确认后才开干。

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

新建一个该布局的项目，跑独立工具：`bash <路径>/init-bare-tree.sh <name> [<clone-url>]`（sync-tasks.sh 已经把它部署到 `~/.config/zed/git-command/`；可以 symlink 到 PATH 方便调用）。

## 开发者注意

- 目标 shell 是 macOS 自带的 **bash 3.2.57**。不要用 `mapfile` / `${var^}` / `${var,}` / 关联数组等 bash 4+ 特性。
- 任何新脚本都应该 `source lib.sh` 复用 7 个工具函数（`show_intro` / `print_header` / `confirm` / `ensure_clean_state` / `enable_failure_rollback` / `run_or_abort` / `require_bare_layout`）。
- 动历史的脚本必须组合 `ensure_clean_state` + `enable_failure_rollback`。

## 测试

```bash
bash test/test-worktree-from.sh    # 19 assertions
bash test/test-branch-delete.sh    # 6 assertions
bash test/test-worktree-remove.sh  # 6 assertions
```

## 已知限制（上游 Zed 待修）

| Issue | 现象 | 状态 |
|-------|------|------|
| [zed-industries/zed#53594](https://github.com/zed-industries/zed/issues/53594) | 外部 git 命令改 tag 后 Git Graph 不刷新，需要 Reload Window | OPEN, P2 |
| [zed-industries/zed#58777](https://github.com/zed-industries/zed/issues/58777) | `tasks.json` 缺 `detail` 字段和原生 `separator` 类型，菜单标签无法对齐右列 | OPEN |
