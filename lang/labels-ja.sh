#!/usr/bin/env bash
# 日本語メニュー label for tasks.json.
# Loaded by sync-tasks.sh; substituted into tasks.json placeholders __LABEL_*__.
# シングルクォートで囲む — $ZED_GIT_SHA_SHORT などは Zed が解釈するため字面のまま残す。
# shellcheck shell=bash disable=SC2034

# ── 1. 表示 / 閲覧 ──────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. 表示 / 閲覧 ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · この commit を含むブランチ  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · この commit を含む tag  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · この commit の stat  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · この commit の完全 diff  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · HEAD と比較  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · この commit が触れた全ファイルを開く  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · この commit のファイルスナップショットを書き出す  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · 直近 N 件を patch として書き出す  ($ZED_GIT_SHA_SHORT)'

# ── 2. この commit を編集 ───────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. この commit を編集 ────'
LABEL_MODIFY_REWORD='Git · この commit のメッセージを reword  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · この commit を編集（メッセージ + ファイル追加/削除）  ($ZED_GIT_SHA_SHORT)'

# ── 3. history 書き換え (rebase) ────────────────────────────────
LABEL_SEP_REWRITE='──── 3. history 書き換え (rebase) ────'
LABEL_REWRITE_SQUASH='Git · ここから N 件を前方向に squash  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · この commit を history から削除 (drop)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · この commit まで interactive rebase  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · この commit へ soft reset（変更 → index）  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · この commit へ hard reset（破壊的）  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup（変更をこの commit に統合） ────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup（変更をこの commit に統合） ────'
LABEL_FIXUP_INTO_THIS='Git · 作業ツリー/ステージの変更をこの commit に統合 (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · この commit を祖先に統合 (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. コピー / 取り消し ────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. コピー / 取り消し ────'
LABEL_COPY_CHERRY_PICK='Git · 現在のブランチへ cherry-pick  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · この commit を revert  ($ZED_GIT_SHA_SHORT)'

# ── 6. ブランチ ─────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. ブランチ ────'
LABEL_BRANCH_FROM='Git · この commit から新ブランチ作成  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · この commit から使い捨て try-branch  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · ブランチ A をブランチ B に rebase (CLion 風)'
LABEL_BRANCH_DELETE='Git · この commit のローカルブランチ削除（remote も任意）  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · この commit に tag を付与  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · tag を削除（ローカル + 任意で remote）  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · 現在の変更を名前付きで stash'
LABEL_STASH_POP='Git · 直近の stash を pop'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree（この commit を別ディレクトリで checkout） ────'
LABEL_WT_REVIEW='Worktree · review  (detached, 読み取り専用)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (使い捨てブランチ)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (bug 修正)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (新機能)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · remove  review  (名前を貼り付けて確定)'
LABEL_WT_RM_TRY='Worktree · remove  try     (名前を貼り付けて確定)'
LABEL_WT_RM_FIX='Worktree · remove  fix     (名前を貼り付けて確定)'
LABEL_WT_RM_FEAT='Worktree · remove  feat    (名前を貼り付けて確定)'
LABEL_WT_RM_HOT='Worktree · remove  hot     (名前を貼り付けて確定)'
