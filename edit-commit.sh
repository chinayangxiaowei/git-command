#!/usr/bin/env bash
# ============================================================
# edit-commit.sh — 编辑 commit 的元数据/文件清单
#
# HEAD 快路径（目标 == HEAD）：
#   - 不限制工作区状态（脏也行）
#   - 修改/新增/删除文件随意，零冲突风险
#   - 直接 git commit --amend，不走 rebase
#
# 老 commit 路径（目标 != HEAD）：
#   - 工作区必须干净
#   - 适用：改 message、加新文件（untracked）、删文件
#   - 不适用：修改已有文件内容 → 请用 fixup 菜单
#     原理：本脚本要求工作区干净，你的修改没地方落；
#           +:tracked-file 暂存的只是 "目标 commit 当时的版本"，
#           等于没改。fixup 才能把你的差量 patch 应用到老 commit。
# ============================================================
set -euo pipefail
SHA="${1:?missing SHA}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib.sh"

tmpdir=""  # lib 的 EXIT trap 会清这个

# ============ 共用：让用户输入文件 +/- 清单，执行 ============
do_file_ops() {
  cat <<'EOF'

每行一个操作，输完 Q 单独成行：
  +:path/to/file    git add（加入 / 更新 / 暂存任何变化）
  -:path/to/file    从此 commit 移除（disk 保留，git rm --cached）
  Q                 完成
EOF
  echo
  while IFS= read -er line; do
    [[ "$line" == "Q" ]] && break
    [[ -z "$line" ]] && continue
    if [[ ! "$line" =~ ^([-+]):(.+)$ ]]; then
      echo "  skip 格式错误：$line"
      continue
    fi
    local op="${BASH_REMATCH[1]}"
    local path="${BASH_REMATCH[2]}"
    case "$op" in
      +)
        if [[ ! -e "$path" ]]; then
          echo "  skip +$path  (文件不存在)"
        elif git add -- "$path" 2>/dev/null; then
          echo "  add  $path"
        else
          echo "  skip +$path  (git add 失败)"
        fi
        ;;
      -)
        if git rm --cached -- "$path" >/dev/null 2>&1; then
          echo "  rm   $path  (从 commit 移除，disk 保留)"
        else
          echo "  skip -$path  (不在此 commit 里)"
        fi
        ;;
    esac
  done
}

# ============ 共用：让用户输入新 message ============
ask_new_message() {
  echo "新 message（逐行；单独一行 Q 提交；直接 Q = 不改）：" >&2
  local msg="" line
  while IFS= read -er line; do
    [[ "$line" == "Q" ]] && break
    msg+="${line}"$'\n'
  done
  printf '%s' "$msg"
}

show_intro "edit-commit（编辑此 commit 的元数据/文件清单）" \
  "HEAD 路径: 工作区可脏；直接 amend；可改 message / 加文件 / 删文件 / 改内容" \
  "老 commit 路径: 工作区必须干净；适用 message / 新增（untracked）/ 删文件" \
  "不适用（老 commit）: 修改已有文件内容 → 用 fixup 菜单（详细原因见脚本顶部）"

print_header "$SHA"
ensure_clean_state
enable_failure_rollback

HEAD_SHA="$(git rev-parse HEAD)"
TARGET_SHA="$(git rev-parse "$SHA")"

