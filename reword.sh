#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "reword（重写此 commit 的 message）" \
  "作用: 只改 commit message，文件内容/SHA 关系不变（下游 SHA 会变）" \
  "场景: typo 修复 / 改成规范格式 / 加 issue 引用 / 改 conventional commit 前缀" \
  "对比: HEAD 的 message 改 → 直接 edit-commit 更快；老 commit 只改 message 用这个"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "工作区有未提交改动，请先提交或 stash。" >&2
  exit 1
fi

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  echo "$SHA 不在当前分支祖先链上，无法 reword。" >&2
  exit 1
fi

echo "原 message："
git --no-pager log -1 --format='%B' "$SHA" | sed 's/^/  /'
echo

echo "新 message（逐行输入；空行 = 段落分隔；单独一行 Q 提交，:q 取消）："
new_msg=""
while IFS= read -er line; do
  [[ "$line" == "Q" ]] && break
  [[ "$line" == ":q" ]] && { echo "已取消。"; exit 130; }
  new_msg+="${line}"$'\n'
done

if [[ -z "$new_msg" ]]; then
  echo "未输入内容，已取消。"
  exit 130
fi

tmpdir="$(mktemp -d)"

printf '%s' "$new_msg" > "$tmpdir/msg"
cat > "$tmpdir/seq" <<EOF
#!/bin/sh
sed -i.bak '1s/^pick /reword /' "\$1" && rm -f "\$1.bak"
EOF
chmod +x "$tmpdir/seq"

cat > "$tmpdir/ed" <<EOF
#!/bin/sh
cp "$tmpdir/msg" "\$1"
EOF
chmod +x "$tmpdir/ed"

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
export GIT_EDITOR="$tmpdir/ed"
run_or_abort rebase git rebase -i "${SHA}^"
