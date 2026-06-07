#!/usr/bin/env bash
# Deutsche Nachrichten-Strings für git-command Skripte.
# Wird von lib.sh geladen; nicht direkt aufrufen.
# Namenskonvention: MSG_<SCRIPT>_<KEY>; Suffix _FMT für printf-Vorlagen.
# shellcheck shell=bash

# ── lib.sh (gemeinsame Interna) ─────────────────────────────────
MSG_LIB_IN_PROGRESS_FMT='Ein unfertiges %s läuft noch. Erst "%s" oder --continue ausführen.\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s fehlgeschlagen; führe automatisch git %s --abort aus (Workspace auf Stand vor der Operation zurückgesetzt).\n'
MSG_LIB_NOT_IN_REPO='Nicht innerhalb eines git-Repositories.'
MSG_LIB_NOT_BARE_LAYOUT='Aktuelles Projekt liegt nicht im bare + worktrees Layout vor; worktree-Menü deaktiviert.'
MSG_LIB_INIT_HINT='Zum Aktivieren ein neues Projekt anlegen mit: bash git-command/init-bare-tree.sh <name> [<url>]'
MSG_LIB_MIGRATE_HINT='Für bestehende Projekte: migrate-to-bare-tree.sh (noch nicht implementiert; bitte manuell migrieren).'
MSG_LIB_CLEANUP_FMT='Skript unerwartet beendet (Exit %d); führe automatisch git %s --abort aus, um zurückzurollen.\n'
MSG_LIB_PRESS_ENTER="── Enter zum Schließen ──"

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword (Nachricht dieses commits umschreiben)"
MSG_REWORD_PURPOSE="Was:   ändert nur die commit-Nachricht; Dateiinhalte und SHA-Kette bleiben unverändert (nachfolgende SHAs werden neu geschrieben)"
MSG_REWORD_WHEN="Wann:  Tippfehler korrigieren / Konvention einhalten / Issue-Referenz ergänzen / conventional-commit Präfix anpassen"
MSG_REWORD_CONTRAST="Hinweis: für die Nachricht von HEAD ist edit-commit schneller; reword ist für ältere commits gedacht"
MSG_REWORD_DIRTY_TREE="Arbeitsverzeichnis enthält uncommittete Änderungen; zuerst committen oder stashen."
MSG_REWORD_NOT_ANCESTOR_FMT='%s liegt nicht in der Vorfahrenkette des aktuellen branches; reword nicht möglich.\n'
MSG_REWORD_OLD_MSG="Alte Nachricht:"
MSG_REWORD_NEW_MSG_PROMPT="Neue Nachricht (zeilenweise; leer = Absatz; einzelnes 'Q' zum Absenden, ':q' zum Abbrechen):"
MSG_REWORD_CANCELLED="Abgebrochen."
MSG_REWORD_EMPTY_CANCELLED="Keine Eingabe; abgebrochen."

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files (jede von diesem commit berührte Datei in Zed öffnen)"
MSG_OPEN_FILES_PURPOSE="Was:   listet die von diesem commit geänderten Dateien auf und öffnet alle in Zed (aktuelle Arbeitsversion)"
MSG_OPEN_FILES_WHEN="Wann:  beim Debuggen eines historischen Bugs; jede an dieser Änderung beteiligte Datei sehen wollen"
MSG_OPEN_FILES_PREREQ="Voraussetzung: zed CLI im PATH; Dateien, die nicht im aktuellen tree liegen, werden übersprungen"
MSG_OPEN_FILES_EMPTY="Dieser commit hat keine Dateiänderungen (möglicherweise ein leerer commit)."
MSG_OPEN_FILES_MISSING="Die folgenden Dateien sind nicht mehr im Arbeitsverzeichnis (gelöscht/umbenannt), übersprungen:"
MSG_OPEN_FILES_ALL_GONE="Keine der von diesem commit berührten Dateien existiert noch im Arbeitsverzeichnis."
MSG_OPEN_FILES_OPENING_FMT='Öffne %d Dateien in Zed:\n'
MSG_OPEN_FILES_NO_ZED="zed-Befehl nicht gefunden."
MSG_OPEN_FILES_INSTALL_HINT="In Zed: Cmd+Shift+P → 'zed: install cli', um die zed CLI zu installieren."

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files (Dateien dieses commits in einen Ordner exportieren)"
MSG_EXPORT_FILES_PURPOSE="Was:   kopiert jede von diesem commit geänderte Datei (in der Version DIESES commits) in einen Ordner, mit Pfadstruktur"
MSG_EXPORT_FILES_WHEN="Wann:  zu viele Dateien für Tabs / Snapshot der Artefakte eines commits / offline-diff"
MSG_EXPORT_FILES_CONTRAST="Hinweis: open-files öffnet die aktuelle Arbeitsversion; dieser hier exportiert die historische Version dieses commits"
MSG_EXPORT_FILES_EMPTY="Dieser commit hat keine Dateiänderungen (möglicherweise ein leerer commit)."
MSG_EXPORT_FILES_COUNT_FMT='Dieser commit berührt %d Datei(en):\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... und %d weitere\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='Zielverzeichnis (relativ zum repo-Root, Standard %s): '
MSG_EXPORT_FILES_DIR_EXISTS_FMT='Verzeichnis existiert und ist nicht leer: %s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="Fortfahren könnte gleichnamige Dateien überschreiben. Weiter?"
MSG_EXPORT_FILES_DELETED_HINT="(in diesem commit gelöscht; nichts zu exportieren)"
MSG_EXPORT_FILES_DONE_FMT='Fertig: %d exportiert, %d übersprungen → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="Hinweis: Inhalte entsprechen dem Snapshot dieses commits, nicht der aktuellen Arbeitsversion."

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches (N patch-Dateien exportieren)"
MSG_EXPORT_PATCHES_PURPOSE="Was:   exportiert N commits rückwärts ab hier als mbox (.patch) oder reines diff (.diff)"
MSG_EXPORT_PATCHES_WHEN="Wann:  E-Mail-Zusammenarbeit / bestimmte Änderungen sichern / an andere für git am / git apply schicken"
MSG_EXPORT_PATCHES_OUTPUT="Ausgabe: gewähltes Verzeichnis (Standard ./patches); History wird niemals verändert"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="Format [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply) (Standard f): "
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='Ungültiges Format: %s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="Wie viele commits rückwärts (Standard 1): "
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='Ungültige Anzahl: %s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="Ausgabeverzeichnis (relativ zum repo-Root, Standard ./patches): "
MSG_EXPORT_PATCHES_FORMAT_LABEL="Format:"
MSG_EXPORT_PATCHES_RANGE_LABEL="Bereich:"
MSG_EXPORT_PATCHES_OUTPUT_LABEL="Ausgabe:"
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(root)"
MSG_EXPORT_PATCHES_CONTINUE="Weiter?"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft (soft reset auf diesen commit · Änderungen wandern ins staging)"
MSG_RESET_SOFT_PURPOSE="Was:   verschiebt HEAD auf diesen commit; Änderungen der dazwischenliegenden commits landen im index (nichts verloren)"
MSG_RESET_SOFT_WHEN="Wann:  die letzten N commits neu packen wollen (neu aufteilen / Nachricht ändern / zusammenführen)"
MSG_RESET_SOFT_AFTER="Danach: git status zur Prüfung des index, dann eine neue History committen"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s liegt nicht in der HEAD-Vorfahrenkette; soft reset ist sinnlos.\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s ist bereits HEAD; kein reset nötig.\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='Aktueller branch: %s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='Diese commits werden verworfen (ihre Änderungen wandern in den index, HEAD → %s):\n'
MSG_RESET_SOFT_CONFIRM_FMT='Soft reset auf %s?'
MSG_RESET_SOFT_DONE="Fertig. Änderungen liegen im index; mit git status prüfen, dann erneut committen."

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard (hard reset auf diesen commit · DESTRUKTIV)"
MSG_RESET_HARD_PURPOSE="Was:   verschiebt HEAD auf diesen commit; VERWIRFT dazwischenliegende commits UND alle Änderungen im Arbeitsverzeichnis"
MSG_RESET_HARD_WHEN="Wann:  vollständige Rückkehr zu einem Zustand und du bist sicher, alle Zwischenänderungen verlieren zu wollen"
MSG_RESET_HARD_AFTER="Danach: unwiderruflich (außer git reflog innerhalb 30 Tagen; Bestätigung mit YES in Großbuchstaben)"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s liegt nicht in der HEAD-Vorfahrenkette; verweigert.\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s ist bereits HEAD; kein reset nötig.\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='Aktueller branch: %s\n'
MSG_RESET_HARD_WILL_DROP="Diese commits werden verworfen (unwiderruflich außer über reflog):"
MSG_RESET_HARD_WT_LOST="Änderungen im Arbeitsverzeichnis werden ebenfalls verworfen:"
MSG_RESET_HARD_YES_PROMPT_FMT='Gib YES (Großbuchstaben) ein, um hard reset auf %s zu bestätigen: '
MSG_RESET_HARD_NO_YES="YES nicht eingegeben; abgebrochen."
MSG_RESET_HARD_REFLOG_HINT="Tipp: reflog kann diese commits noch wiederherstellen; innerhalb 30 Tagen git reflog → HEAD@{N} prüfen."

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i (interaktives rebase bis zu diesem commit)"
MSG_REBASE_I_PURPOSE='Was:   startet git rebase -i SHA^, öffnet $EDITOR für manuelle todo-Bearbeitung'
MSG_REBASE_I_WHEN="Wann:  mehrere commits manuell umordnen/zusammenführen/bearbeiten/verwerfen; komplexer als das Standardmenü"
MSG_REBASE_I_PREREQ="Voraussetzung: Arbeitsverzeichnis muss sauber sein; bei Konflikten manuell lösen oder auf EXIT-trap abort verlassen"
MSG_REBASE_I_RANGE_FMT='Interaktives rebase wird gestartet, Bereich: %s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="Arbeitsverzeichnis enthält uncommittete Änderungen; zuerst committen oder stashen."
MSG_REBASE_I_CONTINUE="Weiter?"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert (einen inversen commit anlegen, der diesen rückgängig macht)"
MSG_REVERT_PURPOSE="Was:   schreibt History nicht um; hängt einen neuen commit auf HEAD an, der die Änderungen dieses commits invertiert"
MSG_REVERT_WHEN="Wann:  ein bereits gepushter commit muss rückgängig gemacht werden (reset würde öffentliche History umschreiben)"
MSG_REVERT_CONTRAST="Hinweis: reset schreibt History um; revert hängt an. Bricht bei Konflikten automatisch ab."
MSG_REVERT_DIRTY_TREE="Arbeitsverzeichnis enthält uncommittete Änderungen; zuerst committen oder stashen."
MSG_REVERT_CONFIRM_FMT='Inversen commit auf HEAD anlegen, um %s rückgängig zu machen?\n'

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick (diesen commit auf die Spitze des aktuellen branches kopieren)"
MSG_CHERRY_PICK_PURPOSE="Was:   kopiert die Änderungen dieses commits als neuen commit (neue SHA) auf die Spitze des aktuellen branches"
MSG_CHERRY_PICK_WHEN="Wann:  hotfix über branches hinweg übertragen / einzelnen commit eines Kollegen übernehmen / via reflog retten"
MSG_CHERRY_PICK_NOTE="Hinweis: Quell-commit wird nicht gelöscht; gleicher branch ist sinnlos; bricht bei Konflikten automatisch ab"
MSG_CHERRY_PICK_CURRENT_FMT='Aktueller branch: %s\n'
MSG_CHERRY_PICK_DIRTY_TREE="Arbeitsverzeichnis enthält uncommittete Änderungen; zuerst committen oder stashen."
MSG_CHERRY_PICK_CONFIRM_FMT='Cherry-pick %s auf %s?'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from (neuen branch ab diesem commit anlegen)"
MSG_BRANCH_FROM_PURPOSE="Was:   legt einen neuen branch an diesem commit an und wechselt zu ihm"
MSG_BRANCH_FROM_WHEN="Wann:  eine neue Arbeitslinie ab einem alten commit beginnen / einen benannten ref auf einen bestimmten Zustand halten"
MSG_BRANCH_FROM_CONTRAST="Hinweis: für Wegwerf-Experimente try-branch nutzen (automatischer try/-Präfix + Aufräum-Hinweis)"
MSG_BRANCH_FROM_NAME_PROMPT="Name des neuen branches (basierend auf diesem commit): "
MSG_BRANCH_FROM_NO_NAME="Kein branch-Name angegeben; abgebrochen."

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch (Wegwerf-branch ab diesem commit)"
MSG_TRY_BRANCH_PURPOSE="Was:   legt einen branch namens try/<basis-slug>-<sha> ab diesem commit an und wechselt sofort dorthin"
MSG_TRY_BRANCH_WHEN="Wann:  experimentieren ohne den aktuellen branch zu verschmutzen / den Zustand eines alten commits inspizieren"
MSG_TRY_BRANCH_HINT="Tipp:  beim Beenden werden 'zurück zum Original' + 'diesen branch löschen' Befehle als Erinnerung ausgegeben"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # war detached; reflog konsultieren"
MSG_TRY_BRANCH_FROM_FMT='Ursprünglicher branch: %s\nStartpunkt:            %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='Name des neuen branches (Enter = %s): '
MSG_TRY_BRANCH_EXISTS_FMT='Branch existiert bereits: %s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="Nach dem Anlegen dorthin wechseln? [Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='%s angelegt (kein Wechsel)\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="Wenn fertig, aufräumen mit:"
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  zurück zum Original: %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  diesen branch löschen: git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push (aktuelle Änderungen mit Namen stashen)"
MSG_STASH_PUSH_PURPOSE="Was:   stasht getrackte Änderungen mit einem Label, lässt das Arbeitsverzeichnis sauber zurück"
MSG_STASH_PUSH_WHEN="Wann:  vor branch-Wechsel mit WIP / Arbeit kurz beiseitelegen / vor reset aufräumen"
MSG_STASH_PUSH_NOTE="Hinweis: -u wird NICHT verwendet; ungetrackte Dateien bleiben im Arbeitsverzeichnis (vermeidet überflüssige Git Graph Snapshot-Knoten)"
MSG_STASH_PUSH_CLEAN="Arbeitsverzeichnis ist sauber; nichts zu stashen."
MSG_STASH_PUSH_WILL_STASH="Folgende Änderungen werden gestasht:"
MSG_STASH_PUSH_NAME_PROMPT="Wähle einen Namen (hilft beim späteren Wiederfinden): "
MSG_STASH_PUSH_NO_NAME="Kein Name angegeben; abgebrochen."
MSG_STASH_PUSH_DONE_HINT="Fertig. Anzeigen: git stash list, oder Menüeintrag 'Pop most recent stash' nutzen."
MSG_STASH_PUSH_UNTRACKED_NOTE="Hinweis: ungetrackte Dateien wurden NICHT gestasht und verbleiben im Arbeitsverzeichnis."

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop (jüngsten stash auf das Arbeitsverzeichnis anwenden)"
MSG_STASH_POP_PURPOSE="Was:   wendet stash@{0} auf das Arbeitsverzeichnis an; bei Erfolg wird der stash automatisch verworfen"
MSG_STASH_POP_WHEN="Wann:  zuvor gestashte Änderungen sollen zurückkommen"
MSG_STASH_POP_NOTE="Hinweis: bei Konflikten wird der stash NICHT automatisch verworfen; Konflikte lösen, dann git stash drop ausführen"
MSG_STASH_POP_EMPTY="Kein stash zum Poppen vorhanden."
MSG_STASH_POP_LIST_HEADER="Letzte stashes:"
MSG_STASH_POP_PREVIEW_HEADER="stash@{0} Vorschau:"
MSG_STASH_POP_CONFIRM="stash@{0} in das aktuelle Arbeitsverzeichnis poppen?"
MSG_STASH_POP_CONFLICT="Pop hat Konflikte ausgelöst — der stash bleibt erhalten (nicht automatisch verworfen)."
MSG_STASH_POP_CONFLICT_HINT="Konflikte lösen + git add, dann  git stash drop  ausführen, um ihn zu verwerfen."

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete (lokale branches, die auf diesen commit zeigen, löschen)"
MSG_BRANCH_DELETE_PURPOSE="Was:   löscht einen lokalen branch (optional auch den remote)"
MSG_BRANCH_DELETE_WHEN="Wann:  gemergte/Wegwerf-branches aufräumen; try/* feat/* etc. in einem Rutsch löschen"
MSG_BRANCH_DELETE_NOTE="Hinweis: nutzt git branch -D (force delete; ignoriert merged-Status)"
MSG_BRANCH_DELETE_NONE="Keine lokalen branches an diesem commit zum Löschen."
MSG_BRANCH_DELETE_ONE_FMT='Einziger branch an diesem commit: %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="Lokale branches an diesem commit:"
MSG_BRANCH_DELETE_SELECT_PROMPT="Wähle einen (branch-Name oder Nummer): "
MSG_BRANCH_DELETE_NO_INPUT="Keine Eingabe; abgebrochen."
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="Branch '%s' ist nicht in der Liste der branches an diesem commit.\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="Der aktuell ausgecheckte branch '%s' kann nicht gelöscht werden.\n"
MSG_BRANCH_DELETE_CURRENT_HINT="Zuerst auf einen anderen branch wechseln: git switch <anderer-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="Lokalen branch '%s' löschen?"
MSG_BRANCH_DELETE_LOCAL_DONE="Lokaler branch gelöscht."
MSG_BRANCH_DELETE_NO_REMOTE="(kein remote konfiguriert; remote-Schritt übersprungen)"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="(branch nicht auf remote [%s] vorhanden; übersprungen)"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="Auch auf remote [%s] löschen? [y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="Remote-branch gelöscht."

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit (Metadaten / Dateiliste dieses commits bearbeiten)"
MSG_EDIT_COMMIT_HEAD_PATH="HEAD-Pfad:  Arbeitsverzeichnis darf dirty sein; direktes amend; Nachricht ändern / Dateien hinzufügen / entfernen / ändern"
MSG_EDIT_COMMIT_OLD_PATH="Alter commit: Arbeitsverzeichnis muss sauber sein; unterstützt Nachricht / Hinzufügen (ungetrackt) / Entfernen von Dateien"
MSG_EDIT_COMMIT_NOT_SUITED="Nicht geeignet (alter commit): Inhalt bestehender Dateien ändern → das fixup-Menü nutzen (Begründung im Header-Kommentar)"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="Eine Operation pro Zeile, abschließen mit einem alleinstehenden 'Q':"
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:pfad/zur/datei  git add (hinzufügen / aktualisieren / Änderung stagen)"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:pfad/zur/datei  aus diesem commit entfernen (auf Disk erhalten, git rm --cached)"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                 fertig"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  überspringe Formatfehler: %s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  überspringe +%s  (Datei existiert nicht)\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  add  %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  überspringe +%s  (git add fehlgeschlagen)\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  rm   %s  (aus commit entfernt, auf Disk behalten)\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  überspringe -%s  (nicht in diesem commit)\n'
MSG_EDIT_COMMIT_ASK_MSG="Neue Nachricht (zeilenweise; einzelnes 'Q' zum Absenden; nur Q = unverändert lassen):"
MSG_EDIT_COMMIT_HEAD_HEADER="─── HEAD-Schnellpfad ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="Ziel ist HEAD, kein rebase nötig:"
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · Arbeitsverzeichnis darf dirty sein (Änderungen werden zu amend-Kandidaten)"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · Dateien beliebig hinzufügen / ändern / entfernen; kein Risiko für nachfolgende Konflikte"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── aktuelle Nachricht ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── aktuelle Änderungen (working/staged) ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="Nachricht ändern? [y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="Dateien ändern (hinzufügen/entfernen/modifizieren)? [y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="(keine Änderungen; kein amend; Ende.)"
MSG_EDIT_COMMIT_UNSTAGED_HINT="Hinweis: Arbeitsverzeichnis hat noch unstaged-Änderungen; amend wird sie NICHT einbeziehen."
MSG_EDIT_COMMIT_AMEND_MSG_FILES="Amended (neue Nachricht + Dateiänderungen)"
MSG_EDIT_COMMIT_AMEND_MSG="Amended (neue Nachricht)"
MSG_EDIT_COMMIT_AMEND_FILES="Amended (Dateiänderungen)"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='Arbeitsverzeichnis enthält uncommittete Änderungen.

Wenn du diese Änderungen in den commit einfließen lassen willst → nimm das Menü:
  "Fold working/staged changes into this commit (fixup+autosquash)"

Wenn du wirklich dieses Menü brauchst (Nachricht ändern / neue Dateien hinzufügen / Dateien entfernen), zuerst committen oder stashen.'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s liegt nicht in der Vorfahrenkette des aktuellen branches.\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── Pfad für alten commit (rebase) ───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="Gilt für: Nachricht / neue Dateien hinzufügen (ungetrackt) / Dateien entfernen"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="Gilt NICHT für: Ändern von Inhalten bestehender Dateien (das fixup-Menü nutzen)"
MSG_EDIT_COMMIT_OLD_CONTINUE="Weiter?"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="rebase ist nicht in den edit-Zustand übergegangen."
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── aktuelle commit-Nachricht ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="Nachricht ändern? [y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="Dateien ändern (hinzufügen/entfernen)? [y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="(keine Änderungen; schließe ab)"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue fehlgeschlagen (vermutlich ein nachgelagerter modify/delete-Konflikt mit einer gerade entfernten Datei)."
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase abgeschlossen"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n (N commits ab diesem commit vorwärts squashen)"
MSG_SQUASH_PURPOSE="Was:   squashed diesen commit und N-1 Vorfahren zu einem; nachfolgende commits werden darauf abgespielt"
MSG_SQUASH_WHEN="Wann:  WIP-commits aufräumen / Rauschen verdichten / mehrere kleine zusammengehörige commits zusammenführen"
MSG_SQUASH_PREREQ="Voraussetzung: Arbeitsverzeichnis muss sauber sein; nachfolgende SHAs ändern sich; bricht bei Konflikten automatisch ab"
MSG_SQUASH_DIRTY_TREE="Arbeitsverzeichnis enthält uncommittete Änderungen; zuerst committen oder stashen."
MSG_SQUASH_COUNT_PROMPT="Wie viele squashen (inklusive diesem commit, Standard 2): "
MSG_SQUASH_MIN_TWO="Mindestens 2 commits nötig, damit squash Sinn ergibt."
MSG_SQUASH_TOO_MANY_FMT='Dieser commit hat nur %d Vorfahr(en) inkl. sich selbst; maximal %d.\n'
MSG_SQUASH_PREVIEW_FMT='Diese %d commit(s) werden gesquasht (alt → neu):\n'
MSG_SQUASH_MSG_PROMPT="Neue commit-Nachricht (zeilenweise; einzelnes Q zum Absenden; nur Q = Editor mit Standard-Verkettung öffnen; :q zum Abbrechen):"
MSG_SQUASH_CANCELLED="Abgebrochen."
MSG_SQUASH_CONTINUE="Weiter?"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit (diesen commit aus der History löschen)"
MSG_DROP_PURPOSE="Was:   entfernt diesen commit aus der branch-History; nachfolgende commits werden neu abgespielt (neue SHAs)"
MSG_DROP_WHEN="Wann:  versehentlicher commit (Passwörter / Debug-Code) / sinnloses WIP / Duplikat / Experiment zum Löschen"
MSG_DROP_CONTRAST="Hinweis: revert fügt einen inversen commit hinzu (behält History); drop entfernt wirklich (schreibt History um)"
MSG_DROP_DIRTY_TREE="Arbeitsverzeichnis enthält uncommittete Änderungen; zuerst committen oder stashen."
MSG_DROP_NOT_ANCESTOR_FMT='%s liegt nicht in der Vorfahrenkette des aktuellen branches.\n'
MSG_DROP_ROOT_COMMIT_FMT='%s ist der root-commit, hat keinen parent; rebase kann ihn nicht entfernen.\n'
MSG_DROP_ROOT_HINT="Den root-commit wirklich zu entfernen erfordert git update-ref etc.; manuell durchführen."
MSG_DROP_WILL_REMOVE="Wird entfernt:"
MSG_DROP_DOWNSTREAM_FMT='%d nachfolgende commit(s) werden neu abgespielt (SHAs ändern sich):\n'
MSG_DROP_DOWNSTREAM_HINT="  (wenn nachfolgende Änderungen von diesem commit abhängen → automatischer abort bei Konflikt)"
MSG_DROP_IS_HEAD_NOTE="(dieser commit ist HEAD → Schnellpfad via git reset --hard HEAD~; kein rebase)"
MSG_DROP_CONFIRM="Entfernen bestätigen?"
MSG_DROP_DONE_HEAD="Fertig. HEAD auf den vorherigen commit verschoben."
MSG_DROP_DONE_REBASE="Fertig. Der commit wurde aus der History entfernt."

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup (Änderungen im Arbeitsverzeichnis in diesen commit einfließen lassen)"
MSG_FIXUP_PURPOSE="Was:   legt einen fixup-commit + autosquash an und führt Änderungen im Arbeitsverzeichnis in diesen commit ein"
MSG_FIXUP_WHEN="Wann:  du hast Dateien bearbeitet und willst sie in einen alten commit aufnehmen (sehr häufig); History sauber halten"
MSG_FIXUP_PREREQ="Voraussetzung: working / staging tree muss Änderungen enthalten; bricht bei Konflikten automatisch ab"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s liegt nicht in der Vorfahrenkette des aktuellen branches.\n'
MSG_FIXUP_NO_CHANGES="Arbeitsverzeichnis ist sauber; nichts einzufügen."
MSG_FIXUP_WORKFLOW_HINT="Workflow: Dateien bearbeiten → dieses Menü nutzen → Ziel-commit wählen → automatisches fixup + autosquash."
MSG_FIXUP_WILL_FOLD="Änderungen, die in diesen commit einfließen:"
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="Index enthält bereits Inhalt; auch unstaged-Änderungen einbeziehen? [y/N] "
MSG_FIXUP_ASK_ADD_ALL="Index ist leer; alles per git add -A stagen und dann fixup? [Y/n] "
MSG_FIXUP_EMPTY_INDEX="Index ist leer; nichts zum fixup; abgebrochen."
MSG_FIXUP_TARGET_FMT='Ziel: %s  "%s"\n'
MSG_FIXUP_CONFIRM="fixup + autosquash bestätigen? [Y/n] "
MSG_FIXUP_CANCELLED="Abgebrochen; index-Zustand erhalten."
MSG_FIXUP_CREATED="  + fixup-commit angelegt"
MSG_FIXUP_DONE_FMT='Fertig. Änderungen in %s eingeflossen (SHA nach autosquash aktualisiert).\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup (diesen commit in einen Vorfahren einfließen lassen)"
MSG_CFIX_PURPOSE="Was:   nimmt diesen commit und wendet ihn als fixup auf einen früheren commit im selben branch an"
MSG_CFIX_WHEN="Wann:  ein Fix auf HEAD gehört eigentlich zu einem früheren commit; wieder dorthin verschieben"
MSG_CFIX_CONTRAST="Hinweis: fixup.sh nutzt Änderungen im Arbeitsverzeichnis; dieses Menü nutzt einen bestehenden commit"
MSG_CFIX_DIRTY_TREE="Arbeitsverzeichnis enthält uncommittete Änderungen; zuerst committen oder stashen."
MSG_CFIX_NOT_ANCESTOR_SRC="Quell-commit liegt nicht in der Vorfahrenkette des aktuellen branches."
MSG_CFIX_HEADER="Diesen commit (fixup) in einen anderen commit einfließen lassen."
MSG_CFIX_TARGET_HINT="Ziel muss ein Vorfahre der Quelle sein (früher in der History). Tipp: SHA des Ziels aus dem Zed Graph kopieren."
MSG_CFIX_TARGET_PROMPT="SHA des Ziel-commits (kurz oder lang): "
MSG_CFIX_NO_INPUT="Keine Eingabe; abgebrochen."
MSG_CFIX_INVALID_SHA_FMT='Ungültige SHA: %s\n'
MSG_CFIX_SAME_COMMIT="Ziel und Quelle sind identisch; sinnlos."
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s ist kein Vorfahre des Quell-commits (fixup darauf nicht möglich).\n'
MSG_CFIX_PREVIEW="─── Vorschau ───"
MSG_CFIX_SOURCE_LABEL="Quelle:"
MSG_CFIX_TARGET_LABEL="Ziel:"
MSG_CFIX_RANGE_LABEL="rebase-Bereich (alt → neu):"
MSG_CFIX_CONTINUE="Weiter?"
MSG_CFIX_DONE="Fertig. Quelle in Ziel eingeflossen (SHA des Ziel-commits aktualisiert)."

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto (branch A auf branch B rebasen)"
MSG_RBO_PURPOSE="Was:   git switch A && git rebase B; A's exklusive commits werden auf die Spitze von B abgespielt"
MSG_RBO_WHEN="Wann:  A ist ein feature-branch, B ist main/develop; A auf den neuesten Stand von B bringen"
MSG_RBO_NOTE="Hinweis: A's commits werden neu geschrieben (neue SHAs); bricht bei Konflikten automatisch ab"
MSG_RBO_DIRTY_TREE="Arbeitsverzeichnis enthält uncommittete Änderungen; zuerst committen oder stashen."
MSG_RBO_LOCAL_BRANCHES="Lokale branches:"
MSG_RBO_A_PROMPT_FMT='Branch A (zu rebasen; Enter = aktueller %s): '
MSG_RBO_DETACHED_ERR="Aktuell auf detached HEAD; branch A muss explizit angegeben werden."
MSG_RBO_NO_LOCAL_FMT='Kein lokaler branch namens: %s\n'
MSG_RBO_B_PROMPT="Branch B (rebase-Ziel; local / remote / tag): "
MSG_RBO_NO_INPUT="Keine Eingabe; abgebrochen."
MSG_RBO_INVALID_REF_FMT='Ungültiger Ziel-ref: %s\n'
MSG_RBO_SAME="A und B zeigen auf denselben commit; nichts zu rebasen."
MSG_RBO_PREVIEW="─── Vorschau ───"
MSG_RBO_NO_EXCLUSIVE="A hat keine commits über B hinaus (A ist ein Vorfahre von B oder identisch)."
MSG_RBO_FF_OR_NOOP="rebase wird ein fast-forward oder ein no-op sein."
MSG_RBO_REPLAY_FMT='Abzuspielende commits von A (%d):\n'
MSG_RBO_CONFIRM_FMT='Ausführen: git switch %s && git rebase %s ?'
MSG_RBO_SWITCHING_FMT='Wechsle zu %s...\n'
MSG_RBO_DONE="Fertig."

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag (diesen commit taggen)"
MSG_TAG_PURPOSE="Was:   legt einen lightweight- oder annotated-tag auf diesen commit; optional zum remote pushen"
MSG_TAG_WHEN="Wann:  Release-Punkt / Meilenstein / stabile benannte Referenz auf einen commit"
MSG_TAG_CONTRAST="Hinweis: annotated trägt Nachricht+Autor+Zeit (empfohlen für Releases); lightweight ist nur ein ref"
MSG_TAG_NAME_PROMPT="Tag-Name (z. B. v1.0.0 / release-2024-01): "
MSG_TAG_NO_INPUT="Keine Eingabe; abgebrochen."
MSG_TAG_EXISTS_FMT='Tag existiert bereits: %s\n'
MSG_TAG_KIND_PROMPT="annotated (mit Nachricht) oder lightweight? [a]/l (Standard a): "
MSG_TAG_MSG_PROMPT="Tag-Nachricht (Enter = Tag-Name verwenden): "
MSG_TAG_CREATED_FMT='Tag angelegt: %s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='Zum remote [%s] pushen? [y/N] '
MSG_TAG_NO_REMOTE="(kein remote konfiguriert; push übersprungen)"
MSG_TAG_REFRESH_HINT="Hinweis: Zed Git Graph beobachtet tag-Änderungen nicht; manuell aktualisieren (Cmd+Shift+P → reload window, oder bis zum nächsten commit warten)."

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete (einen tag löschen)"
MSG_TAG_DELETE_PURPOSE="Was:   löscht einen lokalen tag; optional auch auf dem remote"
MSG_TAG_DELETE_WHEN="Wann:  fehlerhafter tag / Neu-Release / Aufräumen"
MSG_TAG_DELETE_NOTE="Hinweis: einen gepushten remote-tag zu löschen betrifft andere; lokal + remote werden separat abgefragt"
MSG_TAG_DELETE_AT_HEADER="Tags an diesem commit:"
MSG_TAG_DELETE_NONE="  (keine)"
MSG_TAG_DELETE_NAME_PROMPT="Zu löschender Tag-Name (kann an einem anderen commit liegen): "
MSG_TAG_DELETE_NO_INPUT="Keine Eingabe; abgebrochen."
MSG_TAG_DELETE_NOT_EXIST_FMT='Tag existiert nicht: %s\n'
MSG_TAG_DELETE_ANNOTATED="(annotated tag)"
MSG_TAG_DELETE_PREVIEW_FMT="tag '%s' → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="Lokalen tag '%s' löschen?"
MSG_TAG_DELETE_LOCAL_DONE="Lokaler tag gelöscht."
MSG_TAG_DELETE_NO_REMOTE="(kein remote konfiguriert; remote-Schritt übersprungen)"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="(kein solcher tag auf remote [%s]; übersprungen)\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="Auch auf remote [%s] löschen? [y/N] "
MSG_TAG_DELETE_REMOTE_DONE="Remote-tag gelöscht."

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="Was:   checkt diesen commit in einem neuen worktree aus, nach Zweck gruppiert"
MSG_WT_FROM_NOTE_FMT='Zweck: %s'
MSG_WT_FROM_PATH_EXISTS_FMT='Pfad existiert bereits: %s\n'
MSG_WT_FROM_PATH_HINT="Tipp: mit  git worktree list  bestehende worktrees inspizieren"
MSG_WT_FROM_BRANCH_EXISTS_FMT='Branch existiert bereits: %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree angelegt: %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  branch: %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  Aufräumen: git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  Aufräumen: git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='Branch-Name (Enter = %s): '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="Was:   listet worktrees unter [%s] auf und lässt den Nutzer einen Namen zum Löschen einfügen"
MSG_WT_RM_USAGE_FMT="Wie:   Liste prüfen, Namen einfügen (inkl. Präfix %s/), dann bestätigen"
MSG_WT_RM_EMPTY_FMT='[%s] hat keinen worktree zum Entfernen.\n'
MSG_WT_RM_LIST_HEADER_FMT='[%s] worktrees:\n'
MSG_WT_RM_NAME_PROMPT="Worktree-Namen zum Löschen einfügen (komplette Zeile von oben kopieren): "
MSG_WT_RM_NO_INPUT="Keine Eingabe; abgebrochen."
MSG_WT_RM_NOT_IN_LIST_FMT="'%s' ist nicht in der [%s]-worktree-Liste.\n"
MSG_WT_RM_REMOVING_FMT='Entferne: %s\n'
MSG_WT_RM_DONE="✓ worktree entfernt."
MSG_WT_RM_REVIEW_NO_BRANCH="(review ist detached; kein branch zum Aufräumen)"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="Auch lokalen branch '%s' löschen? [y/N] "
MSG_WT_RM_BRANCH_DONE="✓ Lokaler branch gelöscht."
MSG_WT_RM_BRANCH_ABSENT_FMT="(branch '%s' existiert nicht; möglicherweise bereits von git worktree remove entfernt)\n"

# ── branch-checkout.sh ──────────────────────────────────────────
MSG_BRANCH_CHECKOUT_TITLE="branch-checkout (auf einen branch wechseln, der auf diesen commit zeigt)"
MSG_BRANCH_CHECKOUT_PURPOSE="Was:   schaltet HEAD auf einen lokalen branch um, der auf diesen commit zeigt"
MSG_BRANCH_CHECKOUT_WHEN="Wann:  aus dem Git Graph auf einen bestehenden branch wechseln, statt seinen Namen ins Terminal zu kopieren"
MSG_BRANCH_CHECKOUT_NOTE="Hinweis: erfordert sauberes Arbeitsverzeichnis; wechselt nicht, wenn du bereits auf dem gewählten branch bist"
MSG_BRANCH_CHECKOUT_DIRTY_TREE="Arbeitsverzeichnis enthält uncommittete Änderungen; zuerst committen oder stashen."
MSG_BRANCH_CHECKOUT_NONE="Kein lokaler branch zeigt auf diesen commit."
MSG_BRANCH_CHECKOUT_ONE_FMT='Einziger branch an diesem commit: %s\n'
MSG_BRANCH_CHECKOUT_LIST_HEADER="Lokale branches an diesem commit:"
MSG_BRANCH_CHECKOUT_SELECT_PROMPT="Einen wählen (Branch-Name oder Nummer): "
MSG_BRANCH_CHECKOUT_NO_INPUT="Keine Eingabe; abgebrochen."
MSG_BRANCH_CHECKOUT_NOT_IN_LIST_FMT="Branch '%s' ist nicht in der Liste der branches an diesem commit.\n"
MSG_BRANCH_CHECKOUT_ALREADY_FMT='Du bist bereits auf %s; nichts zu tun.\n'

# ── branch-rename.sh ────────────────────────────────────────────
MSG_BRANCH_RENAME_TITLE="branch-rename (einen branch umbenennen, der auf diesen commit zeigt)"
MSG_BRANCH_RENAME_PURPOSE="Was:   benennt einen lokalen branch um; optional remote nachziehen (alten Namen löschen, neuen pushen)"
MSG_BRANCH_RENAME_WHEN="Wann:  Tippfehler beheben / try/* umwidmen / Namen standardisieren"
MSG_BRANCH_RENAME_NOTE="Hinweis: remote rename sind zwei Operationen (neu pushen + alt löschen); mit Mitarbeitern abstimmen"
MSG_BRANCH_RENAME_NONE="Kein lokaler branch zeigt auf diesen commit zum Umbenennen."
MSG_BRANCH_RENAME_ONE_FMT='Einziger branch an diesem commit: %s\n'
MSG_BRANCH_RENAME_LIST_HEADER="Lokale branches an diesem commit:"
MSG_BRANCH_RENAME_SELECT_PROMPT="Einen zum Umbenennen wählen (Branch-Name oder Nummer): "
MSG_BRANCH_RENAME_NO_INPUT="Keine Eingabe; abgebrochen."
MSG_BRANCH_RENAME_NOT_IN_LIST_FMT="Branch '%s' ist nicht in der Liste der branches an diesem commit.\n"
MSG_BRANCH_RENAME_NEW_NAME_PROMPT="Neuer Name: "
MSG_BRANCH_RENAME_INVALID_NAME_FMT="Ungültiger Branch-Name: %s\n"
MSG_BRANCH_RENAME_EXISTS_FMT="Branch existiert bereits: %s\n"
MSG_BRANCH_RENAME_DONE_FMT="Umbenannt: %s → %s\n"
MSG_BRANCH_RENAME_REMOTE_PROMPT_FMT="Auch auf remote [%s] umbenennen (neu pushen + alt löschen)? [y/N] "
MSG_BRANCH_RENAME_REMOTE_DONE="Remote-Umbenennung abgeschlossen."

# ── copy-branch-name.sh ─────────────────────────────────────────
MSG_COPY_BRANCH_TITLE="copy-branch-name (Branch-Name an diesem commit in die Zwischenablage kopieren)"
MSG_COPY_BRANCH_PURPOSE="Was:   legt einen Branch-Namen in die System-Zwischenablage zum Einfügen anderswo"
MSG_COPY_BRANCH_WHEN="Wann:  den Namen im Chat verschicken / in eine PR-Beschreibung einfügen / in einem anderen Terminal nutzen"
MSG_COPY_BRANCH_NOTE="Hinweis: nutzt pbcopy (macOS) / wl-copy / xclip / xsel — was verfügbar ist"
MSG_COPY_BRANCH_NONE="Kein lokaler branch an diesem commit zum Kopieren."
MSG_COPY_BRANCH_LIST_HEADER="Lokale branches an diesem commit:"
MSG_COPY_BRANCH_SELECT_PROMPT="Einen wählen (Branch-Name oder Nummer): "
MSG_COPY_BRANCH_NO_INPUT="Keine Eingabe; abgebrochen."
MSG_COPY_BRANCH_NOT_IN_LIST_FMT="Branch '%s' ist nicht in der Liste der branches an diesem commit.\n"
MSG_COPY_BRANCH_DONE_FMT="Kopiert: %s\n"
MSG_COPY_BRANCH_NO_CLIPBOARD="Kein Clipboard-Tool gefunden (benötigt pbcopy / wl-copy / xclip / xsel). Branch-Name unten ausgegeben:"

# ── copy-commit-message.sh ──────────────────────────────────────
MSG_COPY_MSG_TITLE="copy-commit-message (commit-message dieses commits in die Zwischenablage kopieren)"
MSG_COPY_MSG_PURPOSE="Was:   legt den Betreff (einzeilig) oder die vollständige commit-message in die System-Zwischenablage"
MSG_COPY_MSG_WHEN="Wann:  in Release Notes / PR / Chat / E-Mail einfügen"
MSG_COPY_MSG_NOTE="Hinweis: nutzt pbcopy (macOS) / wl-copy / xclip / xsel — was verfügbar ist"
MSG_COPY_MSG_KIND_PROMPT="Kopieren: [s] Betreff (Standard) / [f] vollständige message: "
MSG_COPY_MSG_KIND_INVALID_FMT="Ungültige Auswahl: %s\n"
MSG_COPY_MSG_DONE_FMT='Kopiert: %s\n'
MSG_COPY_MSG_NO_CLIPBOARD="Kein Clipboard-Tool gefunden (benötigt pbcopy / wl-copy / xclip / xsel). message unten ausgegeben:"
