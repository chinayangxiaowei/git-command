#!/usr/bin/env bash
# 公共工具：脚本被 source，不直接执行
# shellcheck shell=bash

# ── 加载语言包 ────────────────────────────────────────────────────
# 部署后：sync-tasks.sh 把 lang/<lang>.sh 拷贝并改名为 lang.sh
# 开发时：源码目录里没有 lang.sh，fallback 到 lang/en.sh
_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$_LIB_DIR/lang.sh" ]; then
  # shellcheck source=/dev/null
  source "$_LIB_DIR/lang.sh"
elif [ -f "$_LIB_DIR/lang/en.sh" ]; then
  # shellcheck source=/dev/null
  source "$_LIB_DIR/lang/en.sh"
else
  echo "lib.sh: 找不到语言包（lang.sh 或 lang/en.sh）" >&2
  exit 1
fi

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
    # User cancelled before any work happened — short-circuit the EXIT
    # trap so the pane closes immediately (no "press Enter" needed) AND
    # Zed's hide:on_success collapses it (because we still exit 0).
    exit_ok
  fi
}

# Successful no-op exit: pane closes immediately without prompting the
# user to press Enter. Use this wherever the script bails out before
# doing real work — empty input, ':q' in a message editor, "no branches
# at this commit", "already on target branch", etc. The user didn't see
# anything they need to acknowledge.
exit_ok() {
  _GIT_CMD_DONE=1
  exit 0
}

# 拒绝在已有未完成的 rebase/cherry-pick/revert/merge 状态下运行
require_clean_state() {
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
    printf "$MSG_LIB_IN_PROGRESS_FMT" "$in_progress" "$hint" >&2
    # This is a precondition failure — the mid-op state was created by
    # a *prior* operation, not by this script. Mark _GIT_CMD_DONE so the
    # EXIT trap's abort branch is short-circuited; otherwise we'd destroy
    # the user's pre-existing rebase/cherry-pick state they came here to
    # resolve. exit 1 (not 0) so Zed leaves the pane up with the message.
    _GIT_CMD_DONE=1
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
    printf "$MSG_LIB_RUN_OR_ABORT_FMT" "$kind" "$kind" >&2
    git "$kind" --abort 2>/dev/null || true
    exit 1
  fi
}

# 注册信号回滚（EXIT 和 INT trap 在文件底部已经自动注册了，这里只处理 TERM/HUP）
# INT 由 _lib_handle_int 智能处理（idle Ctrl+C → exit 0；mid-op Ctrl+C → exit 130
# 让 EXIT trap 走 abort 分支）。这里不再覆盖 INT，否则改历史的脚本会丢失智能判断。
# 用法：enable_failure_rollback   # 在 require_clean_state 之后调用一次
enable_failure_rollback() {
  trap 'exit 143' TERM  # kill / Zed 关 task
  trap 'exit 129' HUP   # 终端 / pane 关闭
  trap 'exit 131' QUIT  # Ctrl+\  (rare but possible)
}

# (legacy helper, kept for backwards compat — most scripts get auto-pause
# via the EXIT trap registered at the bottom of this file.)
wait_to_close() {
  [ "${GIT_COMMAND_NO_PAUSE:-}" = "1" ] && return 0
  [ ! -t 0 ] && return 0
  echo
  read -r -p "$MSG_LIB_PRESS_ENTER" _ || true
}

# Best-effort: copy a string to the system clipboard.
# Returns 0 on success, 1 if no clipboard utility is available.
# Tries pbcopy (macOS) → wl-copy (Wayland) → xclip → xsel (X11).
copy_to_clipboard() {
  local s="$1"
  if command -v pbcopy >/dev/null 2>&1; then
    printf '%s' "$s" | pbcopy
  elif command -v wl-copy >/dev/null 2>&1; then
    printf '%s' "$s" | wl-copy
  elif command -v xclip >/dev/null 2>&1; then
    printf '%s' "$s" | xclip -selection clipboard
  elif command -v xsel >/dev/null 2>&1; then
    printf '%s' "$s" | xsel --clipboard --input
  else
    return 1
  fi
}

