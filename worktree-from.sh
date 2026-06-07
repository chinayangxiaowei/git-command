#!/usr/bin/env bash
# worktree-from.sh — 从此 commit 在新 worktree 检出
# 用法: bash worktree-from.sh <purpose> <SHA>
#   <purpose> ∈ {review, try, fix, feat, hot}

# Slug 化 commit subject 用于分支名 / 路径
# 规则:
#   - 替换为 -: 空格 tab 控制字符 ~^:?*[\ /
#   - 保留: ()  .  _  字母数字  中文  emoji 等其他 git 允许字符
#   - 折叠连续 -、去首尾 -
slug() {
  local s="$1"
  # 替换控制字符 / 空白 / git 非法字符 / 斜杠为 -
  s=$(printf '%s' "$s" | sed -e 's/[[:cntrl:][:space:]~^:?*[\\/]/-/g')
  # 折叠连续 -
  while [[ "$s" == *--* ]]; do s="${s//--/-}"; done
  # 去首尾 -
  s="${s#-}"
  s="${s%-}"
  printf '%s' "$s"
}

main() {
  set -euo pipefail
  local DIR
  DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  # shellcheck source=/dev/null
  source "$DIR/lib.sh"

  local purpose="${1:?usage: $0 <purpose> <SHA>}"
  local sha_in="${2:?usage: $0 <purpose> <SHA>}"

  case "$purpose" in
    review|try|fix|feat|hot) ;;
    *) echo "invalid purpose: $purpose (need: review/try/fix/feat/hot)" >&2; exit 1 ;;
  esac

  require_bare_layout

  local SHA
  if ! SHA=$(git rev-parse --verify "${sha_in}^{commit}" 2>/dev/null); then
    echo "invalid SHA: $sha_in" >&2
    exit 1
  fi

  show_intro "worktree-from（$purpose）" \
    "作用: 从此 commit 在新 worktree 检出（按 purpose 分组）" \
    "purpose: $purpose"
  print_header "$SHA"

  # 后续 Task 实现各 purpose 子流程
  echo "TODO: implement $purpose flow" >&2
  exit 1
}

# Source guard: 仅作为脚本直接执行时跑 main
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
