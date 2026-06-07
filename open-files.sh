#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"
export GIT_COMMAND_NO_PAUSE=1   # feedback is outside the terminal (clipboard/editor)

show_intro "$MSG_OPEN_FILES_TITLE" \
  "$MSG_OPEN_FILES_PURPOSE" \
  "$MSG_OPEN_FILES_WHEN" \
  "$MSG_OPEN_FILES_PREREQ"

print_header "$SHA"

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
  echo "$MSG_OPEN_FILES_EMPTY" >&2
  exit 1
fi

if (( ${#missing[@]} > 0 )); then
  echo "$MSG_OPEN_FILES_MISSING"
  printf '  %s\n' "${missing[@]}"
  echo
fi

if (( ${#files[@]} == 0 )); then
  echo "$MSG_OPEN_FILES_ALL_GONE" >&2
  exit 1
fi

printf "$MSG_OPEN_FILES_OPENING_FMT" "${#files[@]}"
printf '  %s\n' "${files[@]}"

if ! command -v zed >/dev/null 2>&1; then
  echo >&2
  echo "$MSG_OPEN_FILES_NO_ZED" >&2
  echo "$MSG_OPEN_FILES_INSTALL_HINT" >&2
  exit 1
fi

zed "${files[@]}"
