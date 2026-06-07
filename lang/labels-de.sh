#!/usr/bin/env bash
# Deutsche Labels für tasks.json Menüeinträge.
# Wird von sync-tasks.sh geladen; in tasks.json an Platzhalter __LABEL_*__ ersetzt.
# EINFACHE Anführungszeichen verwenden — $ZED_GIT_SHA_SHORT u. ä. müssen für Zed literal bleiben.
# shellcheck shell=bash disable=SC2034

# ── 1. Ansicht / Durchsuchen ────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Ansicht / Durchsuchen ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches mit diesem commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags mit diesem commit  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_STAT='Git · Stat dieses commits  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF='Git · Voll-diff dieses commits  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_DIFF_HEAD='Git · Vergleich mit HEAD  ($ZED_GIT_SHA_SHORT..HEAD)'
LABEL_VIEW_OPEN_FILES='Git · Alle berührten Dateien öffnen  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_FILES='Git · Datei-Snapshots aus diesem commit exportieren  ($ZED_GIT_SHA_SHORT)'
LABEL_VIEW_EXPORT_PATCHES='Git · N vorherige commits als patches exportieren  ($ZED_GIT_SHA_SHORT)'

# ── 2. Diesen commit bearbeiten ─────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Diesen commit bearbeiten ────'
LABEL_MODIFY_REWORD='Git · Nachricht dieses commits umschreiben  ($ZED_GIT_SHA_SHORT)'
LABEL_MODIFY_EDIT_COMMIT='Git · Commit bearbeiten (Nachricht + Dateien add/remove)  ($ZED_GIT_SHA_SHORT)'

# ── 3. History umschreiben (rebase) ─────────────────────────────
LABEL_SEP_REWRITE='──── 3. History umschreiben (rebase) ────'
LABEL_REWRITE_SQUASH='Git · N commits ab hier vorwärts squashen  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_DROP='Git · Diesen commit aus History entfernen  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_INTERACTIVE='Git · Interaktives rebase bis zu diesem commit  ($ZED_GIT_SHA_SHORT^)'
LABEL_REWRITE_RESET_SOFT='Git · Soft reset auf diesen commit (Änderungen → index)  ($ZED_GIT_SHA_SHORT)'
LABEL_REWRITE_RESET_HARD='Git · Hard reset auf diesen commit (DESTRUKTIV)  ($ZED_GIT_SHA_SHORT)'

# ── 4. Fixup (Änderungen in diesen commit einfließen) ───────────
LABEL_SEP_FIXUP='──── 4. Fixup (Änderungen in diesen commit einfließen) ────'
LABEL_FIXUP_INTO_THIS='Git · Working/staged-Änderungen in diesen commit (fixup+autosquash)  ($ZED_GIT_SHA_SHORT)'
LABEL_FIXUP_INTO_ANCESTOR='Git · Diesen commit in einen Vorfahren einfließen (commit→fixup)  ($ZED_GIT_SHA_SHORT)'

# ── 5. Kopieren / Rückgängig ────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Kopieren / Rückgängig ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick auf aktuellen branch  ($ZED_GIT_SHA_SHORT)'
LABEL_COPY_REVERT='Git · Diesen commit reverten  ($ZED_GIT_SHA_SHORT)'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Neuen branch ab diesem commit anlegen  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_TRY='Git · Ad-hoc try-branch ab diesem commit  ($ZED_GIT_SHA_SHORT)'
LABEL_BRANCH_REBASE_ONTO='Git · Branch A auf branch B rebasen (CLion-Stil)'
LABEL_BRANCH_DELETE='Git · Lokale branches an diesem commit löschen (optional auch remote)  ($ZED_GIT_SHA_SHORT)'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Diesen commit taggen  ($ZED_GIT_SHA_SHORT)'
LABEL_TAG_DELETE='Git · Tag löschen (lokal + optional remote)  ($ZED_GIT_SHA_SHORT)'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Aktuelle Änderungen stashen (benannt)'
LABEL_STASH_POP='Git · Jüngsten stash poppen'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree (diesen commit in neuem Verzeichnis auschecken) ────'
LABEL_WT_REVIEW='Worktree · review  (detached, nur lesen)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_TRY='Worktree · try     (Wegwerf-branch)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FIX='Worktree · fix     (Bugfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_FEAT='Worktree · feat    (neues Feature)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_HOT='Worktree · hot     (hotfix)  ($ZED_GIT_SHA_SHORT)'
LABEL_WT_RM_REVIEW='Worktree · remove  review  (Name zum Bestätigen einfügen)'
LABEL_WT_RM_TRY='Worktree · remove  try     (Name zum Bestätigen einfügen)'
LABEL_WT_RM_FIX='Worktree · remove  fix     (Name zum Bestätigen einfügen)'
LABEL_WT_RM_FEAT='Worktree · remove  feat    (Name zum Bestätigen einfügen)'
LABEL_WT_RM_HOT='Worktree · remove  hot     (Name zum Bestätigen einfügen)'
