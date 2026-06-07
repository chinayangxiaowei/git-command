#!/usr/bin/env bash
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

show_intro "squash-n（从此 commit 向前 N 条合并）" \
  "作用: 把此 commit 和向前 N-1 条合并成 1 条，下游 commit 在新顶上 replay" \
  "场景: 整理 WIP commits / 压缩噪音 / 合并主题相关的多个小 commit" \
  "前提: 工作区必须干净；下游 SHA 全变；冲突时自动 abort"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "工作区有未提交改动，请先提交或 stash。" >&2
  exit 1
fi

read -erp "合并几条（含此提交，向前 N 条，默认 2）：" n
n="${n:-2}"
if ! [[ "$n" =~ ^[0-9]+$ ]] || (( n < 2 )); then
  echo "至少 2 条才有合并意义。" >&2
  exit 1
fi

total="$(git rev-list --count "$SHA")"
if (( n > total )); then
  echo "此提交只有 $total 个祖先（含自身），最多合并 $total 条。" >&2
  exit 1
fi

echo
echo "将合并以下 $n 条提交（旧 → 新）："
git --no-pager log --oneline --reverse "${SHA}~${n}..${SHA}"
echo

echo "新 commit message（逐行输入；单独一行 Q 提交；直接 Q = 走编辑器拼接默认；:q 取消）："
new_msg=""
while IFS= read -er line; do
  [[ "$line" == "Q" ]] && break
  [[ "$line" == ":q" ]] && { echo "已取消。"; exit 130; }
  new_msg+="${line}"$'\n'
done

confirm "继续？"

tmpdir="$(mktemp -d)"

cat > "$tmpdir/seq" <<EOF
#!/bin/sh
sed -i.bak '2,${n}s/^pick /squash /' "\$1" && rm -f "\$1.bak"
EOF
chmod +x "$tmpdir/seq"

if [[ -n "$new_msg" ]]; then
  printf '%s' "$new_msg" > "$tmpdir/msg"
  cat > "$tmpdir/ed" <<EOF
#!/bin/sh
cp "$tmpdir/msg" "\$1"
EOF
  chmod +x "$tmpdir/ed"
  export GIT_EDITOR="$tmpdir/ed"
fi

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
run_or_abort rebase git rebase -i "${SHA}~${n}"
