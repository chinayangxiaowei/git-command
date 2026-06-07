#!/usr/bin/env bash
# 同步 git-command 脚本与 Zed tasks 配置
#
# 默认行为：
#   - 把所有 *.sh（不含本文件）拷到 ~/.config/zed/git-command/
#   - 把 tasks.json 里的 __GIT_COMMAND_DIR__ 占位符替换成上面的目录
#     渲染后的结果写到 ~/.config/zed/tasks.json
#
# 环境变量：
#   TARGET_DIR  脚本安装目录   默认 $HOME/.config/zed/git-command
#   ZED_CONFIG  Zed 配置目录   默认 $HOME/.config/zed
#
# 用法：
#   ./sync-tasks.sh
#   TARGET_DIR=~/bin/git-command ./sync-tasks.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${TARGET_DIR:-$HOME/.config/zed/git-command}"
ZED_CONFIG="${ZED_CONFIG:-$HOME/.config/zed}"
ZED_TASKS="$ZED_CONFIG/tasks.json"
SELF_NAME="$(basename "${BASH_SOURCE[0]}")"

if [ ! -f "$REPO_DIR/tasks.json" ]; then
  echo "✗ 找不到 $REPO_DIR/tasks.json" >&2
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

# 渲染 tasks.json：__GIT_COMMAND_DIR__ → 实际路径
# 用 | 作分隔符避免 / 冲突
sed "s|__GIT_COMMAND_DIR__|$TARGET_DIR|g" "$REPO_DIR/tasks.json" > "$ZED_TASKS"

# 检查渲染结果里不应再有占位符
if grep -q "__GIT_COMMAND_DIR__" "$ZED_TASKS"; then
  echo "✗ 渲染后仍有占位符残留：$ZED_TASKS" >&2
  exit 1
fi

echo "✓ 已同步 $copied 个脚本  → $TARGET_DIR"
echo "✓ 已渲染 tasks.json     → $ZED_TASKS"
echo
echo "下一步：Zed 中按 Cmd+Shift+P → 'reload window'，菜单生效。"
