#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "export-patches（导出 N 条补丁文件）" \
  "作用: 从此 commit 向前导出 N 条，可选 mbox (.patch) 或纯 diff (.diff)" \
  "场景: 邮件协作 / 备份特定改动 / 给别人用 git am / git apply 接收" \
  "输出: 自定目录（默认 ./patches）；不会修改任何历史"

print_header "$SHA"

read -rp "格式 [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply)（默认 f）：" mode
mode="${mode:-f}"
case "$mode" in
  f|F|format) mode=format ;;
  d|D|diff)   mode=diff ;;
  *) echo "无效的格式：$mode" >&2; exit 1 ;;
esac

read -rp "导出几条（从此提交向前 N 条，默认 1）：" n
n="${n:-1}"
if ! [[ "$n" =~ ^[0-9]+$ ]] || (( n < 1 )); then
  echo "无效的数量：$n" >&2
  exit 1
fi

read -rp "输出目录（相对仓库根，默认 ./patches）：" outdir
outdir="${outdir:-./patches}"

start_ref="${SHA}~$((n - 1))"
start_short="$(git rev-parse --short "$start_ref" 2>/dev/null || echo '(根)')"
end_short="$(git rev-parse --short "$SHA")"

echo
echo "格式：$mode"
echo "范围：${start_short}..${end_short}  (共 $n 条)"
echo "输出：$outdir/"
confirm "继续？"

if [[ "$mode" == format ]]; then
  git format-patch -"$n" -o "$outdir" "$SHA"
else
  mkdir -p "$outdir"
  i=1
  while read -r commit; do
    num=$(printf "%04d" "$i")
    subject=$(git log -1 --format='%f' "$commit")
    out="$outdir/${num}-${subject}.diff"
    git show --no-color "$commit" > "$out"
    echo "$out"
    i=$((i + 1))
  done < <(git rev-list -n "$n" --reverse "$SHA")
fi
