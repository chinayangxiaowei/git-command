#!/usr/bin/env bash
# git-command 스크립트용 한국어 메시지 문자열.
# lib.sh에서 로드됨; 직접 실행 금지.
# 네이밍 규칙: MSG_<SCRIPT>_<KEY>; printf 템플릿은 _FMT 접미사 사용.
# shellcheck shell=bash

# ── lib.sh (공통 내부 모듈) ────────────────────────────────────
MSG_LIB_IN_PROGRESS_FMT='완료되지 않은 %s가 진행 중입니다. 먼저 "%s" 또는 --continue를 실행하세요.\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s 실패; git %s --abort를 자동 실행합니다 (작업 공간이 작업 이전 상태로 복원됨).\n'
MSG_LIB_NOT_IN_REPO='git 저장소 내부가 아닙니다.'
MSG_LIB_NOT_BARE_LAYOUT='현재 프로젝트가 bare + worktree 레이아웃이 아닙니다; worktree 메뉴 비활성화.'
MSG_LIB_INIT_HINT='활성화하려면 새 프로젝트를 생성하세요: bash git-command/init-bare-tree.sh <name> [<url>]'
MSG_LIB_MIGRATE_HINT='기존 프로젝트의 경우: migrate-to-bare-tree.sh (아직 미구현; 수동으로 마이그레이션).'
MSG_LIB_CLEANUP_FMT='스크립트가 예기치 않게 종료됨 (exit %d); 롤백을 위해 git %s --abort를 자동 실행합니다.\n'

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword (이 commit의 메시지를 다시 작성)"
MSG_REWORD_PURPOSE="용도:  commit 메시지만 변경; 파일 내용과 SHA 체인은 그대로 유지 (이후 SHA는 다시 작성됨)"
MSG_REWORD_WHEN="상황:  오타 수정 / 컨벤션 준수 / 이슈 참조 추가 / conventional-commit 접두사 조정"
MSG_REWORD_CONTRAST="주의:  HEAD 자체의 메시지는 edit-commit이 더 빠름; reword는 오래된 commit용"
MSG_REWORD_DIRTY_TREE="작업 트리에 commit되지 않은 변경 사항이 있습니다; 먼저 commit 또는 stash 하세요."
MSG_REWORD_NOT_ANCESTOR_FMT='%s가 현재 branch 조상 체인에 없습니다; reword 불가.\n'
MSG_REWORD_OLD_MSG="이전 메시지:"
MSG_REWORD_NEW_MSG_PROMPT="새 메시지 (한 줄씩 입력; 빈 줄 = 단락 구분; 'Q'만 입력하면 제출, ':q'는 취소):"
MSG_REWORD_CANCELLED="취소되었습니다."
MSG_REWORD_EMPTY_CANCELLED="입력 없음; 취소되었습니다."

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files (이 commit에서 변경된 모든 파일을 Zed에서 열기)"
MSG_OPEN_FILES_PURPOSE="용도:  이 commit에서 변경된 파일을 나열하고 Zed에서 모두 열기 (현재 작업 버전)"
MSG_OPEN_FILES_WHEN="상황:  과거 버그 디버깅 시; 해당 변경에 관련된 모든 파일을 보고 싶을 때"
MSG_OPEN_FILES_PREREQ="필요: PATH에 zed CLI 필요; 현재 트리에 없는 파일은 건너뜀"
MSG_OPEN_FILES_EMPTY="이 commit에는 파일 변경이 없습니다 (빈 commit일 가능성)."
MSG_OPEN_FILES_MISSING="다음 파일은 더 이상 작업 트리에 없습니다 (삭제됨/이름 변경됨), 건너뜁니다:"
MSG_OPEN_FILES_ALL_GONE="이 commit이 건드린 파일이 작업 트리에 하나도 남아있지 않습니다."
MSG_OPEN_FILES_OPENING_FMT='Zed에서 %d개의 파일을 엽니다:\n'
MSG_OPEN_FILES_NO_ZED="zed 명령을 찾을 수 없습니다."
MSG_OPEN_FILES_INSTALL_HINT="Zed에서: Cmd+Shift+P → 'zed: install cli'로 zed CLI를 설치하세요."

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files (이 commit 시점의 파일을 폴더로 내보내기)"
MSG_EXPORT_FILES_PURPOSE="용도:  이 commit에서 변경된 각 파일을 (이 commit 시점 버전으로) 폴더에 복사, 경로 유지"
MSG_EXPORT_FILES_WHEN="상황:  탭으로 열기에 파일이 너무 많음 / commit 결과물 스냅샷 / 오프라인 diff"
MSG_EXPORT_FILES_CONTRAST="주의:  open-files는 현재 작업 버전을 열지만, 이것은 이 commit 시점의 과거 버전을 내보냄"
MSG_EXPORT_FILES_EMPTY="이 commit에는 파일 변경이 없습니다 (빈 commit일 가능성)."
MSG_EXPORT_FILES_COUNT_FMT='이 commit은 %d개 파일을 변경했습니다:\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... 외 %d개 더\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='내보낼 디렉토리 (저장소 루트 기준, 기본값 %s): '
MSG_EXPORT_FILES_DIR_EXISTS_FMT='디렉토리가 존재하며 비어있지 않습니다: %s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="계속하면 동일한 이름의 파일을 덮어쓸 수 있습니다. 계속하시겠습니까?"
MSG_EXPORT_FILES_DELETED_HINT="(이 commit에서 삭제됨; 내보낼 것 없음)"
MSG_EXPORT_FILES_DONE_FMT='완료: %d개 내보냄, %d개 건너뜀 → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="주의: 내용은 이 commit 시점의 스냅샷이며, 현재 작업 버전이 아닙니다."

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches (N개의 patch 파일 내보내기)"
MSG_EXPORT_PATCHES_PURPOSE="용도:  여기서부터 거슬러 N개의 commit을 mbox (.patch) 또는 일반 diff (.diff)로 내보냄"
MSG_EXPORT_PATCHES_WHEN="상황:  이메일 협업 / 특정 변경 백업 / git am 또는 git apply용으로 다른 사람에게 전달"
MSG_EXPORT_PATCHES_OUTPUT="출력: 선택한 디렉토리 (기본값 ./patches); 히스토리는 절대 변경되지 않음"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="형식 [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply) (기본값 f): "
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='잘못된 형식: %s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="몇 개 commit을 거슬러 갈까요 (기본값 1): "
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='잘못된 개수: %s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="출력 디렉토리 (저장소 루트 기준, 기본값 ./patches): "
MSG_EXPORT_PATCHES_FORMAT_LABEL="형식:"
MSG_EXPORT_PATCHES_RANGE_LABEL="범위:"
MSG_EXPORT_PATCHES_OUTPUT_LABEL="출력:"
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(루트)"
MSG_EXPORT_PATCHES_CONTINUE="계속하시겠습니까?"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft (이 commit으로 soft reset · 변경 사항은 스테이징으로 이동)"
MSG_RESET_SOFT_PURPOSE="용도:  HEAD를 이 commit으로 이동; 그 사이 commit들의 변경 사항이 인덱스에 들어감 (손실 없음)"
MSG_RESET_SOFT_WHEN="상황:  마지막 N개 commit을 다시 묶고 싶을 때 (재분할 / 메시지 변경 / 병합)"
MSG_RESET_SOFT_AFTER="이후: git status로 인덱스 확인 후, 새 히스토리로 commit"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s가 HEAD 조상 체인에 없습니다; soft reset이 의미 없습니다.\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s가 이미 HEAD입니다; reset 불필요.\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='현재 branch: %s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='다음 commit들을 제거합니다 (변경 사항은 인덱스로, HEAD → %s):\n'
MSG_RESET_SOFT_CONFIRM_FMT='%s로 soft reset 하시겠습니까?'
MSG_RESET_SOFT_DONE="완료. 변경 사항이 인덱스에 있습니다; git status로 확인 후 다시 commit하여 재기록하세요."

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard (이 commit으로 hard reset · 파괴적)"
MSG_RESET_HARD_PURPOSE="용도:  HEAD를 이 commit으로 이동; 그 사이 commit들과 모든 작업 트리 변경 사항을 폐기"
MSG_RESET_HARD_WHEN="상황:  특정 상태로 완전히 되돌리고 싶고 중간 변경 사항을 모두 잃어도 확실할 때"
MSG_RESET_HARD_AFTER="이후: 복구 불가 (30일 이내 git reflog 제외; 대문자 YES 입력 필요)"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s가 HEAD 조상 체인에 없습니다; 거부합니다.\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s가 이미 HEAD입니다; reset 불필요.\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='현재 branch: %s\n'
MSG_RESET_HARD_WILL_DROP="다음 commit들을 제거합니다 (reflog 외에는 복구 불가):"
MSG_RESET_HARD_WT_LOST="작업 트리 변경 사항도 폐기됩니다:"
MSG_RESET_HARD_YES_PROMPT_FMT='%s로의 hard reset을 확인하려면 YES (대문자)를 입력하세요: '
MSG_RESET_HARD_NO_YES="YES가 입력되지 않음; 취소되었습니다."
MSG_RESET_HARD_REFLOG_HINT="힌트: reflog로 이 commit들을 복구할 수 있습니다; 30일 이내 git reflog → HEAD@{N} 확인."

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i (이 commit까지 interactive rebase)"
MSG_REBASE_I_PURPOSE='용도:  git rebase -i SHA^를 시작, 수동 todo 편집을 위해 $EDITOR를 엶'
MSG_REBASE_I_WHEN="상황:  여러 commit을 수동으로 재정렬/병합/편집/제거; 표준 메뉴 범위를 벗어나는 복잡한 경우"
MSG_REBASE_I_PREREQ="필요: 작업 트리가 깨끗해야 함; 충돌 발생 시 수동 처리하거나 EXIT trap의 abort에 의존"
MSG_REBASE_I_RANGE_FMT='interactive rebase를 시작합니다, 범위: %s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="작업 트리에 commit되지 않은 변경 사항이 있습니다; 먼저 commit 또는 stash 하세요."
MSG_REBASE_I_CONTINUE="계속하시겠습니까?"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert (이 commit을 되돌리는 역방향 commit 생성)"
MSG_REVERT_PURPOSE="용도:  히스토리를 다시 작성하지 않음; 이 commit 변경 사항의 역방향을 HEAD 위에 새 commit으로 추가"
MSG_REVERT_WHEN="상황:  이미 push된 commit을 되돌려야 할 때 (reset은 공개 히스토리를 다시 작성함)"
MSG_REVERT_CONTRAST="주의:  reset은 히스토리를 다시 작성; revert는 히스토리에 덧붙임. 충돌 시 자동 abort."
MSG_REVERT_DIRTY_TREE="작업 트리에 commit되지 않은 변경 사항이 있습니다; 먼저 commit 또는 stash 하세요."
MSG_REVERT_CONFIRM_FMT='HEAD 위에 역방향 commit을 생성하여 %s를 되돌리시겠습니까?\n'

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick (이 commit을 현재 branch 끝으로 복사)"
MSG_CHERRY_PICK_PURPOSE="용도:  이 commit의 변경 사항을 현재 branch 끝에 새 commit으로 복사 (새 SHA)"
MSG_CHERRY_PICK_WHEN="상황:  branch 간 hotfix 이식 / 동료의 단일 commit 가져오기 / reflog로 복구"
MSG_CHERRY_PICK_NOTE="주의:  원본 commit은 삭제되지 않음; 동일 branch에는 의미 없음; 충돌 시 자동 abort"
MSG_CHERRY_PICK_CURRENT_FMT='현재 branch: %s\n'
MSG_CHERRY_PICK_DIRTY_TREE="작업 트리에 commit되지 않은 변경 사항이 있습니다; 먼저 commit 또는 stash 하세요."
MSG_CHERRY_PICK_CONFIRM_FMT='%s를 %s에 cherry-pick 하시겠습니까?'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from (이 commit에서 새 branch 생성)"
MSG_BRANCH_FROM_PURPOSE="용도:  이 commit에서 새 branch를 생성하고 전환"
MSG_BRANCH_FROM_WHEN="상황:  오래된 commit에서 새 작업을 시작 / 특정 상태에 이름 있는 ref 유지"
MSG_BRANCH_FROM_CONTRAST="주의:  일회성 실험에는 try-branch 사용 (자동 try/ 접두사 + 정리 힌트)"
MSG_BRANCH_FROM_NAME_PROMPT="새 branch 이름 (이 commit 기반): "
MSG_BRANCH_FROM_NO_NAME="branch 이름이 입력되지 않음; 취소되었습니다."

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch (이 commit에서 일회성 branch)"
MSG_TRY_BRANCH_PURPOSE="용도:  이 commit에서 try/<base-slug>-<sha> 이름의 branch를 생성하고 즉시 전환"
MSG_TRY_BRANCH_WHEN="상황:  현재 branch를 오염시키지 않고 실험 / 오래된 commit 시점 상태 검사"
MSG_TRY_BRANCH_HINT="힌트:  종료 시 '원본으로 돌아가기' + '이 branch 삭제' 명령을 알림으로 출력"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # detached 상태였음; reflog 참조"
MSG_TRY_BRANCH_FROM_FMT='원본 branch: %s\n시작 지점:   %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='새 branch 이름 (Enter = %s): '
MSG_TRY_BRANCH_EXISTS_FMT='branch가 이미 존재합니다: %s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="생성 후 전환하시겠습니까? [Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='%s 생성됨 (전환 안 함)\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="작업이 끝나면 다음으로 정리하세요:"
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  원본으로 돌아가기: %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  이 branch 삭제: git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push (현재 변경 사항을 이름과 함께 stash)"
MSG_STASH_PUSH_PURPOSE="용도:  추적 중인 변경 사항을 라벨과 함께 stash, 작업 트리는 깨끗하게 남김"
MSG_STASH_PUSH_WHEN="상황:  WIP 상태에서 branch 전환 직전 / 잠시 작업 보류 / reset 전 사전 정리"
MSG_STASH_PUSH_NOTE="주의:  -u는 사용하지 않음; untracked 파일은 작업 트리에 그대로 유지 (불필요한 Git Graph 스냅샷 노드 회피)"
MSG_STASH_PUSH_CLEAN="작업 트리가 깨끗합니다; stash할 것이 없습니다."
MSG_STASH_PUSH_WILL_STASH="다음 변경 사항을 stash합니다:"
MSG_STASH_PUSH_NAME_PROMPT="이름을 정해주세요 (나중에 찾기 쉽게): "
MSG_STASH_PUSH_NO_NAME="이름이 입력되지 않음; 취소되었습니다."
MSG_STASH_PUSH_DONE_HINT="완료. 보기: git stash list, 또는 메뉴의 '가장 최근 stash pop' 사용."
MSG_STASH_PUSH_UNTRACKED_NOTE="주의: untracked 파일은 stash되지 않았으며 작업 트리에 그대로 남아 있습니다."

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop (가장 최근 stash를 작업 트리에 적용)"
MSG_STASH_POP_PURPOSE="용도:  stash@{0}을 작업 트리에 적용; 성공 시 stash는 자동 제거됨"
MSG_STASH_POP_WHEN="상황:  이전에 stash한 변경 사항을 되돌려야 할 때"
MSG_STASH_POP_NOTE="주의:  충돌 시 stash는 자동 제거되지 않음; 충돌 해결 후 git stash drop 실행"
MSG_STASH_POP_EMPTY="pop할 stash가 없습니다."
MSG_STASH_POP_LIST_HEADER="최근 stash 목록:"
MSG_STASH_POP_PREVIEW_HEADER="stash@{0} 미리보기:"
MSG_STASH_POP_CONFIRM="stash@{0}을 현재 작업 트리에 pop 하시겠습니까?"
MSG_STASH_POP_CONFLICT="pop에 충돌 발생 — stash는 보존됨 (자동 제거 안 됨)."
MSG_STASH_POP_CONFLICT_HINT="충돌 해결 + git add 후, git stash drop 으로 제거하세요."

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete (이 commit을 가리키는 로컬 branch 삭제)"
MSG_BRANCH_DELETE_PURPOSE="용도:  로컬 branch 삭제 (선택적으로 remote 것도)"
MSG_BRANCH_DELETE_WHEN="상황:  merge되었거나 일회성 branch 정리; try/* feat/* 등 일괄 정리"
MSG_BRANCH_DELETE_NOTE="주의:  git branch -D를 사용 (강제 삭제; merge 상태 무시)"
MSG_BRANCH_DELETE_NONE="이 commit에 삭제할 로컬 branch가 없습니다."
MSG_BRANCH_DELETE_ONE_FMT='이 commit의 유일한 branch: %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="이 commit의 로컬 branch:"
MSG_BRANCH_DELETE_SELECT_PROMPT="선택 (branch 이름 또는 번호): "
MSG_BRANCH_DELETE_NO_INPUT="입력 없음; 취소되었습니다."
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="branch '%s'는 이 commit의 목록에 없습니다.\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="현재 checkout된 branch '%s'는 삭제할 수 없습니다.\n"
MSG_BRANCH_DELETE_CURRENT_HINT="먼저 다른 branch로 전환하세요: git switch <other-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="로컬 branch '%s'를 삭제하시겠습니까?"
MSG_BRANCH_DELETE_LOCAL_DONE="로컬 branch가 삭제되었습니다."
MSG_BRANCH_DELETE_NO_REMOTE="(remote가 설정되어 있지 않음; remote 건너뜀)"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="(remote [%s]에 branch가 없음; 건너뜀)"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="remote [%s]에서도 삭제하시겠습니까? [y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="remote branch가 삭제되었습니다."

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit (이 commit의 메타데이터 / 파일 목록 편집)"
MSG_EDIT_COMMIT_HEAD_PATH="HEAD 경로:  작업 트리가 dirty일 수 있음; 직접 amend; 메시지 변경 / 파일 추가 / 제거 / 수정"
MSG_EDIT_COMMIT_OLD_PATH="오래된 commit: 작업 트리가 깨끗해야 함; 메시지 / (untracked) 추가 / 파일 제거 지원"
MSG_EDIT_COMMIT_NOT_SUITED="부적합 (오래된 commit): 기존 파일 내용 수정 → fixup 메뉴 사용 (이유는 헤더 주석 참조)"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="줄당 하나의 작업, 'Q'를 단독으로 입력하면 종료:"
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:path/to/file    git add (추가 / 업데이트 / 모든 변경 스테이징)"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:path/to/file    이 commit에서 제거 (디스크는 보존, git rm --cached)"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                 완료"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  형식 오류 건너뜀: %s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  건너뜀 +%s  (파일이 존재하지 않음)\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  추가 %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  건너뜀 +%s  (git add 실패)\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  제거 %s  (commit에서 제거됨, 디스크에는 유지)\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  건너뜀 -%s  (이 commit에 없음)\n'
MSG_EDIT_COMMIT_ASK_MSG="새 메시지 (한 줄씩; 'Q'만 입력하면 제출; Q만 = 변경 없이 유지):"
MSG_EDIT_COMMIT_HEAD_HEADER="─── HEAD 빠른 경로 ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="대상이 HEAD이므로 rebase 불필요:"
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · 작업 트리가 dirty일 수 있음 (변경 사항이 amend 후보가 됨)"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · 파일 추가 / 수정 / 제거를 자유롭게; 이후 충돌 위험 없음"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── 현재 메시지 ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── 현재 작업/스테이징 변경 사항 ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="메시지를 변경하시겠습니까? [y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="파일을 변경하시겠습니까 (추가/제거/수정)? [y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="(변경 사항 없음; amend 안 함; 종료.)"
MSG_EDIT_COMMIT_UNSTAGED_HINT="주의: 작업 트리에 아직 unstaged 변경 사항이 있습니다; amend는 이들을 포함하지 않습니다."
MSG_EDIT_COMMIT_AMEND_MSG_FILES="Amend 완료 (새 메시지 + 파일 변경)"
MSG_EDIT_COMMIT_AMEND_MSG="Amend 완료 (새 메시지)"
MSG_EDIT_COMMIT_AMEND_FILES="Amend 완료 (파일 변경)"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='작업 트리에 commit되지 않은 변경 사항이 있습니다.

해당 변경 사항을 이 commit에 합치고 싶다면 → 다음 메뉴를 사용하세요:
  "작업/스테이징 변경 사항을 이 commit에 합치기 (fixup+autosquash)"

정말로 이 메뉴를 사용하고 싶다면 (메시지 변경 / 새 파일 추가 / 파일 제거), 먼저 commit 또는 stash 하세요.'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s가 현재 branch 조상 체인에 없습니다.\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── 오래된 commit 경로 (rebase) ───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="적용 대상: 메시지 / 새 파일 (untracked) 추가 / 파일 제거"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="적용 안 됨: 기존 파일 내용 수정 (fixup 메뉴 사용)"
MSG_EDIT_COMMIT_OLD_CONTINUE="계속하시겠습니까?"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="rebase가 edit 상태로 진입하지 않았습니다."
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── 현재 commit 메시지 ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="메시지를 변경하시겠습니까? [y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="파일을 변경하시겠습니까 (추가/제거)? [y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="(변경 사항 없음; 마무리)"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue 실패 (방금 제거한 파일에 대한 이후 modify/delete 충돌일 가능성)."
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase 완료"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n (이 commit에서부터 N개 commit을 squash)"
MSG_SQUASH_PURPOSE="용도:  이 commit과 N-1개 조상을 하나로 squash; 이후 commit은 그 위에 재생"
MSG_SQUASH_WHEN="상황:  WIP commit 정리 / 노이즈 압축 / 관련된 작은 commit 여러 개 병합"
MSG_SQUASH_PREREQ="필요: 작업 트리가 깨끗해야 함; 이후 SHA가 변경됨; 충돌 시 자동 abort"
MSG_SQUASH_DIRTY_TREE="작업 트리에 commit되지 않은 변경 사항이 있습니다; 먼저 commit 또는 stash 하세요."
MSG_SQUASH_COUNT_PROMPT="몇 개를 squash 할까요 (이 commit 포함, 기본값 2): "
MSG_SQUASH_MIN_TWO="squash가 의미 있으려면 최소 2개 commit이 필요합니다."
MSG_SQUASH_TOO_MANY_FMT='이 commit은 자신 포함 %d개 조상밖에 없습니다; 최대 %d개.\n'
MSG_SQUASH_PREVIEW_FMT='다음 %d개 commit을 squash 합니다 (오래된 것 → 새 것):\n'
MSG_SQUASH_MSG_PROMPT="새 commit 메시지 (한 줄씩; Q만 입력하면 제출; Q만 단독 = 기본 결합으로 editor 열기; :q는 취소):"
MSG_SQUASH_CANCELLED="취소되었습니다."
MSG_SQUASH_CONTINUE="계속하시겠습니까?"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit (히스토리에서 이 commit 삭제)"
MSG_DROP_PURPOSE="용도:  branch 히스토리에서 이 commit 제거; 이후 commit은 재생 (새 SHA)"
MSG_DROP_WHEN="상황:  실수 commit (비밀번호 / 디버그 코드) / 쓸모없는 WIP / 중복 / 지워야 할 실험"
MSG_DROP_CONTRAST="주의:  revert는 역방향 commit을 추가 (히스토리 유지); drop은 진짜로 제거 (히스토리 재작성)"
MSG_DROP_DIRTY_TREE="작업 트리에 commit되지 않은 변경 사항이 있습니다; 먼저 commit 또는 stash 하세요."
MSG_DROP_NOT_ANCESTOR_FMT='%s가 현재 branch 조상 체인에 없습니다.\n'
MSG_DROP_ROOT_COMMIT_FMT='%s는 root commit이며 부모가 없습니다; rebase로 제거할 수 없습니다.\n'
MSG_DROP_ROOT_HINT="root commit을 진짜로 제거하려면 git update-ref 등을 사용; 수동으로 처리하세요."
MSG_DROP_WILL_REMOVE="제거 대상:"
MSG_DROP_DOWNSTREAM_FMT='%d개의 이후 commit이 재생됩니다 (SHA 변경):\n'
MSG_DROP_DOWNSTREAM_HINT="  (이후 변경 사항이 이 commit에 의존하면 → 충돌 시 자동 abort)"
MSG_DROP_IS_HEAD_NOTE="(이 commit이 HEAD → git reset --hard HEAD~로 빠른 경로; rebase 없음)"
MSG_DROP_CONFIRM="제거를 확인하시겠습니까?"
MSG_DROP_DONE_HEAD="완료. HEAD가 이전 commit으로 이동했습니다."
MSG_DROP_DONE_REBASE="완료. 해당 commit이 히스토리에서 제거되었습니다."

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup (작업 트리 변경 사항을 이 commit에 합치기)"
MSG_FIXUP_PURPOSE="용도:  fixup commit 생성 + autosquash로 작업 트리 변경 사항을 이 commit에 병합"
MSG_FIXUP_WHEN="상황:  파일을 편집했고 오래된 commit에 들어가길 원할 때 (매우 흔함); 히스토리 오염 회피"
MSG_FIXUP_PREREQ="필요: 작업 / 스테이징 트리에 변경 사항이 있어야 함; 충돌 시 자동 abort"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s가 현재 branch 조상 체인에 없습니다.\n'
MSG_FIXUP_NO_CHANGES="작업 트리가 깨끗합니다; 합칠 것이 없습니다."
MSG_FIXUP_WORKFLOW_HINT="워크플로우: 파일 편집 → 이 메뉴 사용 → 대상 commit 선택 → 자동 fixup + autosquash."
MSG_FIXUP_WILL_FOLD="이 commit에 합칠 변경 사항:"
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="인덱스에 이미 내용이 있음; unstaged 변경 사항도 포함하시겠습니까? [y/N] "
MSG_FIXUP_ASK_ADD_ALL="인덱스가 비어있음; git add -A로 전부 추가하고 fixup 하시겠습니까? [Y/n] "
MSG_FIXUP_EMPTY_INDEX="인덱스가 비어있음; fixup할 것이 없습니다; 취소되었습니다."
MSG_FIXUP_TARGET_FMT='대상: %s  "%s"\n'
MSG_FIXUP_CONFIRM="fixup + autosquash를 확인하시겠습니까? [Y/n] "
MSG_FIXUP_CANCELLED="취소되었습니다; 인덱스 상태 보존됨."
MSG_FIXUP_CREATED="  + fixup commit 생성됨"
MSG_FIXUP_DONE_FMT='완료. 변경 사항이 %s에 병합됨 (autosquash 후 SHA 업데이트).\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup (이 commit을 조상에 합치기)"
MSG_CFIX_PURPOSE="용도:  이 commit을 가져와 같은 branch의 더 이른 commit에 fixup으로 적용"
MSG_CFIX_WHEN="상황:  HEAD의 수정 사항이 사실은 더 이른 commit에 속할 때; 제자리로 이동"
MSG_CFIX_CONTRAST="주의:  fixup.sh는 작업 트리 변경 사항을 사용; 이 메뉴는 기존 commit을 사용"
MSG_CFIX_DIRTY_TREE="작업 트리에 commit되지 않은 변경 사항이 있습니다; 먼저 commit 또는 stash 하세요."
MSG_CFIX_NOT_ANCESTOR_SRC="원본 commit이 현재 branch 조상 체인에 없습니다."
MSG_CFIX_HEADER="이 commit을 다른 commit에 fixup으로 합칩니다."
MSG_CFIX_TARGET_HINT="대상은 원본의 조상 (히스토리에서 더 이전)이어야 합니다. 힌트: Zed Graph에서 대상 SHA를 복사하세요."
MSG_CFIX_TARGET_PROMPT="대상 commit SHA (짧은 형식 또는 긴 형식): "
MSG_CFIX_NO_INPUT="입력 없음; 취소되었습니다."
MSG_CFIX_INVALID_SHA_FMT='잘못된 SHA: %s\n'
MSG_CFIX_SAME_COMMIT="대상과 원본이 같습니다; 의미 없음."
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s가 원본 commit의 조상이 아닙니다 (해당 commit에 fixup 불가).\n'
MSG_CFIX_PREVIEW="─── 미리보기 ───"
MSG_CFIX_SOURCE_LABEL="원본:"
MSG_CFIX_TARGET_LABEL="대상:"
MSG_CFIX_RANGE_LABEL="rebase 범위 (오래된 것 → 새 것):"
MSG_CFIX_CONTINUE="계속하시겠습니까?"
MSG_CFIX_DONE="완료. 원본이 대상에 합쳐졌습니다 (대상 commit의 SHA 업데이트됨)."

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto (branch A를 branch B 위로 rebase)"
MSG_RBO_PURPOSE="용도:  git switch A && git rebase B; A의 고유 commit들이 B의 끝에 재생됨"
MSG_RBO_WHEN="상황:  A가 feature branch, B가 main/develop; A를 B의 최신 상태로 끌어올림"
MSG_RBO_NOTE="주의:  A의 commit들이 다시 작성됨 (새 SHA); 충돌 시 자동 abort"
MSG_RBO_DIRTY_TREE="작업 트리에 commit되지 않은 변경 사항이 있습니다; 먼저 commit 또는 stash 하세요."
MSG_RBO_LOCAL_BRANCHES="로컬 branch:"
MSG_RBO_A_PROMPT_FMT='branch A (rebase될 대상; Enter = 현재 %s): '
MSG_RBO_DETACHED_ERR="현재 detached HEAD 상태입니다; branch A를 명시적으로 지정해야 합니다."
MSG_RBO_NO_LOCAL_FMT='로컬 branch 없음: %s\n'
MSG_RBO_B_PROMPT="branch B (rebase 대상; 로컬 / remote / tag): "
MSG_RBO_NO_INPUT="입력 없음; 취소되었습니다."
MSG_RBO_INVALID_REF_FMT='잘못된 대상 ref: %s\n'
MSG_RBO_SAME="A와 B가 같은 commit을 가리킵니다; rebase할 것이 없습니다."
MSG_RBO_PREVIEW="─── 미리보기 ───"
MSG_RBO_NO_EXCLUSIVE="A에 B를 넘는 commit이 없습니다 (A가 B의 조상이거나 동일함)."
MSG_RBO_FF_OR_NOOP="rebase가 fast-forward이거나 no-op이 됩니다."
MSG_RBO_REPLAY_FMT='재생될 A의 commit (%d):\n'
MSG_RBO_CONFIRM_FMT='진행: git switch %s && git rebase %s ?'
MSG_RBO_SWITCHING_FMT='%s로 전환 중...\n'
MSG_RBO_DONE="완료."

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag (이 commit에 tag 달기)"
MSG_TAG_PURPOSE="용도:  이 commit을 가리키는 lightweight 또는 annotated tag 생성; 선택적으로 remote에 push"
MSG_TAG_WHEN="상황:  릴리스 시점 / 마일스톤 / commit에 대한 안정적인 이름 있는 참조"
MSG_TAG_CONTRAST="주의:  annotated는 메시지+작성자+시간 포함 (릴리스에 권장); lightweight는 단순 ref"
MSG_TAG_NAME_PROMPT="tag 이름 (예: v1.0.0 / release-2024-01): "
MSG_TAG_NO_INPUT="입력 없음; 취소되었습니다."
MSG_TAG_EXISTS_FMT='tag가 이미 존재합니다: %s\n'
MSG_TAG_KIND_PROMPT="annotated (메시지 포함) 또는 lightweight? [a]/l (기본값 a): "
MSG_TAG_MSG_PROMPT="tag 메시지 (Enter = tag 이름 사용): "
MSG_TAG_CREATED_FMT='tag 생성됨: %s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='remote [%s]에 push 하시겠습니까? [y/N] '
MSG_TAG_NO_REMOTE="(remote가 설정되어 있지 않음; push 건너뜀)"
MSG_TAG_REFRESH_HINT="주의: Zed Git Graph는 tag 변경을 감지하지 않습니다; 수동으로 갱신하세요 (Cmd+Shift+P → reload window, 또는 다음 commit까지 대기)."

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete (tag 삭제)"
MSG_TAG_DELETE_PURPOSE="용도:  로컬 tag 삭제; 선택적으로 remote에서도 삭제"
MSG_TAG_DELETE_WHEN="상황:  잘못된 tag / 재릴리스 / 정리"
MSG_TAG_DELETE_NOTE="주의:  push된 remote tag 삭제는 다른 사람에게 영향을 줌; 로컬 + remote는 별도로 묻습니다"
MSG_TAG_DELETE_AT_HEADER="이 commit의 tag:"
MSG_TAG_DELETE_NONE="  (없음)"
MSG_TAG_DELETE_NAME_PROMPT="삭제할 tag 이름 (다른 commit의 것일 수도 있음): "
MSG_TAG_DELETE_NO_INPUT="입력 없음; 취소되었습니다."
MSG_TAG_DELETE_NOT_EXIST_FMT='tag가 존재하지 않습니다: %s\n'
MSG_TAG_DELETE_ANNOTATED="(annotated tag)"
MSG_TAG_DELETE_PREVIEW_FMT="tag '%s' → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="로컬 tag '%s'를 삭제하시겠습니까?"
MSG_TAG_DELETE_LOCAL_DONE="로컬 tag가 삭제되었습니다."
MSG_TAG_DELETE_NO_REMOTE="(remote가 설정되어 있지 않음; remote 건너뜀)"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="(remote [%s]에 해당 tag가 없음; 건너뜀)\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="remote [%s]에서도 삭제하시겠습니까? [y/N] "
MSG_TAG_DELETE_REMOTE_DONE="remote tag가 삭제되었습니다."

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="용도:  이 commit을 새 worktree에 checkout, 목적별로 그룹화"
MSG_WT_FROM_NOTE_FMT='목적: %s'
MSG_WT_FROM_PATH_EXISTS_FMT='경로가 이미 존재합니다: %s\n'
MSG_WT_FROM_PATH_HINT="힌트: git worktree list 를 실행하여 기존 worktree를 확인하세요"
MSG_WT_FROM_BRANCH_EXISTS_FMT='branch가 이미 존재합니다: %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree 생성됨: %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  branch: %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  정리: git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  정리: git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='branch 이름 (Enter = %s): '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="용도:  [%s] 아래 worktree를 나열하고 사용자가 삭제할 이름을 붙여넣게 함"
MSG_WT_RM_USAGE_FMT="방법:   목록 확인 후, 이름을 붙여넣기 (%s/ 접두사 포함), 그리고 확인"
MSG_WT_RM_EMPTY_FMT='[%s]에 제거할 worktree가 없습니다.\n'
MSG_WT_RM_LIST_HEADER_FMT='[%s] worktree:\n'
MSG_WT_RM_NAME_PROMPT="삭제할 worktree 이름을 붙여넣으세요 (위에서 전체 줄을 복사): "
MSG_WT_RM_NO_INPUT="입력 없음; 취소되었습니다."
MSG_WT_RM_NOT_IN_LIST_FMT="'%s'가 [%s] worktree 목록에 없습니다.\n"
MSG_WT_RM_REMOVING_FMT='제거 중: %s\n'
MSG_WT_RM_DONE="✓ worktree가 제거되었습니다."
MSG_WT_RM_REVIEW_NO_BRANCH="(review는 detached 상태; 정리할 branch 없음)"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="로컬 branch '%s'도 삭제하시겠습니까? [y/N] "
MSG_WT_RM_BRANCH_DONE="✓ 로컬 branch가 삭제되었습니다."
MSG_WT_RM_BRANCH_ABSENT_FMT="(branch '%s'가 존재하지 않음; git worktree remove로 이미 제거되었을 가능성)\n"

# ── branch-checkout.sh ──────────────────────────────────────────
MSG_BRANCH_CHECKOUT_TITLE="branch-checkout (이 commit을 가리키는 branch로 전환)"
MSG_BRANCH_CHECKOUT_PURPOSE="용도:  HEAD를 이 commit을 가리키는 로컬 branch로 전환"
MSG_BRANCH_CHECKOUT_WHEN="상황:  Git Graph에서 기존 branch로 이동하고 싶을 때 (이름을 터미널에 복사하는 대신)"
MSG_BRANCH_CHECKOUT_NOTE="주의:  작업 트리가 깨끗해야 하며, 이미 해당 branch에 있다면 전환하지 않습니다"
MSG_BRANCH_CHECKOUT_DIRTY_TREE="작업 트리에 commit되지 않은 변경 사항이 있습니다; 먼저 commit 또는 stash 해주세요."
MSG_BRANCH_CHECKOUT_NONE="이 commit에 checkout할 로컬 branch가 없습니다."
MSG_BRANCH_CHECKOUT_ONE_FMT='이 commit의 유일한 branch: %s\n'
MSG_BRANCH_CHECKOUT_LIST_HEADER="이 commit의 로컬 branch:"
MSG_BRANCH_CHECKOUT_SELECT_PROMPT="하나를 선택하세요 (branch 이름 또는 번호): "
MSG_BRANCH_CHECKOUT_NO_INPUT="입력 없음; 취소되었습니다."
MSG_BRANCH_CHECKOUT_NOT_IN_LIST_FMT="branch '%s'는 이 commit의 목록에 없습니다.\n"
MSG_BRANCH_CHECKOUT_ALREADY_FMT='이미 %s에 있습니다; 할 일이 없습니다.\n'

# ── branch-rename.sh ────────────────────────────────────────────
MSG_BRANCH_RENAME_TITLE="branch-rename (이 commit을 가리키는 branch 이름 변경)"
MSG_BRANCH_RENAME_PURPOSE="용도:  로컬 branch 이름 변경; 선택적으로 remote에도 재적용 (이전 이름 삭제, 새 이름 push)"
MSG_BRANCH_RENAME_WHEN="상황:  오타 수정 / try/* 재사용 / 이름 표준화"
MSG_BRANCH_RENAME_NOTE="주의:  remote 이름 변경은 두 단계 작업입니다 (새 이름 push + 이전 이름 삭제); 협업자와 조율하세요"
MSG_BRANCH_RENAME_NONE="이 commit에 이름을 변경할 로컬 branch가 없습니다."
MSG_BRANCH_RENAME_ONE_FMT='이 commit의 유일한 branch: %s\n'
MSG_BRANCH_RENAME_LIST_HEADER="이 commit의 로컬 branch:"
MSG_BRANCH_RENAME_SELECT_PROMPT="이름을 변경할 항목 선택 (branch 이름 또는 번호): "
MSG_BRANCH_RENAME_NO_INPUT="입력 없음; 취소되었습니다."
MSG_BRANCH_RENAME_NOT_IN_LIST_FMT="branch '%s'는 이 commit의 목록에 없습니다.\n"
MSG_BRANCH_RENAME_NEW_NAME_PROMPT="새 이름: "
MSG_BRANCH_RENAME_INVALID_NAME_FMT="잘못된 branch 이름: %s\n"
MSG_BRANCH_RENAME_EXISTS_FMT="branch가 이미 존재합니다: %s\n"
MSG_BRANCH_RENAME_DONE_FMT="이름 변경됨: %s → %s\n"
MSG_BRANCH_RENAME_REMOTE_PROMPT_FMT="remote [%s]에서도 이름을 변경하시겠습니까 (새 이름 push + 이전 이름 삭제)? [y/N] "
MSG_BRANCH_RENAME_REMOTE_DONE="remote 이름 변경 완료."

# ── copy-branch-name.sh ─────────────────────────────────────────
MSG_COPY_BRANCH_TITLE="copy-branch-name (이 commit을 가리키는 branch 이름을 클립보드에 복사)"
MSG_COPY_BRANCH_PURPOSE="용도:  branch 이름을 시스템 클립보드에 복사해서 다른 곳에 붙여넣기"
MSG_COPY_BRANCH_WHEN="상황:  채팅으로 이름 공유 / PR 설명에 붙여넣기 / 다른 터미널에서 사용"
MSG_COPY_BRANCH_NOTE="주의:  pbcopy (macOS) / wl-copy / xclip / xsel 중 사용 가능한 것을 이용합니다"
MSG_COPY_BRANCH_NONE="이 commit에 복사할 로컬 branch가 없습니다."
MSG_COPY_BRANCH_LIST_HEADER="이 commit의 로컬 branch:"
MSG_COPY_BRANCH_SELECT_PROMPT="하나를 선택하세요 (branch 이름 또는 번호): "
MSG_COPY_BRANCH_NO_INPUT="입력 없음; 취소되었습니다."
MSG_COPY_BRANCH_NOT_IN_LIST_FMT="branch '%s'는 이 commit의 목록에 없습니다.\n"
MSG_COPY_BRANCH_DONE_FMT="복사됨: %s\n"
MSG_COPY_BRANCH_NO_CLIPBOARD="클립보드 유틸리티를 찾을 수 없습니다 (pbcopy / wl-copy / xclip / xsel 필요). branch 이름을 아래에 출력합니다:"

# ── copy-commit-message.sh ──────────────────────────────────────
MSG_COPY_MSG_TITLE="copy-commit-message (이 commit의 message를 클립보드에 복사)"
MSG_COPY_MSG_PURPOSE="용도:  commit의 제목 (한 줄) 또는 전체 message를 시스템 클립보드에 복사"
MSG_COPY_MSG_WHEN="상황:  릴리스 노트 / PR / 채팅 / 이메일에 붙여넣기"
MSG_COPY_MSG_NOTE="주의:  pbcopy (macOS) / wl-copy / xclip / xsel 중 사용 가능한 것을 이용합니다"
MSG_COPY_MSG_KIND_PROMPT="복사할 항목 [s] 제목 (기본) / [f] 전체 message: "
MSG_COPY_MSG_KIND_INVALID_FMT="잘못된 선택: %s\n"
MSG_COPY_MSG_DONE_FMT='복사됨: %s\n'
MSG_COPY_MSG_NO_CLIPBOARD="클립보드 유틸리티를 찾을 수 없습니다 (pbcopy / wl-copy / xclip / xsel 필요). message를 아래에 출력합니다:"