# Best-effort: open a path in a new Zed window.
# Honors GIT_COMMAND_NO_OPEN=1 to skip (used by the test suite to keep
# Zed from popping up during runs). Never fails the calling script.
maybe_open_in_zed() {
  local path="$1"
  [ "${GIT_COMMAND_NO_OPEN:-}" = "1" ] && return 0
  command -v zed >/dev/null 2>&1 && zed "$path" || true
}

# 检测当前 repo 是否为 bare+worktrees 布局，不是则退出
# 用法：require_bare_layout
require_bare_layout() {
  local root
  root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
  if [ -z "$root" ]; then
    echo "$MSG_LIB_NOT_IN_REPO" >&2
    exit 1
  fi
  local container
  container="$(cd "$root" && cd .. && pwd)"
  if [ ! -d "$container/.bare" ] || [ ! -f "$container/.git" ] || \
     ! grep -q 'gitdir:.*\.bare' "$container/.git" 2>/dev/null; then
    echo "$MSG_LIB_NOT_BARE_LAYOUT" >&2
    echo "$MSG_LIB_INIT_HINT" >&2
    echo "$MSG_LIB_MIGRATE_HINT" >&2
    exit 1
  fi
}

_lib_cleanup_on_exit() {
  local rc=$?

  # 清理 tmpdir（如果脚本里定义了同名变量）
  if [[ -n "${tmpdir:-}" && -d "${tmpdir:-}" ]]; then
    rm -rf "$tmpdir"
  fi

  # 主流程已完成、正在 wait 阶段被打断 → 不当失败处理，直接退（业务已成功）
  if [ "${_GIT_CMD_DONE:-}" = "1" ]; then
    return 0
  fi

  # 非 0 退出：检查是否有未完成的 git 操作要 abort，然后不暂停（让 user 看到错误）
  if [ "$rc" -ne 0 ]; then
    local gdir kind=""
    gdir="$(git rev-parse --git-dir 2>/dev/null || true)"
    if [ -n "$gdir" ]; then
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
        printf "$MSG_LIB_CLEANUP_FMT" "$rc" "$kind" >&2
        git "$kind" --abort 2>/dev/null || true
      fi
    fi
    return 0
  fi

  # exit 0 (success)：让 user 按 Enter 后才退出，配合 Zed 的 hide:on_success
  [ "${GIT_COMMAND_NO_PAUSE:-}" = "1" ] && return 0
  [ ! -t 0 ] && return 0
  # 标记主流程已完成；这之后任何 INT/TERM/HUP 引发的 re-entry 都不再回滚
  _GIT_CMD_DONE=1
  echo
  read -r -p "$MSG_LIB_PRESS_ENTER" _ || true
}

# Smart SIGINT handler — Ctrl+C while idle (waiting for read) is a clean
# user cancel → exit 0 so Zed's hide:on_success collapses the pane.
# Ctrl+C while a rebase/cherry-pick/revert/merge is mid-op → exit 130 so the
# EXIT trap rolls it back.
_lib_handle_int() {
  local gdir kind=""
  gdir="$(git rev-parse --git-dir 2>/dev/null || true)"
  if [ -n "$gdir" ]; then
    if [ -d "$gdir/rebase-merge" ] || [ -d "$gdir/rebase-apply" ]; then
      kind=rebase
    elif [ -f "$gdir/CHERRY_PICK_HEAD" ]; then
      kind=cherry-pick
    elif [ -f "$gdir/REVERT_HEAD" ]; then
      kind=revert
    elif [ -f "$gdir/MERGE_HEAD" ]; then
      kind=merge
    fi
  fi
  if [ -n "$kind" ]; then
    # Mid-op: hand off to the EXIT trap's abort branch
    exit 130
  fi
  # Idle state: treat as a successful user-initiated cancel.
  # Set the done flag so the EXIT trap skips both the abort branch AND
  # the wait-to-close read (we don't want to ask the user to press Enter
  # after they've already pressed Ctrl+C).
  _GIT_CMD_DONE=1
  echo
  exit 0
}

# 自动 EXIT trap — 任何 source lib.sh 的脚本都获得"成功后按 Enter 关闭"行为
# 反馈在终端外的脚本（copy / open-files）应在顶部 export GIT_COMMAND_NO_PAUSE=1
trap '_lib_cleanup_on_exit' EXIT
trap '_lib_handle_int' INT
