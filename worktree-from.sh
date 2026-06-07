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
  echo "main() not implemented yet"
  exit 1
}

# Source guard: 仅作为脚本直接执行时跑 main
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
