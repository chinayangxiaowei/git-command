#!/usr/bin/env bash
# 把"此 commit"（脚本参数 SHA = 源）折叠进另一个祖先 commit（目标）。
# 等价于 git rebase -i 手动把源的 pick 改 fixup + 挪到目标下面。
set -euo pipefail
SHA="${1:?missing SHA}"  # source: 要被折叠的 commit
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "commit→fixup（把此 commit 折叠进祖先 commit）" \
  "作用: 把此 commit 作为 fixup 折进同分支某个更早的 commit" \
  "场景: HEAD 上发现某 fix 应该属于早期 commit，想放回正确位置" \
  "区别: fixup.sh 用工作区改动；本菜单用已存在的 commit"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "工作区有未提交改动，请先提交或 stash。" >&2
  exit 1
fi

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  echo "源 commit 不在当前分支祖先链上。" >&2
  exit 1
fi

echo "把此 commit 折叠 (fixup) 进另一个 commit。"
echo "目标必须是源的祖先（在历史上更早）。提示：从 Zed Graph 复制目标 commit 的 SHA。"
echo
read -erp "目标 commit SHA（短/长都可）：" TARGET_INPUT
TARGET_INPUT="${TARGET_INPUT// /}"
if [[ -z "$TARGET_INPUT" ]]; then
  echo "未输入，已取消。"
  exit 130
fi

TARGET_FULL="$(git rev-parse --verify --quiet "$TARGET_INPUT" 2>/dev/null || true)"
if [[ -z "$TARGET_FULL" ]]; then
  echo "无效 SHA：$TARGET_INPUT" >&2
  exit 1
fi

SRC_FULL="$(git rev-parse "$SHA")"

if [[ "$TARGET_FULL" == "$SRC_FULL" ]]; then
  echo "目标和源相同，无意义。" >&2
  exit 1
fi

if ! git merge-base --is-ancestor "$TARGET_FULL" "$SRC_FULL"; then
  echo "$TARGET_INPUT 不是源 commit 的祖先（无法 fixup 到那里）。" >&2
  exit 1
fi

SRC_SHORT="$(git rev-parse --short "$SRC_FULL")"
TGT_SHORT="$(git rev-parse --short "$TARGET_FULL")"

echo
echo "─── 预览 ───"
echo "源:   $SRC_SHORT  $(git log -1 --format='%s' "$SRC_FULL")"
echo "目标: $TGT_SHORT  $(git log -1 --format='%s' "$TARGET_FULL")"
echo
echo "rebase 范围 (旧→新):"
git --no-pager log --oneline --reverse "${TARGET_FULL}^..HEAD" | sed 's/^/  /'
echo

confirm "继续？"

tmpdir="$(mktemp -d)"

# todo 改写器：用 awk 重排
cat > "$tmpdir/seq" <<'SHELL_EOF'
#!/usr/bin/env bash
set -e
todo="$1"

awk -v src="$SRC_SHA" -v tgt="$TGT_SHA" '
  # Pass 1: 缓存所有行 + 找源 commit 的 subject
  { lines[++n] = $0 }
  $1 == "pick" && $2 == src {
    src_subj = ""
    for (i=3; i<=NF; i++) src_subj = src_subj (i==3?"":" ") $i
  }

  END {
    inserted = 0
    for (i=1; i<=n; i++) {
      line = lines[i]
      split(line, parts, " ")
      if (parts[1] == "pick" && parts[2] == src) continue  # 跳过源
      print line
      if (parts[1] == "pick" && parts[2] == tgt) {
        print "fixup " src " " src_subj
        inserted = 1
      }
    }
    if (!inserted) {
      print "todo 改写失败：未在 todo 中找到源或目标 (src=" src " tgt=" tgt ")" > "/dev/stderr"
      exit 1
    }
  }
' "$todo" > "$todo.tmp"

mv "$todo.tmp" "$todo"
SHELL_EOF
chmod +x "$tmpdir/seq"

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
export SRC_SHA="$SRC_FULL"
export TGT_SHA="$TARGET_FULL"

# 用 core.abbrev=40 让 todo 列出完整 SHA，匹配无歧义
git -c core.abbrev=40 rebase -i "${TARGET_FULL}^"

echo
echo "完成。源已折叠进目标 (目标 commit 已更新 SHA)。"
git --no-pager log --oneline -5
