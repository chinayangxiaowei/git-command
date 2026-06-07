#!/usr/bin/env bash
# drop-commit.sh — 把此 commit 从历史中完全删除
# 用 git rebase -i 的 todo 改写器，把对应行直接抽掉，等同于 todo 里改成 drop。
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "drop-commit（从历史中删除此 commit）" \
  "作用: 把此 commit 从分支历史里抽掉，下游 commit 重新 replay (新 SHA)" \
  "场景: 误提交（密码/调试代码） / 完全没用的 WIP / 重复 commit / 想抹掉的尝试" \
  "对比: revert 是加反向 commit（保留历史）；drop 是真删（重写历史）"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "工作区有未提交改动，请先提交或 stash。" >&2
  exit 1
fi

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  echo "$SHA 不在当前分支祖先链上。" >&2
  exit 1
fi

if ! git rev-parse --verify --quiet "${SHA}^" >/dev/null 2>&1; then
  echo "$SHA 是根 commit，没有父，rebase 无法移除。" >&2
  echo "真要删根 commit 需要 git update-ref 等手段，手动处理。" >&2
  exit 1
fi

SHA_FULL="$(git rev-parse "$SHA")"
SHA_SHORT="$(git rev-parse --short "$SHA")"

echo "将移除："
echo "  $SHA_SHORT  $(git log -1 --format='%s' "$SHA_FULL")"
echo

downstream_count="$(git rev-list --count "${SHA_FULL}..HEAD" 2>/dev/null || echo 0)"
is_head=0
if (( downstream_count > 0 )); then
  echo "下游 $downstream_count 条 commit 会 replay（SHA 会变）："
  git --no-pager log --oneline --reverse "${SHA_FULL}..HEAD" | sed 's/^/  /' | head -10
  echo "  （若下游改动依赖此 commit → 冲突时自动 abort）"
else
  is_head=1
  echo "（此 commit 就是 HEAD → 走 git reset --hard HEAD~ 快路径，不动 rebase）"
fi
echo

confirm "确认移除？"

# ─── HEAD 快路径 ───
if (( is_head )); then
  git reset --hard "${SHA_FULL}^"
  echo
  echo "完成。HEAD 已回到上一条 commit。"
  git --no-pager log --oneline -5
  exit 0
fi

# ─── 非 HEAD：走 rebase 改 todo ───
tmpdir="$(mktemp -d)"

cat > "$tmpdir/seq" <<'SHELL_EOF'
#!/usr/bin/env bash
set -e
todo="$1"

awk -v drop="$DROP_SHA" '
  BEGIN { found = 0 }
  $1 == "pick" && $2 == drop { found = 1; next }
  { print }
  END {
    if (!found) {
      print "todo 改写失败：未在 todo 中找到目标 commit (sha=" drop ")" > "/dev/stderr"
      exit 1
    }
  }
' "$todo" > "$todo.tmp"

mv "$todo.tmp" "$todo"
SHELL_EOF
chmod +x "$tmpdir/seq"

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
export DROP_SHA="$SHA_FULL"

git -c core.abbrev=40 rebase -i "${SHA_FULL}^"

echo
echo "完成。此 commit 已从历史中移除。"
git --no-pager log --oneline -5