# ============================================================
# HEAD 快路径
# ============================================================
if [[ "$HEAD_SHA" == "$TARGET_SHA" ]]; then
  echo "─── HEAD 快路径 ───"
  echo "目标是 HEAD，无需 rebase："
  echo "  · 工作区可以脏（改动会作为 amend 候选）"
  echo "  · 修改 / 新增 / 删除文件随意，没有下游冲突风险"
  echo

  echo "─── 当前 message ───"
  git --no-pager log -1 --format='%B' | sed 's/^/  /'
  echo

  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "─── 当前工作区/暂存区改动 ───"
    git --no-pager status --short | sed 's/^/  /'
    echo
  fi

  new_msg=""
  read -erp "改 message？[y/N] " ans
  if [[ "$ans" =~ ^[yY] ]]; then
    new_msg="$(ask_new_message)"
  fi

  read -erp "改文件（增/删/改）？[y/N] " ans
  if [[ "$ans" =~ ^[yY] ]]; then
    do_file_ops
  fi

  # 收尾
  have_msg=0
  have_staged=0
  [[ -n "$new_msg" ]] && have_msg=1
  git diff --cached --quiet || have_staged=1

  if (( ! have_msg && ! have_staged )); then
    echo
    echo "（无改动，不 amend，退出。）"
    exit 0
  fi

  if ! git diff --quiet; then
    echo
    echo "提示：工作区还有未 git add 的改动，amend 不会包含它们。"
  fi

  tmpdir="$(mktemp -d)"

  echo
  if (( have_msg )); then
    msg_file="$tmpdir/msg"
    printf '%s' "$new_msg" > "$msg_file"
    git commit --amend -F "$msg_file" >/dev/null
    if (( have_staged )); then
      echo "已 amend (新 message + 文件改动)"
    else
      echo "已 amend (新 message)"
    fi
  else
    git commit --amend --no-edit >/dev/null
    echo "已 amend (文件改动)"
  fi

  git --no-pager log -1 --oneline
  exit 0
fi

# ============================================================
# 老 commit 路径（走 rebase）
# ============================================================
if ! git diff --quiet || ! git diff --cached --quiet; then
  cat <<'EOF' >&2
工作区有未提交改动。

如果你想把这些改动并入此 commit → 请改用菜单：
  「把工作区/暂存区改动并入此提交 (fixup+autosquash)」

如果你确实想用本菜单（改 message / 加新文件 / 删文件），请先 commit 或 stash。
EOF
  exit 1
fi

if ! git merge-base --is-ancestor "$SHA" HEAD; then
  echo "$SHA 不在当前分支祖先链上。" >&2
  exit 1
fi

echo "─── 老 commit 路径 (rebase) ───"
echo "适用：改 message / 加新文件（untracked）/ 删文件"
echo "不适用：修改已有文件内容（请用 fixup 菜单）"
echo
confirm "继续？"

# 启动 rebase 暂停到 edit 点
tmpdir="$(mktemp -d)"

cat > "$tmpdir/seq" <<EOF
#!/bin/sh
sed -i.bak '1s/^pick /edit /' "\$1" && rm -f "\$1.bak"
EOF
chmod +x "$tmpdir/seq"

export GIT_SEQUENCE_EDITOR="$tmpdir/seq"
git rebase -i "${SHA}^" || true

gitdir="$(git rev-parse --git-dir)"
if [ ! -d "$gitdir/rebase-merge" ] && [ ! -d "$gitdir/rebase-apply" ]; then
  echo "rebase 没进入 edit 状态。" >&2
  exit 1
fi

echo
echo "─── 当前 commit message ───"
git --no-pager log -1 --format='%B' | sed 's/^/  /'
echo

new_msg=""
read -erp "改 message？[y/N] " ans
if [[ "$ans" =~ ^[yY] ]]; then
  new_msg="$(ask_new_message)"
fi

read -erp "改文件（增/删）？[y/N] " ans
if [[ "$ans" =~ ^[yY] ]]; then
  do_file_ops
fi

# 收尾
have_msg=0
have_staged=0
[[ -n "$new_msg" ]] && have_msg=1
git diff --cached --quiet || have_staged=1

echo
if (( have_msg )); then
  msg_file="$tmpdir/msg"
  printf '%s' "$new_msg" > "$msg_file"
  git commit --amend -F "$msg_file" >/dev/null
  if (( have_staged )); then
    echo "已 amend (新 message + 文件改动)"
  else
    echo "已 amend (新 message)"
  fi
elif (( have_staged )); then
  git commit --amend --no-edit >/dev/null
  echo "已 amend (文件改动)"
else
  echo "(无改动，直接收尾)"
fi

if ! git rebase --continue; then
  echo >&2
  echo "rebase --continue 失败（多半是下游 commit 改了你刚删的文件 → modify/delete 冲突）。" >&2
  exit 1   # 全局 trap 会接管：自动 git rebase --abort 回滚到操作前
fi

echo "rebase 完成"
