#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "export-commit-files（导出此 commit 涉及的文件到指定文件夹）" \
  "作用: 把此 commit 改动的每个文件的「该 commit 时的版本」拷到指定目录，保留路径结构" \
  "场景: 文件多不想全开标签页 / 取走某 commit 的产物快照 / 离线对比" \
  "区别: open-files 在 Zed 打开当前 working 版本；本菜单导出此 commit 时的历史版本"

print_header "$SHA"

# 此 commit 涉及的文件
files=()
while IFS= read -r f; do
  [[ -n "$f" ]] && files+=("$f")
done < <(git diff-tree --no-commit-id --name-only -r "$SHA")

if (( ${#files[@]} == 0 )); then
  echo "此 commit 没有文件变更（可能是空 commit）。" >&2
  exit 1
fi

short="$(git rev-parse --short "$SHA")"

echo "此 commit 涉及 ${#files[@]} 个文件："
printf '  %s\n' "${files[@]}" | head -20
if (( ${#files[@]} > 20 )); then
  echo "  ... 还有 $(( ${#files[@]} - 20 )) 个"
fi
echo

default_dir="./commit-export/$short"
read -erp "导出目录（相对仓库根，默认 ${default_dir}）：" outdir
outdir="${outdir:-$default_dir}"

if [[ -e "$outdir" ]] && [[ -n "$(ls -A "$outdir" 2>/dev/null || true)" ]]; then
  echo "目录已存在且非空：$outdir"
  confirm "继续会覆盖里面同名文件，确认？"
fi

mkdir -p "$outdir"
echo

ok=0
skipped=0
for f in "${files[@]}"; do
  dest="$outdir/$f"
  mkdir -p "$(dirname "$dest")"
  if git show "${SHA}:${f}" > "$dest" 2>/dev/null; then
    echo "  out  $f"
    ok=$((ok+1))
  else
    rm -f "$dest"
    echo "  skip $f  (此 commit 里被删除，无内容可导)"
    skipped=$((skipped+1))
  fi
done

echo
echo "完成：导出 $ok 个，跳过 $skipped 个 → $outdir/"
echo "提示：导出目录里是此 commit 时的快照，不是当前 working 版本。"
