#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "$MSG_EXPORT_FILES_TITLE" \
  "$MSG_EXPORT_FILES_PURPOSE" \
  "$MSG_EXPORT_FILES_WHEN" \
  "$MSG_EXPORT_FILES_CONTRAST"

print_header "$SHA"

files=()
while IFS= read -r f; do
  [[ -n "$f" ]] && files+=("$f")
done < <(git diff-tree --no-commit-id --name-only -r "$SHA")

if (( ${#files[@]} == 0 )); then
  echo "$MSG_EXPORT_FILES_EMPTY" >&2
  exit 1
fi

short="$(git rev-parse --short "$SHA")"

printf "$MSG_EXPORT_FILES_COUNT_FMT" "${#files[@]}"
printf '  %s\n' "${files[@]}" | head -20
if (( ${#files[@]} > 20 )); then
  printf "$MSG_EXPORT_FILES_OVERFLOW_FMT" "$(( ${#files[@]} - 20 ))"
fi
echo

default_dir="./commit-export/$short"
prompt=$(printf "$MSG_EXPORT_FILES_DIR_PROMPT_FMT" "$default_dir")
read -erp "$prompt" outdir
outdir="${outdir:-$default_dir}"

if [[ -e "$outdir" ]] && [[ -n "$(ls -A "$outdir" 2>/dev/null || true)" ]]; then
  printf "$MSG_EXPORT_FILES_DIR_EXISTS_FMT" "$outdir"
  confirm "$MSG_EXPORT_FILES_OVERWRITE_CONFIRM"
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
    echo "  skip $f  $MSG_EXPORT_FILES_DELETED_HINT"
    skipped=$((skipped+1))
  fi
done

echo
printf "$MSG_EXPORT_FILES_DONE_FMT" "$ok" "$skipped" "$outdir"
echo "$MSG_EXPORT_FILES_DONE_NOTE"
