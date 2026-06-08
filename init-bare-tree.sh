#!/usr/bin/env bash
# init-bare-tree.sh — 用 bare repo + worktrees 布局新建项目
#
# 用法:
#   ./init-bare-tree.sh <project-name>                  # 新建空项目
#   ./init-bare-tree.sh <project-name> <clone-url>      # clone 已有 repo
#
# 结果布局:
#   project-name/
#   ├── .bare/              ← 实际 git 数据（bare 仓库）
#   ├── .git                ← 文件，内容 "gitdir: ./.bare"
#   └── main/               ← 主 worktree（或克隆仓库的默认分支名）
#       └── ... your files
#
# 之后新建 worktree:
#   cd project-name
#   git worktree add <branch>           # 新 worktree 在 ./<branch>/
#
# 这个脚本独立运行 (不 source lib.sh)，因为它不需要 Zed pane / i18n /
# require_bare_layout 等。但它有自己的 EXIT trap，失败时清理本脚本
# 创建的目录，避免留下半成品 .bare/ + .git + 部分 worktree。

set -euo pipefail

NAME="${1:?usage: $0 <project-name> [<clone-url>]}"
URL="${2:-}"

if [[ -e "$NAME" ]]; then
  echo "目录已存在: $NAME" >&2
  exit 1
fi

# Absolute path so cleanup works no matter where cwd ends up.
PROJECT_DIR="$(pwd)/$NAME"
# Sentinel: only flip to 1 after we successfully created the directory.
# Cleanup is conditional on this — never rm a directory that pre-existed.
WE_CREATED_DIR=0
SUCCESS=0

_init_cleanup_on_exit() {
  local rc=$?
  if [ "$SUCCESS" -eq 1 ]; then
    return 0   # finished cleanly, nothing to clean
  fi
  if [ "$WE_CREATED_DIR" -eq 1 ] && [ -d "$PROJECT_DIR" ]; then
    # cd somewhere safe so rm -rf doesn't operate on cwd
    cd / 2>/dev/null || true
    rm -rf "$PROJECT_DIR"
    echo "init failed (exit $rc); removed partial project: $PROJECT_DIR" >&2
  fi
}
trap _init_cleanup_on_exit EXIT

mkdir "$NAME"
WE_CREATED_DIR=1
cd "$NAME"

if [[ -n "$URL" ]]; then
  echo "Cloning $URL as bare..."
  git clone --bare "$URL" .bare
  # bare 默认 fetch 配置不带 origin/* 远端追踪，补一下
  git --git-dir=.bare config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
  default_branch="$(git --git-dir=.bare symbolic-ref HEAD --short 2>/dev/null || echo main)"
else
  echo "Initializing empty bare repo..."
  git init --bare .bare > /dev/null
  default_branch="main"
  # 把 HEAD 指向 refs/heads/main（即使分支还不存在）
  git --git-dir=.bare symbolic-ref HEAD "refs/heads/${default_branch}"
  # 造一个 empty tree 的初始 commit，否则 worktree add 拒绝无 HEAD
  EMPTY_TREE=$(git --git-dir=.bare hash-object -t tree --stdin < /dev/null)
  INITIAL_COMMIT=$(git --git-dir=.bare commit-tree -m "Initial commit" "$EMPTY_TREE")
  git --git-dir=.bare update-ref "refs/heads/${default_branch}" "$INITIAL_COMMIT"
fi

# 关键：建立 gitdir 指向，让 cwd=root 也能跑 git 命令
echo "gitdir: ./.bare" > .git

# 创建主 worktree（跟 default branch 同名子目录）
git worktree add "$default_branch" "$default_branch"

# Past this point everything succeeded.
SUCCESS=1

echo
echo "─── 完成 ───"
echo "项目根: $(pwd)"
echo "bare:   $(pwd)/.bare"
echo "主 wt:  $(pwd)/${default_branch}"
echo
echo "下一步："
echo "  cd ${default_branch}"
echo "  # 编辑 / commit / push"
echo
echo "起新 worktree 切别的分支（不动主 wt）："
echo "  cd $(pwd)"
echo "  git worktree add <branch-name>           # 新 worktree 在 ./<branch-name>/"
echo "  git worktree add -b new-feat new-feat    # 顺带建新分支"
echo "  git worktree list                        # 看所有 worktree"
echo "  git worktree remove <path>               # 删 worktree"
