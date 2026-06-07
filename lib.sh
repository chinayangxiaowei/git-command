#!/usr/bin/env bash
# 公共工具：脚本被 source，不直接执行
# shellcheck shell=bash

# 命令头：展示用法 + 场景
# 用法: show_intro "命令名" "作用: ..." "场景: ..." ["注意: ..."]
show_intro() {
  local title="$1"; shift
  echo "─── $title ───"
  local line
  for line in "$@"; do
    echo "  $line"
  done
  echo
}

print_header() {
  local sha="$1"
  local short subj author when
  short="$(git rev-parse --short "$sha")"
  subj="$(git log -1 --format='%s' "$sha")"
  author="$(git log -1 --format='%an' "$sha")"
  when="$(git log -1 --format='%ar' "$sha")"
  printf '┌─ %s  %s\n' "$short" "$subj"
  printf '└─ %s · %s\n\n' "$author" "$when"
}

confirm() {
  local prompt="${1:-继续？}"
  local ans
  read -rp "$prompt [y/N] " ans
  if [[ ! "$ans" =~ ^[yY] ]]; then
    echo "已取消。"
    exit 130
  fi
}

# 拒绝在已有未完成的 rebase/cherry-pick/revert/merge 状态下运行
ensure_clean_state() {
  local gitdir in_progress="" hint=""
  gitdir="$(git rev-parse --git-dir)"
  if [ -d "$gitdir/rebase-merge" ] || [ -d "$gitdir/rebase-apply" ]; then
    in_progress="rebase"; hint="git rebase --abort"
  elif [ -f "$gitdir/CHERRY_PICK_HEAD" ]; then
    in_progress="cherry-pick"; hint="git cherry-pick --abort"
  elif [ -f "$gitdir/REVERT_HEAD" ]; then
    in_progress="revert"; hint="git revert --abort"
  elif [ -f "$gitdir/MERGE_HEAD" ]; then
    in_progress="merge"; hint="git merge --abort"
  fi
  if [ -n "$in_progress" ]; then
    echo "已有未完成的 ${in_progress}。先 ${hint} 或 --continue 处理掉再试。" >&2
    exit 1
  fi
}

# 包一层 git 子命令；冲突/失败时自动 --abort 并退出
# 用法：run_or_abort rebase  GIT_SEQUENCE_EDITOR=... git rebase -i ...
#       run_or_abort cherry-pick  git cherry-pick "$SHA"
run_or_abort() {
  local kind="$1"; shift
  if ! "$@"; then
    echo >&2
    echo "$kind 失败，自动 git $kind --abort（你的工作区已回滚到操作前）。" >&2
    git "$kind" --abort 2>/dev/null || true
    exit 1
  fi
}

# 全局兜底：注册后，任何非 0 退出（含 Ctrl+C / kill / 终端关闭）
# 若发现 rebase/cherry-pick/revert/merge 还在进行中 → 自动 abort 回滚。
# 也清理脚本里名为 $tmpdir 的临时目录（约定俗成）。
#
# 前提：调用方必须先跑过 ensure_clean_state，保证「在进行中」状态都是本次脚本造成的。
#
# 用法：enable_failure_rollback   # 在 ensure_clean_state 之后调用一次
enable_failure_rollback() {
  trap '_lib_cleanup_on_exit' EXIT
  trap 'exit 130' INT   # Ctrl+C
  trap 'exit 143' TERM  # kill / Zed 关 task
  trap 'exit 129' HUP   # 终端 / pane 关闭
}

# 检测当前 repo 是否为 bare+worktrees 布局，不是则退出
# 用法：require_bare_layout
require_bare_layout() {
  local root
  root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
  if [ -z "$root" ]; then
    echo "不在 git repo 内。" >&2
    exit 1
  fi
  # 容器根（bare 布局下 = .bare 的父目录）
  local container
  container="$(cd "$root" && cd .. && pwd)"  # worktree 所在的容器目录候选
  # bare 布局的特征：容器目录里有 .bare/ + .git 文件指向 .bare
  if [ ! -d "$container/.bare" ] || [ ! -f "$container/.git" ] || \
     ! grep -q 'gitdir:.*\.bare' "$container/.git" 2>/dev/null; then
    echo "当前不在 bare + worktrees 布局下，worktree 菜单已禁用。" >&2
    echo "如需启用，新项目用：bash git-command/init-bare-tree.sh <name> [<url>]" >&2
    echo "已有项目用 migrate-to-bare-tree.sh（暂未实现，先手动迁移）。" >&2
    exit 1
  fi
}

_lib_cleanup_on_exit() {
  local rc=$?

  # 清理 tmpdir（如果脚本里定义了同名变量）
  if [[ -n "${tmpdir:-}" && -d "${tmpdir:-}" ]]; then
    rm -rf "$tmpdir"
  fi

  # 仅在非 0 退出时检查是否有未完成的 git 操作要 abort
  if [ "$rc" -ne 0 ]; then
    local gdir kind=""
    gdir="$(git rev-parse --git-dir 2>/dev/null || true)"
    [ -z "$gdir" ] && return 0

    if [ -d "$gdir/rebase-merge" ] || [ -d "$gdir/rebase-apply" ]; then
      kind=rebase
    elif [ -f "$gdir/CHERRY_PICK_HEAD" ]; then
      kind=cherry-pick
    elif [ -f "$gdir/REVERT_HEAD" ]; then
      kind=revert
    elif [ -f "$gdir/MERGE_HEAD" ]; then
      kind=merge
    fi

    if [ -n "$kind" ]; then
      echo >&2
      echo "脚本异常退出 (exit $rc)，自动 git $kind --abort 回滚到操作前。" >&2
      git "$kind" --abort 2>/dev/null || true
    fi
  fi
}
