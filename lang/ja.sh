#!/usr/bin/env bash
# 日本語メッセージ for git-command scripts.
# Loaded by lib.sh; do not invoke directly.
# 命名規則: MSG_<SCRIPT>_<KEY>; printf テンプレートには _FMT サフィックスを付ける。
# shellcheck shell=bash

# ── lib.sh (共通内部処理) ───────────────────────────────────────
MSG_LIB_IN_PROGRESS_FMT='未完了の %s が進行中です。先に "%s" か --continue を実行してください。\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s が失敗したため、自動で git %s --abort を実行します（作業ツリーは操作前の状態に戻りました）。\n'
MSG_LIB_NOT_IN_REPO='git リポジトリ内ではありません。'
MSG_LIB_NOT_BARE_LAYOUT='現在のプロジェクトは bare + worktrees 構成ではありません。worktree メニューは無効です。'
MSG_LIB_INIT_HINT='有効化するには新規プロジェクトで実行: bash git-command/init-bare-tree.sh <name> [<url>]'
MSG_LIB_MIGRATE_HINT='既存プロジェクト向け: migrate-to-bare-tree.sh（未実装。手動で移行してください）。'
MSG_LIB_CLEANUP_FMT='スクリプトが予期せず終了しました (exit %d)。自動で git %s --abort を実行して巻き戻します。\n'

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword（この commit のメッセージを書き換える）"
MSG_REWORD_PURPOSE="用途: commit メッセージのみ変更。ファイル内容と SHA チェーンは保持される（下流の SHA は書き換わる）"
MSG_REWORD_WHEN="場面: typo 修正 / 規約に合わせる / issue 参照を追加 / conventional commit プレフィックスの調整"
MSG_REWORD_CONTRAST="注意: HEAD 自身のメッセージなら edit-commit の方が速い。reword は古い commit 用。"
MSG_REWORD_DIRTY_TREE="作業ツリーに未コミットの変更があります。先に commit または stash してください。"
MSG_REWORD_NOT_ANCESTOR_FMT='%s は現在のブランチの祖先チェーンにありません。reword できません。\n'
MSG_REWORD_OLD_MSG="旧メッセージ:"
MSG_REWORD_NEW_MSG_PROMPT="新メッセージ（1 行ずつ入力。空行 = 段落区切り。単独 'Q' で確定、':q' でキャンセル）:"
MSG_REWORD_CANCELLED="キャンセルしました。"
MSG_REWORD_EMPTY_CANCELLED="入力がないためキャンセルしました。"

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files（この commit で触れた全ファイルを Zed で開く）"
MSG_OPEN_FILES_PURPOSE="用途: この commit が変更したファイルを列挙し、すべて Zed で開く（現在の作業ツリー版）"
MSG_OPEN_FILES_WHEN="場面: 過去の bug をデバッグしたい。その変更に関わる全ファイルを見たいとき"
MSG_OPEN_FILES_PREREQ="前提: PATH に zed CLI があること。作業ツリーに無いファイルはスキップされる"
MSG_OPEN_FILES_EMPTY="この commit にはファイル変更がありません（空 commit の可能性）。"
MSG_OPEN_FILES_MISSING="以下のファイルは作業ツリーにもう存在しません（削除/リネーム済み）。スキップします:"
MSG_OPEN_FILES_ALL_GONE="この commit で触れたファイルは作業ツリーに 1 つも残っていません。"
MSG_OPEN_FILES_OPENING_FMT='Zed で %d 個のファイルを開きます:\n'
MSG_OPEN_FILES_NO_ZED="zed コマンドが見つかりません。"
MSG_OPEN_FILES_INSTALL_HINT="Zed で: Cmd+Shift+P → 'zed: install cli' で zed CLI をインストールしてください。"

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files（この commit のファイルをフォルダへ書き出す）"
MSG_EXPORT_FILES_PURPOSE="用途: この commit が変更した各ファイルを「この commit 時点のバージョン」でフォルダにコピーし、パス構造を保つ"
MSG_EXPORT_FILES_WHEN="場面: 数が多くてタブで開きたくない / commit 成果物のスナップショットを取りたい / オフライン diff"
MSG_EXPORT_FILES_CONTRAST="注意: open-files は現在の作業版を開く。こちらは commit 時点の歴史版を書き出す。"
MSG_EXPORT_FILES_EMPTY="この commit にはファイル変更がありません（空 commit の可能性）。"
MSG_EXPORT_FILES_COUNT_FMT='この commit は %d 個のファイルに影響します:\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... 他 %d 個\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='書き出し先ディレクトリ（リポジトリ root からの相対、デフォルト %s）: '
MSG_EXPORT_FILES_DIR_EXISTS_FMT='ディレクトリが既に存在し空ではありません: %s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="続行すると同名ファイルが上書きされる可能性があります。続行しますか？"
MSG_EXPORT_FILES_DELETED_HINT="（この commit で削除されたため、書き出すものがありません）"
MSG_EXPORT_FILES_DONE_FMT='完了: %d 件書き出し、%d 件スキップ → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="注意: 内容はこの commit 時点のスナップショットであり、現在の作業版ではありません。"

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches（N 個の patch ファイルを書き出す）"
MSG_EXPORT_PATCHES_PURPOSE="用途: ここから遡って N 個の commit を mbox (.patch) もしくは plain diff (.diff) として書き出す"
MSG_EXPORT_PATCHES_WHEN="場面: メールで共有 / 特定の変更をバックアップ / 他者に渡して git am / git apply してもらう"
MSG_EXPORT_PATCHES_OUTPUT="出力: 指定ディレクトリ（デフォルト ./patches）。history は一切変更されません"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="フォーマット [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply)（デフォルト f）: "
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='無効なフォーマット: %s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="何件遡るか（デフォルト 1）: "
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='無効な件数: %s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="出力ディレクトリ（リポジトリ root からの相対、デフォルト ./patches）: "
MSG_EXPORT_PATCHES_FORMAT_LABEL="フォーマット:"
MSG_EXPORT_PATCHES_RANGE_LABEL="範囲:"
MSG_EXPORT_PATCHES_OUTPUT_LABEL="出力:"
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(root)"
MSG_EXPORT_PATCHES_CONTINUE="続行しますか？"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft（この commit までソフトリセット・変更はステージへ）"
MSG_RESET_SOFT_PURPOSE="用途: HEAD をこの commit に移動。間にある commit の変更は index に積まれる（失われない）"
MSG_RESET_SOFT_WHEN="場面: 直近 N 件の commit をまとめ直したい（再分割 / メッセージ変更 / マージ）"
MSG_RESET_SOFT_AFTER="その後: git status で index を確認し、新たに commit し直す"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s は HEAD の祖先チェーンにありません。soft reset しても意味がありません。\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s は既に HEAD です。reset の必要はありません。\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='現在のブランチ: %s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='以下の commit を取り除きます（変更は index に入り、HEAD → %s）:\n'
MSG_RESET_SOFT_CONFIRM_FMT='%s まで soft reset しますか？'
MSG_RESET_SOFT_DONE="完了。変更は index にあります。git status で確認し、再度 commit してください。"

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard（この commit までハードリセット・破壊的）"
MSG_RESET_HARD_PURPOSE="用途: HEAD をこの commit に移動。間の commit と作業ツリーの変更を全て破棄"
MSG_RESET_HARD_WHEN="場面: ある状態まで完全に巻き戻し、途中の変更を全て捨てて構わないと確信できる場合"
MSG_RESET_HARD_AFTER="その後: 復元不可（30 日以内なら git reflog で可能。YES を大文字で入力する確認が必要）"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s は HEAD の祖先チェーンにありません。中止します。\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s は既に HEAD です。reset の必要はありません。\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='現在のブランチ: %s\n'
MSG_RESET_HARD_WILL_DROP="以下の commit を破棄します（reflog 以外では復元不可）:"
MSG_RESET_HARD_WT_LOST="作業ツリーの変更も破棄されます:"
MSG_RESET_HARD_YES_PROMPT_FMT='%s への hard reset を確定するには YES（大文字）と入力してください: '
MSG_RESET_HARD_NO_YES="YES が入力されませんでした。キャンセルしました。"
MSG_RESET_HARD_REFLOG_HINT="ヒント: reflog なら 30 日以内ならまだ復元可能。git reflog → HEAD@{N} を確認。"

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i（この commit までの interactive rebase）"
MSG_REBASE_I_PURPOSE='用途: git rebase -i SHA^ を起動し、$EDITOR で todo を手動編集'
MSG_REBASE_I_WHEN="場面: 複数 commit を手動で並べ替え / マージ / 編集 / 破棄。標準メニューでは扱いきれない複雑な操作"
MSG_REBASE_I_PREREQ="前提: 作業ツリーがクリーンであること。conflict が出たら手動で対応するか、EXIT トラップの abort に任せる"
MSG_REBASE_I_RANGE_FMT='interactive rebase を開始します。範囲: %s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="作業ツリーに未コミットの変更があります。先に commit または stash してください。"
MSG_REBASE_I_CONTINUE="続行しますか？"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert（この commit を打ち消す逆 commit を作成する）"
MSG_REVERT_PURPOSE="用途: history を書き換えず、この commit の逆変更を持つ新 commit を HEAD の上に追加"
MSG_REVERT_WHEN="場面: 既に push 済みの commit を取り消したい（reset だと公開済み history を書き換えてしまう）"
MSG_REVERT_CONTRAST="注意: reset は history を書き換え、revert は追記する。conflict 時は自動 abort。"
MSG_REVERT_DIRTY_TREE="作業ツリーに未コミットの変更があります。先に commit または stash してください。"
MSG_REVERT_CONFIRM_FMT='%s を打ち消す逆 commit を HEAD の上に作成しますか？\n'

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick（この commit を現在のブランチの先端へコピー）"
MSG_CHERRY_PICK_PURPOSE="用途: この commit の変更を現在のブランチの tip に新 commit としてコピー（新しい SHA）"
MSG_CHERRY_PICK_WHEN="場面: hotfix を別ブランチへ持っていく / 同僚から 1 つだけ commit を拾う / reflog から復活させる"
MSG_CHERRY_PICK_NOTE="注意: 元の commit は消えない。同一ブランチへの cherry-pick は無意味。conflict 時は自動 abort。"
MSG_CHERRY_PICK_CURRENT_FMT='現在のブランチ: %s\n'
MSG_CHERRY_PICK_DIRTY_TREE="作業ツリーに未コミットの変更があります。先に commit または stash してください。"
MSG_CHERRY_PICK_CONFIRM_FMT='%s を %s へ cherry-pick しますか？'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from（この commit から新ブランチを作成）"
MSG_BRANCH_FROM_PURPOSE="用途: この commit に新しいブランチを作成し、そのブランチへ切り替える"
MSG_BRANCH_FROM_WHEN="場面: 古い commit から新しい作業を始める / 特定の状態に名前付き ref を残しておきたい"
MSG_BRANCH_FROM_CONTRAST="注意: 使い捨ての実験用には try-branch を使う（自動で try/ プレフィックス + 後片付けヒント）"
MSG_BRANCH_FROM_NAME_PROMPT="新ブランチ名（この commit が起点）: "
MSG_BRANCH_FROM_NO_NAME="ブランチ名が入力されませんでした。キャンセルしました。"

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch（この commit からの使い捨てブランチ）"
MSG_TRY_BRANCH_PURPOSE="用途: try/<base-slug>-<sha> という名前のブランチをこの commit から作成し、即切り替え"
MSG_TRY_BRANCH_WHEN="場面: 現在のブランチを汚さず実験したい / 古い commit の状態を確認したい"
MSG_TRY_BRANCH_HINT="ヒント: 終了時に「元のブランチへ戻る」「このブランチを削除する」コマンドをリマインダ表示"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # detached だった。reflog を参照"
MSG_TRY_BRANCH_FROM_FMT='元のブランチ: %s\n起点:         %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='新ブランチ名（Enter で %s）: '
MSG_TRY_BRANCH_EXISTS_FMT='ブランチは既に存在します: %s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="作成後に切り替えますか？ [Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='%s を作成しました（切り替えなし）\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="終わったら後片付け:"
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  元へ戻る:     %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  このブランチ削除: git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push（現在の変更を名前付きで stash）"
MSG_STASH_PUSH_PURPOSE="用途: 追跡対象の変更にラベルを付けて stash し、作業ツリーをクリーンに保つ"
MSG_STASH_PUSH_WHEN="場面: WIP を抱えたままブランチを切り替えたい / 一時的に作業を脇に置きたい / reset 前に整理したい"
MSG_STASH_PUSH_NOTE="注意: -u は使わない。untracked ファイルは作業ツリーに残る（Git Graph に余計な snapshot ノードが出るのを防ぐため）"
MSG_STASH_PUSH_CLEAN="作業ツリーはクリーンです。stash するものがありません。"
MSG_STASH_PUSH_WILL_STASH="以下の変更を stash します:"
MSG_STASH_PUSH_NAME_PROMPT="名前を付けてください（後で探しやすくなります）: "
MSG_STASH_PUSH_NO_NAME="名前が入力されませんでした。キャンセルしました。"
MSG_STASH_PUSH_DONE_HINT="完了。確認: git stash list、もしくはメニューの「Pop most recent stash」。"
MSG_STASH_PUSH_UNTRACKED_NOTE="注意: untracked ファイルは stash されず、作業ツリーに残ります。"

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop（直近の stash を作業ツリーへ適用）"
MSG_STASH_POP_PURPOSE="用途: stash@{0} を作業ツリーに適用。成功時は stash が自動で削除される"
MSG_STASH_POP_WHEN="場面: 以前 stash した変更を戻したいとき"
MSG_STASH_POP_NOTE="注意: conflict 時は stash は自動削除されない。解消後に git stash drop を実行"
MSG_STASH_POP_EMPTY="pop できる stash がありません。"
MSG_STASH_POP_LIST_HEADER="最近の stash:"
MSG_STASH_POP_PREVIEW_HEADER="stash@{0} プレビュー:"
MSG_STASH_POP_CONFIRM="stash@{0} を現在の作業ツリーに pop しますか？"
MSG_STASH_POP_CONFLICT="pop で conflict が発生 — stash は保持されました（自動 drop されません）。"
MSG_STASH_POP_CONFLICT_HINT="conflict を解消し git add した後、 git stash drop  で破棄してください。"

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete（この commit を指すローカルブランチを削除）"
MSG_BRANCH_DELETE_PURPOSE="用途: ローカルブランチを削除（必要に応じて remote も）"
MSG_BRANCH_DELETE_WHEN="場面: マージ済み / 使い捨てのブランチを片付ける。try/* や feat/* などを一括整理"
MSG_BRANCH_DELETE_NOTE="注意: git branch -D を使用（強制削除。マージ状態を無視）"
MSG_BRANCH_DELETE_NONE="この commit に紐づく削除可能なローカルブランチがありません。"
MSG_BRANCH_DELETE_ONE_FMT='この commit のブランチは 1 つだけです: %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="この commit のローカルブランチ:"
MSG_BRANCH_DELETE_SELECT_PROMPT="1 つ選択（ブランチ名または番号）: "
MSG_BRANCH_DELETE_NO_INPUT="入力がないためキャンセルしました。"
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="ブランチ '%s' はこの commit のリストにありません。\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="チェックアウト中のブランチ '%s' は削除できません。\n"
MSG_BRANCH_DELETE_CURRENT_HINT="先に別のブランチへ切り替えてください: git switch <other-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="ローカルブランチ '%s' を削除しますか？"
MSG_BRANCH_DELETE_LOCAL_DONE="ローカルブランチを削除しました。"
MSG_BRANCH_DELETE_NO_REMOTE="（remote が未設定。remote はスキップ）"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="（remote [%s] にブランチが存在しません。スキップ）"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="remote [%s] からも削除しますか？ [y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="remote ブランチを削除しました。"

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit（この commit のメタデータ / ファイル一覧を編集）"
MSG_EDIT_COMMIT_HEAD_PATH="HEAD パス:  作業ツリーが dirty でも OK。直接 amend。message 変更 / 追加 / 削除 / 修正可能"
MSG_EDIT_COMMIT_OLD_PATH="旧 commit パス: 作業ツリーがクリーンであること。message / 追加 (untracked) / 削除に対応"
MSG_EDIT_COMMIT_NOT_SUITED="非対応（旧 commit）: 既存ファイルの内容を変更したい → fixup メニューを使う（理由はヘッダーコメント参照）"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="1 行 1 操作。'Q' のみの行で確定:"
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:path/to/file    git add（追加 / 更新 / 変更を stage）"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:path/to/file    この commit から除外（ディスクは残す、git rm --cached）"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                 完了"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  形式エラーをスキップ: %s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  スキップ +%s  （ファイルが存在しません）\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  add  %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  スキップ +%s  （git add 失敗）\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  rm   %s  （commit から除外。ディスクには残す）\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  スキップ -%s  （この commit に含まれていません）\n'
MSG_EDIT_COMMIT_ASK_MSG="新メッセージ（1 行ずつ。単独 'Q' で確定。Q のみ = 変更なし）:"
MSG_EDIT_COMMIT_HEAD_HEADER="─── HEAD 高速パス ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="対象は HEAD。rebase は不要:"
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · 作業ツリーが dirty でも OK（変更は amend の候補になる）"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · ファイルの追加 / 修正 / 削除を自由にできる。下流 conflict のリスクなし"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── 現在のメッセージ ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── 現在の作業/ステージング変更 ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="メッセージを変更しますか？ [y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="ファイルを変更しますか（追加/削除/修正）？ [y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="（変更なし。amend せず終了。）"
MSG_EDIT_COMMIT_UNSTAGED_HINT="注意: 作業ツリーに unstaged な変更が残っています。amend には含まれません。"
MSG_EDIT_COMMIT_AMEND_MSG_FILES="amend 完了（新メッセージ + ファイル変更）"
MSG_EDIT_COMMIT_AMEND_MSG="amend 完了（新メッセージ）"
MSG_EDIT_COMMIT_AMEND_FILES="amend 完了（ファイル変更）"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='作業ツリーに未コミットの変更があります。

その変更をこの commit に統合したい場合 → メニューを使ってください:
  「Fold working/staged changes into this commit (fixup+autosquash)」

本当にこのメニュー（メッセージ変更 / 新規ファイル追加 / ファイル削除）を使いたい場合は、先に commit または stash してください。'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s は現在のブランチの祖先チェーンにありません。\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── 旧 commit パス (rebase) ───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="適用範囲: メッセージ / 新規ファイル追加 (untracked) / ファイル削除"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="非対応: 既存ファイル内容の変更（fixup メニューを使う）"
MSG_EDIT_COMMIT_OLD_CONTINUE="続行しますか？"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="rebase が edit 状態に入りませんでした。"
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── 現在の commit メッセージ ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="メッセージを変更しますか？ [y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="ファイルを変更しますか（追加/削除）？ [y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="（変更なし。終了処理に移ります）"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue に失敗しました（直前に削除したファイルに対する下流 commit の modify/delete conflict の可能性）。"
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase 完了"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n（この commit から N 件を前方向に squash）"
MSG_SQUASH_PURPOSE="用途: この commit と N-1 個の祖先を 1 つに squash。下流の commit は上に replay"
MSG_SQUASH_WHEN="場面: WIP commit を整理 / ノイズを圧縮 / 関連する小さな commit をまとめる"
MSG_SQUASH_PREREQ="前提: 作業ツリーがクリーンであること。下流の SHA は変わる。conflict 時は自動 abort"
MSG_SQUASH_DIRTY_TREE="作業ツリーに未コミットの変更があります。先に commit または stash してください。"
MSG_SQUASH_COUNT_PROMPT="何件 squash しますか（この commit を含む。デフォルト 2）: "
MSG_SQUASH_MIN_TWO="squash には少なくとも 2 件必要です。"
MSG_SQUASH_TOO_MANY_FMT='この commit を含めて祖先は %d 件しかありません。最大 %d まで。\n'
MSG_SQUASH_PREVIEW_FMT='以下の %d 件を squash します（古い → 新しい）:\n'
MSG_SQUASH_MSG_PROMPT="新 commit メッセージ（1 行ずつ。単独 Q で確定。Q だけ = エディタでデフォルト連結を編集。:q でキャンセル）:"
MSG_SQUASH_CANCELLED="キャンセルしました。"
MSG_SQUASH_CONTINUE="続行しますか？"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit（この commit を history から削除）"
MSG_DROP_PURPOSE="用途: ブランチ history からこの commit を取り除く。下流の commit は replay される（SHA は新規）"
MSG_DROP_WHEN="場面: 誤った commit（パスワード / デバッグコード）/ 不要な WIP / 重複 / 実験を消したい"
MSG_DROP_CONTRAST="注意: revert は逆 commit を追加（history 保持）。drop は本当に削除（history を書き換え）。"
MSG_DROP_DIRTY_TREE="作業ツリーに未コミットの変更があります。先に commit または stash してください。"
MSG_DROP_NOT_ANCESTOR_FMT='%s は現在のブランチの祖先チェーンにありません。\n'
MSG_DROP_ROOT_COMMIT_FMT='%s は root commit です。親を持たないため rebase では削除できません。\n'
MSG_DROP_ROOT_HINT="root commit の本当の削除には git update-ref などが必要。手動で対応してください。"
MSG_DROP_WILL_REMOVE="削除対象:"
MSG_DROP_DOWNSTREAM_FMT='%d 件の下流 commit が replay されます（SHA が変わります）:\n'
MSG_DROP_DOWNSTREAM_HINT="  （下流の変更がこの commit に依存していると → conflict 時に自動 abort）"
MSG_DROP_IS_HEAD_NOTE="（この commit は HEAD → git reset --hard HEAD~ の高速パス。rebase 不要）"
MSG_DROP_CONFIRM="削除を確定しますか？"
MSG_DROP_DONE_HEAD="完了。HEAD を 1 つ前の commit に移動しました。"
MSG_DROP_DONE_REBASE="完了。この commit を history から削除しました。"

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup（作業ツリーの変更をこの commit に統合）"
MSG_FIXUP_PURPOSE="用途: fixup commit を作成し autosquash。作業ツリーの変更をこの commit に統合する"
MSG_FIXUP_WHEN="場面: ファイルを編集してそれを古い commit に乗せたい（非常によくある）。history を汚さない"
MSG_FIXUP_PREREQ="前提: 作業ツリー / stage に変更があること。conflict 時は自動 abort"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s は現在のブランチの祖先チェーンにありません。\n'
MSG_FIXUP_NO_CHANGES="作業ツリーはクリーンです。統合する変更がありません。"
MSG_FIXUP_WORKFLOW_HINT="ワークフロー: ファイル編集 → このメニュー → 対象 commit を選択 → 自動 fixup + autosquash。"
MSG_FIXUP_WILL_FOLD="この commit に統合する変更:"
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="index に既に内容があります。unstaged な変更も含めますか？ [y/N] "
MSG_FIXUP_ASK_ADD_ALL="index が空です。git add -A で全て追加してから fixup しますか？ [Y/n] "
MSG_FIXUP_EMPTY_INDEX="index が空です。fixup するものがないためキャンセルしました。"
MSG_FIXUP_TARGET_FMT='対象: %s  "%s"\n'
MSG_FIXUP_CONFIRM="fixup + autosquash を実行しますか？ [Y/n] "
MSG_FIXUP_CANCELLED="キャンセルしました。index の状態は保持されています。"
MSG_FIXUP_CREATED="  + fixup commit を作成"
MSG_FIXUP_DONE_FMT='完了。変更を %s に統合しました（autosquash 後に SHA が更新されます）。\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup（この commit を祖先 commit に統合）"
MSG_CFIX_PURPOSE="用途: この commit を取り、同じブランチ上のより古い commit に fixup として適用する"
MSG_CFIX_WHEN="場面: HEAD にある修正が本来は古い commit に属する。本来の場所へ戻す"
MSG_CFIX_CONTRAST="注意: fixup.sh は作業ツリーの変更を使う。本メニューは既存の commit を使う"
MSG_CFIX_DIRTY_TREE="作業ツリーに未コミットの変更があります。先に commit または stash してください。"
MSG_CFIX_NOT_ANCESTOR_SRC="ソースの commit が現在のブランチの祖先チェーンにありません。"
MSG_CFIX_HEADER="この commit を別の commit に統合 (fixup) します。"
MSG_CFIX_TARGET_HINT="対象はソースの祖先（history 上でより古い）である必要があります。ヒント: Zed Graph から対象の SHA をコピー。"
MSG_CFIX_TARGET_PROMPT="対象の commit SHA（short でも long でも可）: "
MSG_CFIX_NO_INPUT="入力がないためキャンセルしました。"
MSG_CFIX_INVALID_SHA_FMT='無効な SHA: %s\n'
MSG_CFIX_SAME_COMMIT="対象とソースが同一です。意味がありません。"
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s はソース commit の祖先ではありません（fixup の対象にできません）。\n'
MSG_CFIX_PREVIEW="─── プレビュー ───"
MSG_CFIX_SOURCE_LABEL="ソース:"
MSG_CFIX_TARGET_LABEL="対象:"
MSG_CFIX_RANGE_LABEL="rebase 範囲（古い → 新しい）:"
MSG_CFIX_CONTINUE="続行しますか？"
MSG_CFIX_DONE="完了。ソースを対象に統合しました（対象 commit の SHA が更新されました）。"

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto（ブランチ A をブランチ B に rebase）"
MSG_RBO_PURPOSE="用途: git switch A && git rebase B。A 固有の commit が B の tip に replay される"
MSG_RBO_WHEN="場面: A が feature ブランチ、B が main/develop。A を B の最新に追随させる"
MSG_RBO_NOTE="注意: A の commit は書き換えられる（新しい SHA）。conflict 時は自動 abort"
MSG_RBO_DIRTY_TREE="作業ツリーに未コミットの変更があります。先に commit または stash してください。"
MSG_RBO_LOCAL_BRANCHES="ローカルブランチ:"
MSG_RBO_A_PROMPT_FMT='ブランチ A (rebase される側。Enter で現在の %s): '
MSG_RBO_DETACHED_ERR="現在 detached HEAD です。ブランチ A を明示的に指定してください。"
MSG_RBO_NO_LOCAL_FMT='そのローカルブランチは存在しません: %s\n'
MSG_RBO_B_PROMPT="ブランチ B（rebase 先。local / remote / tag）: "
MSG_RBO_NO_INPUT="入力がないためキャンセルしました。"
MSG_RBO_INVALID_REF_FMT='無効な対象 ref: %s\n'
MSG_RBO_SAME="A と B が同じ commit を指しています。rebase することがありません。"
MSG_RBO_PREVIEW="─── プレビュー ───"
MSG_RBO_NO_EXCLUSIVE="A は B より先の commit を持ちません（A は B の祖先か、同一です）。"
MSG_RBO_FF_OR_NOOP="rebase は fast-forward か no-op になります。"
MSG_RBO_REPLAY_FMT='A が replay する commit (%d):\n'
MSG_RBO_CONFIRM_FMT='実行: git switch %s && git rebase %s ?'
MSG_RBO_SWITCHING_FMT='%s へ切り替えます...\n'
MSG_RBO_DONE="完了。"

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag（この commit に tag を付ける）"
MSG_TAG_PURPOSE="用途: この commit を指す lightweight または annotated tag を作成。任意で remote に push"
MSG_TAG_WHEN="場面: リリース地点 / マイルストーン / commit への安定した名前付き参照"
MSG_TAG_CONTRAST="注意: annotated は message+author+time を持つ（リリース推奨）。lightweight は単なる ref。"
MSG_TAG_NAME_PROMPT="tag 名（例 v1.0.0 / release-2024-01）: "
MSG_TAG_NO_INPUT="入力がないためキャンセルしました。"
MSG_TAG_EXISTS_FMT='tag は既に存在します: %s\n'
MSG_TAG_KIND_PROMPT="annotated（メッセージ付き）か lightweight か？ [a]/l（デフォルト a）: "
MSG_TAG_MSG_PROMPT="tag メッセージ（Enter で tag 名を使用）: "
MSG_TAG_CREATED_FMT='tag を作成: %s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='remote [%s] に push しますか？ [y/N] '
MSG_TAG_NO_REMOTE="（remote が未設定。push はスキップ）"
MSG_TAG_REFRESH_HINT="注意: Zed Git Graph は tag 変更を監視していません。手動で更新してください（Cmd+Shift+P → reload window、または次の commit を待つ）。"

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete（tag を削除）"
MSG_TAG_DELETE_PURPOSE="用途: ローカル tag を削除。任意で remote 上の tag も削除"
MSG_TAG_DELETE_WHEN="場面: 誤った tag / 再リリース / 整理"
MSG_TAG_DELETE_NOTE="注意: push 済みの remote tag を削除すると他者に影響する。ローカルと remote は別々に確認"
MSG_TAG_DELETE_AT_HEADER="この commit の tag:"
MSG_TAG_DELETE_NONE="  （なし）"
MSG_TAG_DELETE_NAME_PROMPT="削除する tag 名（別の commit のものでも可）: "
MSG_TAG_DELETE_NO_INPUT="入力がないためキャンセルしました。"
MSG_TAG_DELETE_NOT_EXIST_FMT='tag が存在しません: %s\n'
MSG_TAG_DELETE_ANNOTATED="(annotated tag)"
MSG_TAG_DELETE_PREVIEW_FMT="tag '%s' → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="ローカル tag '%s' を削除しますか？"
MSG_TAG_DELETE_LOCAL_DONE="ローカル tag を削除しました。"
MSG_TAG_DELETE_NO_REMOTE="（remote が未設定。remote はスキップ）"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="（remote [%s] にこの tag はありません。スキップ）\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="remote [%s] からも削除しますか？ [y/N] "
MSG_TAG_DELETE_REMOTE_DONE="remote tag を削除しました。"

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="用途: この commit を新しい worktree でチェックアウト。目的別にグループ分け"
MSG_WT_FROM_NOTE_FMT='目的: %s'
MSG_WT_FROM_PATH_EXISTS_FMT='パスは既に存在します: %s\n'
MSG_WT_FROM_PATH_HINT="ヒント: 既存の worktree を確認するには  git worktree list"
MSG_WT_FROM_BRANCH_EXISTS_FMT='ブランチは既に存在します: %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree を作成しました: %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  ブランチ: %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  後片付け: git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  後片付け: git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='ブランチ名（Enter で %s）: '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="用途: [%s] 配下の worktree を一覧表示し、削除する名前をユーザーに貼り付けてもらう"
MSG_WT_RM_USAGE_FMT="手順: 一覧を確認し、名前（%s/ プレフィックス含む）を貼り付けて確定"
MSG_WT_RM_EMPTY_FMT='[%s] に削除可能な worktree はありません。\n'
MSG_WT_RM_LIST_HEADER_FMT='[%s] の worktree:\n'
MSG_WT_RM_NAME_PROMPT="削除する worktree 名を貼り付けてください（上の 1 行をそのままコピー）: "
MSG_WT_RM_NO_INPUT="入力がないためキャンセルしました。"
MSG_WT_RM_NOT_IN_LIST_FMT="'%s' は [%s] の worktree 一覧にありません。\n"
MSG_WT_RM_REMOVING_FMT='削除中: %s\n'
MSG_WT_RM_DONE="✓ worktree を削除しました。"
MSG_WT_RM_REVIEW_NO_BRANCH="（review は detached のため、後片付けすべきブランチはありません）"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="ローカルブランチ '%s' も削除しますか？ [y/N] "
MSG_WT_RM_BRANCH_DONE="✓ ローカルブランチを削除しました。"
MSG_WT_RM_BRANCH_ABSENT_FMT="（ブランチ '%s' は存在しません。git worktree remove で既に削除済みの可能性）\n"

# ── branch-checkout.sh ──────────────────────────────────────────
MSG_BRANCH_CHECKOUT_TITLE="branch-checkout（この commit を指す branch に切り替える）"
MSG_BRANCH_CHECKOUT_PURPOSE="用途: HEAD を、この commit を指すローカル branch に切り替える"
MSG_BRANCH_CHECKOUT_WHEN="場面: Git Graph から既存 branch へ移動したいとき。branch 名をターミナルにコピーする手間が省ける"
MSG_BRANCH_CHECKOUT_NOTE="注意: 作業ツリーがクリーンであることが必要。既に対象 branch にいる場合は切り替えません"
MSG_BRANCH_CHECKOUT_DIRTY_TREE="作業ツリーに未コミットの変更があります。先に commit または stash してください。"
MSG_BRANCH_CHECKOUT_NONE="この commit に切り替え可能なローカル branch はありません。"
MSG_BRANCH_CHECKOUT_ONE_FMT='この commit を指す唯一の branch: %s\n'
MSG_BRANCH_CHECKOUT_LIST_HEADER="この commit を指すローカル branch:"
MSG_BRANCH_CHECKOUT_SELECT_PROMPT="1 つ選択してください（branch 名または番号）: "
MSG_BRANCH_CHECKOUT_NO_INPUT="入力がないためキャンセルしました。"
MSG_BRANCH_CHECKOUT_NOT_IN_LIST_FMT="branch '%s' はこの commit の一覧にありません。\n"
MSG_BRANCH_CHECKOUT_ALREADY_FMT='既に %s にいます。何もする必要はありません。\n'

# ── branch-rename.sh ────────────────────────────────────────────
MSG_BRANCH_RENAME_TITLE="branch-rename（この commit を指す branch をリネームする）"
MSG_BRANCH_RENAME_PURPOSE="用途: ローカル branch をリネーム。任意で remote 側も付け替え（旧名を削除して新名を push）"
MSG_BRANCH_RENAME_WHEN="場面: typo を修正 / try/* を再利用 / 命名規則に合わせる"
MSG_BRANCH_RENAME_NOTE="注意: remote のリネームは 2 操作（新名を push + 旧名を削除）。共同作業者と調整してください"
MSG_BRANCH_RENAME_NONE="この commit にリネーム可能なローカル branch はありません。"
MSG_BRANCH_RENAME_ONE_FMT='この commit を指す唯一の branch: %s\n'
MSG_BRANCH_RENAME_LIST_HEADER="この commit を指すローカル branch:"
MSG_BRANCH_RENAME_SELECT_PROMPT="リネームするものを選択してください（branch 名または番号）: "
MSG_BRANCH_RENAME_NO_INPUT="入力がないためキャンセルしました。"
MSG_BRANCH_RENAME_NOT_IN_LIST_FMT="branch '%s' はこの commit の一覧にありません。\n"
MSG_BRANCH_RENAME_NEW_NAME_PROMPT="新しい名前: "
MSG_BRANCH_RENAME_INVALID_NAME_FMT="無効な branch 名: %s\n"
MSG_BRANCH_RENAME_EXISTS_FMT="branch は既に存在します: %s\n"
MSG_BRANCH_RENAME_DONE_FMT="リネーム完了: %s → %s\n"
MSG_BRANCH_RENAME_REMOTE_PROMPT_FMT="remote [%s] 側もリネームしますか？（新名を push + 旧名を削除）[y/N] "
MSG_BRANCH_RENAME_REMOTE_DONE="remote 側のリネームが完了しました。"

# ── copy-branch-name.sh ─────────────────────────────────────────
MSG_COPY_BRANCH_TITLE="copy-branch-name（この commit を指す branch 名をクリップボードへコピー）"
MSG_COPY_BRANCH_PURPOSE="用途: branch 名をシステムのクリップボードに入れ、別の場所に貼り付けられるようにする"
MSG_COPY_BRANCH_WHEN="場面: チャットで送る / PR の説明に貼る / 別ターミナルで使う"
MSG_COPY_BRANCH_NOTE="注意: pbcopy (macOS) / wl-copy / xclip / xsel のうち利用可能なものを使用します"
MSG_COPY_BRANCH_NONE="この commit にコピーできるローカル branch はありません。"
MSG_COPY_BRANCH_LIST_HEADER="この commit を指すローカル branch:"
MSG_COPY_BRANCH_SELECT_PROMPT="1 つ選択してください（branch 名または番号）: "
MSG_COPY_BRANCH_NO_INPUT="入力がないためキャンセルしました。"
MSG_COPY_BRANCH_NOT_IN_LIST_FMT="branch '%s' はこの commit の一覧にありません。\n"
MSG_COPY_BRANCH_DONE_FMT="コピーしました: %s\n"
MSG_COPY_BRANCH_NO_CLIPBOARD="クリップボードユーティリティが見つかりません（pbcopy / wl-copy / xclip / xsel のいずれかが必要）。branch 名を以下に表示します:"

# ── copy-commit-message.sh ──────────────────────────────────────
MSG_COPY_MSG_TITLE="copy-commit-message（この commit のメッセージをクリップボードへコピー）"
MSG_COPY_MSG_PURPOSE="用途: commit の subject（1 行目）またはメッセージ全文をシステムのクリップボードに入れる"
MSG_COPY_MSG_WHEN="場面: リリースノート / PR / チャット / メールに貼り付ける"
MSG_COPY_MSG_NOTE="注意: pbcopy (macOS) / wl-copy / xclip / xsel のうち利用可能なものを使用します"
MSG_COPY_MSG_KIND_PROMPT="コピー対象 [s]ubject（デフォルト）/ [f]ull メッセージ全文: "
MSG_COPY_MSG_KIND_INVALID_FMT="無効な選択です: %s\n"
MSG_COPY_MSG_DONE_FMT='コピーしました: %s\n'
MSG_COPY_MSG_NO_CLIPBOARD="クリップボードユーティリティが見つかりません（pbcopy / wl-copy / xclip / xsel のいずれかが必要）。メッセージを以下に表示します:"
