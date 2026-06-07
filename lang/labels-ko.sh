#!/usr/bin/env bash
# tasks.json 메뉴 항목용 한국어 라벨.
# sync-tasks.sh가 로드; tasks.json의 __LABEL_*__ 자리표시자에 치환됨.
# 작은따옴표 사용 — $ZED_GIT_SHA_SHORT 등은 Zed용으로 리터럴 유지 필수.
# shellcheck shell=bash disable=SC2034

# ── 1. 보기 / 탐색 ──────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. 보기 / 탐색 ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · 이 commit을 포함하는 branch  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · 이 commit을 포함하는 tag  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · 이 commit의 Stat  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · 이 commit의 전체 diff  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · HEAD와 비교  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · 이 commit이 건드린 모든 파일 열기  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · 이 commit의 파일 스냅샷 내보내기  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · 이전 N개 commit을 patch로 내보내기  ($ZED_GIT_SHA_SHORT)'

# ── 2. 이 commit 수정 ──────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. 이 commit 수정 ────'
LABEL_MODIFY_REWORD='Git · 이 commit의 메시지 reword  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · 이 commit 편집 (메시지 + 파일 추가/제거)  ($ZED_GIT_SHA_SHORT)'

# ── 3. 히스토리 재작성 (rebase) ────────────────────────────────
LABEL_SEP_REWRITE='──── 3. 히스토리 재작성 (rebase) ────'
LABEL_REWRITE_SQUASH='Git · 여기서부터 N개 commit squash  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · 히스토리에서 이 commit 제거  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · 이 commit까지 interactive rebase  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · 이 commit으로 soft reset (변경 → 인덱스)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · 이 commit으로 hard reset (파괴적)  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup (변경을 이 commit에 병합) ─────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup (변경을 이 commit에 병합) ────'
LABEL_FIXUP_INTO_THIS='Git · 작업/스테이징 변경을 이 commit에 합치기 (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · 이 commit을 조상에 합치기 (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. 복사 / 되돌리기 ─────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. 복사 / 되돌리기 ────'
LABEL_COPY_CHERRY_PICK='Git · 현재 branch로 cherry-pick  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · 이 commit을 revert  ($ZED_GIT_SHA_SHORT)'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · 이 commit에서 새 branch 생성  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · 이 commit에서 즉석 try-branch  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · branch A를 branch B 위로 rebase (CLion 스타일)'
LABEL_BRANCH_DELETE='Git · 이 commit의 로컬 branch 삭제 (remote 선택 가능)  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · 이 commit에 tag 달기  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · tag 삭제 (로컬 + remote 선택)  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · 현재 변경 사항 stash (이름 지정)'
LABEL_STASH_POP='Git · 가장 최근 stash pop'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree (이 commit을 새 디렉토리에 checkout) ────'
LABEL_WT_REVIEW='Worktree · review  (detached, 읽기 전용)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (일회성 branch)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (버그 수정)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (새 기능)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · remove  review  (이름 붙여넣기로 확인)'
LABEL_WT_RM_TRY='Worktree · remove  try     (이름 붙여넣기로 확인)'
LABEL_WT_RM_FIX='Worktree · remove  fix     (이름 붙여넣기로 확인)'
LABEL_WT_RM_FEAT='Worktree · remove  feat    (이름 붙여넣기로 확인)'
LABEL_WT_RM_HOT='Worktree · remove  hot     (이름 붙여넣기로 확인)'
