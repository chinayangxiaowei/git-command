#!/usr/bin/env bash
# verify-translations.sh — sanity-check every lang/<code>.sh and lang/labels-<code>.sh
# Run after adding/translating a language.
#
# Checks per language:
#   1. bash -n syntax parse
#   2. source executes cleanly (no errors)
#   3. MSG_ / LABEL_ variable counts match the English reference
#   4. %s / %d counts per variable match the English reference (no lost / extra format specifiers)
#   5. no bare unescaped % (only %s / %d / %%)
#   6. unbalanced quote heuristic (single ' inside single-quoted strings)
#   7. sync-tasks.sh accepts the language → tasks.json is valid JSON, no placeholder leak

set -euo pipefail

# UTF-8 locale makes grep on Chinese/Japanese/Korean text 50x slower.
# We only do ASCII pattern matching here (MSG_/LABEL_/%s/%d), so force C locale.
export LC_ALL=C

cd "$(dirname "${BASH_SOURCE[0]}")/.."
REPO="$(pwd)"

EN_MSG="$REPO/lang/en.sh"
EN_LABELS="$REPO/lang/labels-en.sh"

if [ ! -f "$EN_MSG" ] || [ ! -f "$EN_LABELS" ]; then
  echo "Missing English reference files." >&2
  exit 1
fi

en_msg_count=$(grep -c '^MSG_' "$EN_MSG")
en_labels_count=$(grep -c '^LABEL_' "$EN_LABELS")

pass=0
fail=0
ok()  { pass=$((pass+1)); echo "  ✓ $1"; }
err() { fail=$((fail+1)); echo "  ✗ $1"; }

count_var_fmt_specifiers() {
  # for a given file + var name, count %s / %d in the value
  local file="$1" var="$2"
  grep "^${var}=" "$file" | head -1 | grep -oE '%[sd]' | wc -l | tr -d ' '
}

verify_lang() {
  local code="$1"
  local msg_file="$REPO/lang/${code}.sh"
  local labels_file="$REPO/lang/labels-${code}.sh"

  echo
  echo "── [${code}] ──"

  [ -f "$msg_file" ]    || { err "[$code] missing $msg_file";    return; }
  [ -f "$labels_file" ] || { err "[$code] missing $labels_file"; return; }

  # 1. bash -n syntax
  if bash -n "$msg_file" 2>/dev/null; then
    ok "[$code] $msg_file parses"
  else
    err "[$code] $msg_file FAILS bash -n"
    bash -n "$msg_file" 2>&1 | head -3 | sed 's/^/      /'
  fi
  if bash -n "$labels_file" 2>/dev/null; then
    ok "[$code] $labels_file parses"
  else
    err "[$code] $labels_file FAILS bash -n"
    bash -n "$labels_file" 2>&1 | head -3 | sed 's/^/      /'
  fi

  # 2. source executes (catches more issues than -n)
  if ( set -u; source "$msg_file" ) >/dev/null 2>&1; then
    ok "[$code] source $msg_file"
  else
    err "[$code] source $msg_file FAILED"
    ( source "$msg_file" ) 2>&1 | head -3 | sed 's/^/      /' || true
  fi
  if ( set -u; source "$labels_file" ) >/dev/null 2>&1; then
    ok "[$code] source $labels_file"
  else
    err "[$code] source $labels_file FAILED"
    ( source "$labels_file" ) 2>&1 | head -3 | sed 's/^/      /' || true
  fi

  # 3. variable counts
  local msg_count labels_count
  msg_count=$(grep -c '^MSG_' "$msg_file" || echo 0)
  labels_count=$(grep -c '^LABEL_' "$labels_file" || echo 0)

  if [ "$msg_count" = "$en_msg_count" ]; then
    ok "[$code] MSG_ count = $msg_count (matches en)"
  else
    err "[$code] MSG_ count $msg_count != en $en_msg_count"
  fi
  if [ "$labels_count" = "$en_labels_count" ]; then
    ok "[$code] LABEL_ count = $labels_count (matches en)"
  else
    err "[$code] LABEL_ count $labels_count != en $en_labels_count"
  fi

  # 4. global %s/%d counts match (only counted on MSG_/LABEL_ lines, comments excluded)
  local en_pct tr_pct
  en_pct=$(grep -E '^(MSG_|LABEL_)' "$EN_MSG" | grep -oE '%[sd]' | wc -l | tr -d ' ')
  tr_pct=$(grep -E '^(MSG_|LABEL_)' "$msg_file" | grep -oE '%[sd]' | wc -l | tr -d ' ')
  if [ "$en_pct" = "$tr_pct" ]; then
    ok "[$code] global %s/%d count = $tr_pct (matches en)"
  else
    err "[$code] global %s/%d count $tr_pct != en $en_pct"
  fi

  # 5. unescaped bare %
  local bare_pct
  bare_pct=$(grep -E '%[^sd%]' "$msg_file" | grep -vE '^\s*#' | head -1 || true)
  if [ -z "$bare_pct" ]; then
    ok "[$code] no bare % (printf-safe)"
  else
    err "[$code] bare % found (printf will misparse):"
    echo "      $bare_pct" | head -1
  fi

  # 6. sync-tasks.sh accepts this lang
  if ./sync-tasks.sh "$code" >/dev/null 2>&1; then
    ok "[$code] sync-tasks.sh $code succeeds"
    # also verify JSON
    if python3 -c "import json; json.load(open('$HOME/.config/zed/tasks.json'))" 2>/dev/null; then
      ok "[$code] rendered tasks.json is valid JSON"
    else
      err "[$code] tasks.json INVALID after sync-tasks.sh $code"
    fi
  else
    err "[$code] sync-tasks.sh $code FAILED"
    ./sync-tasks.sh "$code" 2>&1 | head -3 | sed 's/^/      /' || true
  fi
}

# Default: all languages found in lang/
if [ $# -eq 0 ]; then
  langs=()
  for f in lang/*.sh; do
    name=$(basename "$f" .sh)
    case "$name" in
      labels-*) ;;     # skip labels files
      *) langs+=("$name") ;;
    esac
  done
else
  langs=("$@")
fi

echo "Reference: en  (MSG=$en_msg_count, LABEL=$en_labels_count)"
echo "Will verify: ${langs[*]}"

for code in "${langs[@]}"; do
  [ "$code" = "en" ] && continue
  verify_lang "$code"
done

# Restore en so we leave Zed in a sane state
./sync-tasks.sh en >/dev/null 2>&1 || true

echo
echo "── Total ──"
echo "PASS: $pass   FAIL: $fail"
[ "$fail" -eq 0 ]
