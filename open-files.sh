#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "open-files（在 Zed 打开此 commit 涉及的所有文件）" \
  "作用: 列出此 commit 改动的文件，在 Zed 中全部打开（当前 working 版本）" \
  "场景: 调试历史 bug，想看那次改动相关的所有文件" \
  "前提: PATH 里有 zed 命令；当前不存在的文件会跳过"

print_header "$SHA"

# 此提交涉及的文件
files=()
missing=()
while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  if [[ -f "$f" ]]; then
    files+=("$f")
  else
    missing+=("$f")
  fi
done < <(git diff-tree --no-commit-id --name-only -r "$SHA")

if (( ${#files[@]} == 0 && ${#missing[@]} == 0 )); then
  echo "此提交没有文件变更（可能是空 commit）。" >&2
  exit 1
fi

if (( ${#missing[@]} > 0 )); then
  echo "以下文件在当前工作区不存在（可能已删除/重命名），跳过："
  printf '  %s\n' "${missing[@]}"
  echo
fi

if (( ${#files[@]} == 0 )); then
  echo "此提交涉及的文件在当前工作区都不在了。" >&2
  exit 1
fi

echo "将在 Zed 中打开 ${#files[@]} 个文件："
printf '  %s\n' "${files[@]}"

if ! command -v zed >/dev/null 2>&1; then
  echo >&2
  echo "未找到 zed 命令。" >&2
  echo "在 Zed 里：cmd+shift+P → 'zed: install cli' 安装 zed 命令到 PATH。" >&2
  exit 1
fi

zed "${files[@]}"
