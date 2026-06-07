#!/usr/bin/env bash
# tasks.json 메뉴 항목용 한국어 라벨 (간결형).
# sync-tasks.sh가 로드; tasks.json의 __LABEL_*__ 자리표시자에 치환됨.
# 작은따옴표 사용 — $ZED_GIT_SHA_SHORT 등은 Zed용 리터럴로 유지.
#
# 설계 원칙: 메뉴 라벨은 최소화 — 동사 + 핵심 명사. commit 컨텍스트는
# 우클릭한 행에서 이미 암묵적. 상세 설명은 각 스크립트의 show_intro 실행 시.
# shellcheck shell=bash disable=SC2034

# ── 1. 보기 ─────────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. 보기 ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · 포함 branch'
LABEL_VIEW_TAGS_CONTAINING='Git · 포함 tag'
LABEL_VIEW_STAT='Git · stat'
LABEL_VIEW_DIFF='Git · diff'
LABEL_VIEW_DIFF_HEAD='Git · HEAD와 diff'
LABEL_VIEW_OPEN_FILES='Git · 파일 열기'
LABEL_VIEW_EXPORT_FILES='Git · 파일 내보내기'
LABEL_VIEW_EXPORT_PATCHES='Git · 패치 내보내기'

# ── 2. 수정 ───────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. 수정 ────'
LABEL_MODIFY_REWORD='Git · Reword'
LABEL_MODIFY_EDIT_COMMIT='Git · commit 편집'

# ── 3. 히스토리 재작성 ──────────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. 히스토리 재작성 ────'
LABEL_REWRITE_SQUASH='Git · Squash N'
LABEL_REWRITE_DROP='Git · Drop'
LABEL_REWRITE_INTERACTIVE='Git · Rebase -i'
LABEL_REWRITE_RESET_SOFT='Git · Reset soft'
LABEL_REWRITE_RESET_HARD='Git · Reset hard ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup 대상'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fixup 조상'

# ── 5. 복사 / 되돌리기 ──────────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. 복사 / 되돌리기 ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · 새 branch'
LABEL_BRANCH_TRY='Git · branch 시도'
LABEL_BRANCH_REBASE_ONTO='Git · A를 B로 Rebase'
LABEL_BRANCH_DELETE='Git · branch 삭제'
LABEL_BRANCH_CHECKOUT='Git · branch 전환'
LABEL_BRANCH_RENAME='Git · branch 이름 변경'
LABEL_COPY_BRANCH_NAME='Git · branch 이름 복사'
LABEL_COPY_COMMIT_MSG='Git · commit message 복사'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · tag'
LABEL_TAG_DELETE='Git · tag 삭제'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash'
LABEL_STASH_POP='Git · Stash Pop'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree ────'
LABEL_WT_REVIEW='Worktree · review'
LABEL_WT_TRY='Worktree · try'
LABEL_WT_FIX='Worktree · fix'
LABEL_WT_FEAT='Worktree · feat'
LABEL_WT_HOT='Worktree · hot'
LABEL_WT_RM_REVIEW='Worktree · review 제거'
LABEL_WT_RM_TRY='Worktree · try 제거'
LABEL_WT_RM_FIX='Worktree · fix 제거'
LABEL_WT_RM_FEAT='Worktree · feat 제거'
LABEL_WT_RM_HOT='Worktree · hot 제거'
