#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_EXPORT_PATCHES_TITLE" \
  "$MSG_EXPORT_PATCHES_PURPOSE" \
  "$MSG_EXPORT_PATCHES_WHEN" \
  "$MSG_EXPORT_PATCHES_OUTPUT"

print_header "$SHA"

read -rp "$MSG_EXPORT_PATCHES_FORMAT_PROMPT" mode
mode="${mode:-f}"
case "$mode" in
  f|F|format) mode=format ;;
  d|D|diff)   mode=diff ;;
  *) printf "$MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT" "$mode" >&2; exit 1 ;;
esac

read -rp "$MSG_EXPORT_PATCHES_COUNT_PROMPT" n
n="${n:-1}"
if ! [[ "$n" =~ ^[0-9]+$ ]] || (( n < 1 )); then
  printf "$MSG_EXPORT_PATCHES_COUNT_INVALID_FMT" "$n" >&2
  exit 1
fi

read -rp "$MSG_EXPORT_PATCHES_OUTDIR_PROMPT" outdir
outdir="${outdir:-./patches}"

start_ref="${SHA}~$((n - 1))"
start_short="$(git rev-parse --short "$start_ref" 2>/dev/null || echo "$MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER")"
end_short="$(git rev-parse --short "$SHA")"

echo
echo "$MSG_EXPORT_PATCHES_FORMAT_LABEL $mode"
echo "$MSG_EXPORT_PATCHES_RANGE_LABEL ${start_short}..${end_short}  (n=$n)"
echo "$MSG_EXPORT_PATCHES_OUTPUT_LABEL $outdir/"
confirm "$MSG_EXPORT_PATCHES_CONTINUE"

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
