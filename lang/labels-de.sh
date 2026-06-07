#!/usr/bin/env bash
# Deutsche Labels für tasks.json Menüeinträge (kompakte Form).
# Geladen von sync-tasks.sh; in tasks.json an Platzhalter __LABEL_*__ ersetzt.
# EINFACHE Anführungszeichen — $ZED_GIT_SHA_SHORT muss für Zed literal bleiben.
#
# Designregel: Menü-Labels sind minimal — Verb + Kern-Nomen. Der Commit-Kontext
# ergibt sich implizit aus der rechtsgeklickten Zeile. Ausführliche Erklärungen
# stehen in show_intro jedes Skripts zur Laufzeit.
# shellcheck shell=bash disable=SC2034

# ── 1. Anzeigen ─────────────────────────────────────────────────
LABEL_SEP_VIEW='──── 1. Anzeigen ────'
LABEL_VIEW_BRANCHES_CONTAINING='Git · Branches mit commit'
LABEL_VIEW_TAGS_CONTAINING='Git · Tags mit commit'
LABEL_VIEW_STAT='Git · Stat'
LABEL_VIEW_DIFF='Git · Diff'
LABEL_VIEW_DIFF_HEAD='Git · Diff vs HEAD'
LABEL_VIEW_OPEN_FILES='Git · Dateien öffnen'
LABEL_VIEW_EXPORT_FILES='Git · Dateien exportieren'
LABEL_VIEW_EXPORT_PATCHES='Git · Patches exportieren'

# ── 2. Ändern ───────────────────────────────────────────────────
LABEL_SEP_MODIFY='──── 2. Ändern ────'
LABEL_MODIFY_REWORD='Git · Reword'
LABEL_MODIFY_EDIT_COMMIT='Git · Commit ändern'

# ── 3. Historie umschreiben ─────────────────────────────────────
LABEL_SEP_REWRITE='──── 3. Historie umschreiben ────'
LABEL_REWRITE_SQUASH='Git · Squash N'
LABEL_REWRITE_DROP='Git · Drop'
LABEL_REWRITE_INTERACTIVE='Git · Rebase -i'
LABEL_REWRITE_RESET_SOFT='Git · Reset soft'
LABEL_REWRITE_RESET_HARD='Git · Reset hard ⚠'

# ── 4. Fixup ────────────────────────────────────────────────────
LABEL_SEP_FIXUP='──── 4. Fixup ────'
LABEL_FIXUP_INTO_THIS='Git · Fixup in commit'
LABEL_FIXUP_INTO_ANCESTOR='Git · Fixup in Vorfahr'

# ── 5. Kopieren / Rückgängig ────────────────────────────────────
LABEL_SEP_COPY_UNDO='──── 5. Kopieren / Rückgängig ────'
LABEL_COPY_CHERRY_PICK='Git · Cherry-pick'
LABEL_COPY_REVERT='Git · Revert'

# ── 6. Branch ───────────────────────────────────────────────────
LABEL_SEP_BRANCH='──── 6. Branch ────'
LABEL_BRANCH_FROM='Git · Neuer branch'
LABEL_BRANCH_TRY='Git · Try-branch'
LABEL_BRANCH_REBASE_ONTO='Git · Rebase A auf B'
LABEL_BRANCH_DELETE='Git · Branch löschen'
LABEL_BRANCH_CHECKOUT='Git · Auf branch wechseln'
LABEL_BRANCH_RENAME='Git · Branch umbenennen'
LABEL_COPY_BRANCH_NAME='Git · Branch-Name kopieren'
LABEL_COPY_COMMIT_MSG='Git · Commit-Nachricht kopieren'

# ── 7. Tag ──────────────────────────────────────────────────────
LABEL_SEP_TAG='──── 7. Tag ────'
LABEL_TAG_CREATE='Git · Tag'
LABEL_TAG_DELETE='Git · Tag löschen'

# ── 8. Stash ────────────────────────────────────────────────────
LABEL_SEP_STASH='──── 8. Stash ────'
LABEL_STASH_PUSH='Git · Stash'
LABEL_STASH_POP='Git · Stash pop'

# ── 9. Worktree ─────────────────────────────────────────────────
LABEL_SEP_WORKTREE='──── 9. Worktree ────'
LABEL_WT_REVIEW='Worktree · review'
LABEL_WT_TRY='Worktree · try'
LABEL_WT_FIX='Worktree · fix'
LABEL_WT_FEAT='Worktree · feat'
LABEL_WT_HOT='Worktree · hot'
LABEL_WT_RM_REVIEW='Worktree · review entfernen'
LABEL_WT_RM_TRY='Worktree · try entfernen'
LABEL_WT_RM_FIX='Worktree · fix entfernen'
LABEL_WT_RM_FEAT='Worktree · feat entfernen'
LABEL_WT_RM_HOT='Worktree · hot entfernen'
