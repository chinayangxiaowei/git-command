#!/usr/bin/env bash
# worktree-from.sh — check out this commit in a new worktree
# Usage: bash worktree-from.sh <purpose> <SHA>
#   <purpose> ∈ {review, try, fix, feat, hot}
#
# NOTE: we intentionally do NOT set -euo pipefail at the top level.
# The slug() helper below is unit-tested by sourcing this file from
# test/test-all.sh — putting `set -e` at the top would leak strict
# mode into the caller's shell. The bottom-of-file source guard
# enables strict mode only when the file is *executed* directly.

# Slugify a commit subject for use as a branch / path name.
# Rules:
#   - replace with -: space, tab, control chars, ~^:?*[\, and /
#   - keep: ()  .  _  alphanumerics  Chinese  emoji  other allowed chars
#   - collapse repeated -; trim leading/trailing -
slug() {
  local s="$1"
  s=$(printf '%s' "$s" | sed -e 's/[[:cntrl:][:space:]~^:?*[\\/]/-/g')
  while [[ "$s" == *--* ]]; do s="${s//--/-}"; done
  s="${s#-}"
  s="${s%-}"
  printf '%s' "$s"
}

main() {
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

  show_intro "$(printf "$MSG_WT_FROM_TITLE_FMT" "$purpose")" \
    "$MSG_WT_FROM_PURPOSE" \
    "$(printf "$MSG_WT_FROM_NOTE_FMT" "$purpose")"
  print_header "$SHA"

  local short_sha
  short_sha=$(git rev-parse --short "$SHA")

  local container rel_path abs_path
  container=$(cd "$(git rev-parse --git-common-dir)/.." && pwd)

  if [ "$purpose" = "review" ]; then
    rel_path="review/$short_sha"
    abs_path="$container/$rel_path"

    if [ -e "$abs_path" ]; then
      printf "$MSG_WT_FROM_PATH_EXISTS_FMT" "$abs_path" >&2
      echo "$MSG_WT_FROM_PATH_HINT" >&2
      exit 1
    fi

    git worktree add --detach "$abs_path" "$SHA"

    echo
    printf "$MSG_WT_FROM_CREATED_FMT" "$abs_path"
    printf "$MSG_WT_FROM_CLEANUP_REVIEW_FMT" "$abs_path"
    maybe_open_in_zed "$abs_path"
    exit 0
  fi

  local base_slug current
  current=$(git rev-parse --abbrev-ref HEAD)
  if [ "$current" = "HEAD" ]; then
    base_slug="detached"
  else
    base_slug="${current//\//-}"
  fi

  local branch
  if [ "$purpose" = "try" ]; then
    rel_path="try/${base_slug}-${short_sha}"
    abs_path="$container/$rel_path"
    branch="$rel_path"

    if [ -e "$abs_path" ]; then
      printf "$MSG_WT_FROM_PATH_EXISTS_FMT" "$abs_path" >&2
      exit 1
    fi
    if git show-ref --verify --quiet "refs/heads/$branch"; then
      printf "$MSG_WT_FROM_BRANCH_EXISTS_FMT" "$branch" >&2
      exit 1
    fi

    git worktree add -b "$branch" "$abs_path" "$SHA"

    echo
    printf "$MSG_WT_FROM_CREATED_FMT" "$abs_path"
    printf "$MSG_WT_FROM_BRANCH_LABEL_FMT" "$branch"
    printf "$MSG_WT_FROM_CLEANUP_BRANCH_FMT" "$abs_path" "$branch"
    maybe_open_in_zed "$abs_path"
    exit 0
  fi

  # fix / feat / hot — user input, default slug(subject)-short_sha
  local subject default_name name
  subject=$(git log -1 --format='%s' "$SHA")
  default_name="$(slug "$subject")-${short_sha}"
  if [ "$default_name" = "-${short_sha}" ]; then
    default_name="${base_slug}-${short_sha}"
  fi

  prompt=$(printf "$MSG_WT_FROM_NAME_PROMPT_FMT" "$default_name")
  read -erp "$prompt" name
  name="${name:-$default_name}"
  name="$(slug "$name")"
  if [ -z "$name" ]; then
    name="${base_slug}-${short_sha}"
  fi

  rel_path="${purpose}/${name}"
  abs_path="$container/$rel_path"
  branch="$rel_path"

  if [ -e "$abs_path" ]; then
    printf "$MSG_WT_FROM_PATH_EXISTS_FMT" "$abs_path" >&2
    exit 1
  fi
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    printf "$MSG_WT_FROM_BRANCH_EXISTS_FMT" "$branch" >&2
    exit 1
  fi

  git worktree add -b "$branch" "$abs_path" "$SHA"

  echo
  printf "$MSG_WT_FROM_CREATED_FMT" "$abs_path"
  printf "$MSG_WT_FROM_BRANCH_LABEL_FMT" "$branch"
  printf "$MSG_WT_FROM_CLEANUP_BRANCH_FMT" "$abs_path" "$branch"
  maybe_open_in_zed "$abs_path"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Enable strict mode only when this file is the entry point. Sourcing
  # for slug() unit tests (test-all.sh) doesn't get strict mode leaked.
  set -euo pipefail
  main "$@"
fi
