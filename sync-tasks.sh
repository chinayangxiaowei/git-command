#!/usr/bin/env bash
# Sync git-command scripts and Zed tasks configuration.
#
# What it does:
#   - Copies every *.sh (excluding self) to ~/.config/zed/git-command/
#   - Copies the chosen lang/<lang>.sh    to .../lang.sh   (script messages)
#   - Renders tasks.json by substituting __GIT_COMMAND_DIR__ and every
#     __LABEL_*__ placeholder, writing the result to ~/.config/zed/tasks.json
#
# Usage:
#   ./sync-tasks.sh            # defaults to en
#   ./sync-tasks.sh en
#   ./sync-tasks.sh zh
#   TARGET_DIR=~/bin/git-command ./sync-tasks.sh zh
#
# Env vars:
#   TARGET_DIR  script install dir   default $HOME/.config/zed/git-command
#   ZED_CONFIG  Zed config dir       default $HOME/.config/zed

set -euo pipefail

LANG_CHOICE="${1:-en}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${TARGET_DIR:-$HOME/.config/zed/git-command}"
ZED_CONFIG="${ZED_CONFIG:-$HOME/.config/zed}"
ZED_TASKS="$ZED_CONFIG/tasks.json"
SELF_NAME="$(basename "${BASH_SOURCE[0]}")"
MSG_SRC="$REPO_DIR/lang/${LANG_CHOICE}.sh"
LABELS_SRC="$REPO_DIR/lang/labels-${LANG_CHOICE}.sh"

if [ ! -f "$MSG_SRC" ]; then
  echo "✗ Script message pack not found: $MSG_SRC" >&2
  echo "  Available: $(cd "$REPO_DIR/lang" 2>/dev/null && ls [a-z][a-z].sh 2>/dev/null | sed 's/\.sh$//' | tr '\n' ' ')" >&2
  exit 1
fi
if [ ! -f "$LABELS_SRC" ]; then
  echo "✗ Menu-label pack not found: $LABELS_SRC" >&2
  exit 1
fi

if [ ! -f "$REPO_DIR/tasks.json" ]; then
  echo "✗ Not found: $REPO_DIR/tasks.json" >&2
  exit 1
fi

mkdir -p "$TARGET_DIR" "$ZED_CONFIG"

# 拷脚本（排除自己）
copied=0
for sh in "$REPO_DIR"/*.sh; do
  name="$(basename "$sh")"
  [ "$name" = "$SELF_NAME" ] && continue
  cp "$sh" "$TARGET_DIR/"
  chmod +x "$TARGET_DIR/$name"
  copied=$((copied + 1))
done

# 拷贝选定的脚本文案包，改名为 lang.sh（脚本固定 source 这一个文件）
cp "$MSG_SRC" "$TARGET_DIR/lang.sh"

# 渲染 tasks.json：
#   1) source labels-<lang>.sh 拿到所有 LABEL_* 变量
#   2) 把整个文件读入 $content
#   3) 替换 __GIT_COMMAND_DIR__ 为安装目录
#   4) 遍历 LABEL_* 变量，替换 __LABEL_X__ 占位符
#   5) 验证无残留 + 写出
# shellcheck source=/dev/null
source "$LABELS_SRC"
content=$(cat "$REPO_DIR/tasks.json")
content="${content//__GIT_COMMAND_DIR__/$TARGET_DIR}"
label_count=0
for label in $(compgen -A variable | grep '^LABEL_'); do
  val="${!label}"
  content="${content//__${label}__/$val}"
  label_count=$((label_count + 1))
done
printf '%s\n' "$content" > "$ZED_TASKS"

# Sanity: no placeholder should remain
if grep -qE "__(GIT_COMMAND_DIR|LABEL_[A-Z_]+)__" "$ZED_TASKS"; then
  echo "✗ Unsubstituted placeholders remain:" >&2
  grep -nE "__(GIT_COMMAND_DIR|LABEL_[A-Z_]+)__" "$ZED_TASKS" | head -5 >&2
  exit 1
fi

echo "✓ Synced $copied scripts   → $TARGET_DIR"
echo "✓ Message pack [$LANG_CHOICE] → $TARGET_DIR/lang.sh"
echo "✓ Substituted $label_count menu labels → tasks.json"
echo "✓ Rendered tasks.json     → $ZED_TASKS"
echo
echo "Next: in Zed, Cmd+Shift+P → 'reload window' to activate."
