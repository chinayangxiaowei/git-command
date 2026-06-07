#!/usr/bin/env bash
# Chaînes de messages en français for git-command scripts.
# Loaded by lib.sh; do not invoke directly.
# Convention de nommage : MSG_<SCRIPT>_<KEY> ; suffixe _FMT pour les templates printf.
# shellcheck shell=bash

# ── lib.sh (internes partagés) ──────────────────────────────────
MSG_LIB_IN_PROGRESS_FMT='Un %s inachevé est en cours. Lance d’abord "%s" ou --continue.\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s a échoué ; exécution automatique de git %s --abort (espace de travail restauré à l’état pré-opération).\n'
MSG_LIB_NOT_IN_REPO='Pas dans un dépôt git.'
MSG_LIB_NOT_BARE_LAYOUT='Le projet courant n’est pas en disposition bare + worktrees ; menu worktree désactivé.'
MSG_LIB_INIT_HINT='Pour activer, crée un nouveau projet avec : bash git-command/init-bare-tree.sh <name> [<url>]'
MSG_LIB_MIGRATE_HINT='Pour les projets existants : migrate-to-bare-tree.sh (pas encore implémenté ; migre manuellement).'
MSG_LIB_CLEANUP_FMT='Le script s’est terminé de façon inattendue (exit %d) ; exécution automatique de git %s --abort pour revenir en arrière.\n'

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword (réécrire le message de ce commit)"
MSG_REWORD_PURPOSE="Quoi : modifie uniquement le message du commit ; le contenu des fichiers et la chaîne SHA restent identiques (les SHA en aval seront réécrits)"
MSG_REWORD_WHEN="Quand : corriger une faute / se conformer à la convention / ajouter une réf d’issue / ajuster le préfixe conventional-commit"
MSG_REWORD_CONTRAST="Note : pour le message de HEAD, edit-commit est plus rapide ; reword sert aux commits plus anciens"
MSG_REWORD_DIRTY_TREE="L’arbre de travail a des modifications non commitées ; commit ou stash d’abord."
MSG_REWORD_NOT_ANCESTOR_FMT='%s n’est pas dans la chaîne d’ancêtres de la branche courante ; reword impossible.\n'
MSG_REWORD_OLD_MSG="Ancien message :"
MSG_REWORD_NEW_MSG_PROMPT="Nouveau message (une ligne à la fois ; vide = saut de paragraphe ; ’Q’ seul pour valider, ’:q’ pour annuler) :"
MSG_REWORD_CANCELLED="Annulé."
MSG_REWORD_EMPTY_CANCELLED="Aucune saisie ; annulé."

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files (ouvrir dans Zed tous les fichiers touchés par ce commit)"
MSG_OPEN_FILES_PURPOSE="Quoi : liste les fichiers modifiés par ce commit et les ouvre tous dans Zed (version de travail actuelle)"
MSG_OPEN_FILES_WHEN="Quand : déboguer un bug historique ; voir tous les fichiers impliqués dans ce changement"
MSG_OPEN_FILES_PREREQ="Requis : zed CLI dans le PATH ; les fichiers absents de l’arbre courant sont ignorés"
MSG_OPEN_FILES_EMPTY="Ce commit n’a aucune modification de fichier (peut-être un commit vide)."
MSG_OPEN_FILES_MISSING="Les fichiers suivants ne sont plus dans l’arbre de travail (supprimés/renommés), ignorés :"
MSG_OPEN_FILES_ALL_GONE="Aucun des fichiers touchés par ce commit ne subsiste dans l’arbre de travail."
MSG_OPEN_FILES_OPENING_FMT='Ouverture de %d fichiers dans Zed :\n'
MSG_OPEN_FILES_NO_ZED="Commande zed introuvable."
MSG_OPEN_FILES_INSTALL_HINT="Dans Zed : Cmd+Shift+P → ’zed: install cli’ pour installer la zed CLI."

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files (exporter les fichiers de ce commit dans un dossier)"
MSG_EXPORT_FILES_PURPOSE="Quoi : copie chaque fichier modifié par ce commit (dans la version DE CE commit) vers un dossier, en préservant les chemins"
MSG_EXPORT_FILES_WHEN="Quand : trop de fichiers pour des onglets / snapshot des artefacts d’un commit / diff hors-ligne"
MSG_EXPORT_FILES_CONTRAST="Note : open-files ouvre la version de travail actuelle ; celui-ci exporte la version historique de ce commit"
MSG_EXPORT_FILES_EMPTY="Ce commit n’a aucune modification de fichier (peut-être un commit vide)."
MSG_EXPORT_FILES_COUNT_FMT='Ce commit touche %d fichier(s) :\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... et %d de plus\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='Répertoire d’export (relatif à la racine du dépôt, défaut %s) : '
MSG_EXPORT_FILES_DIR_EXISTS_FMT='Le répertoire existe et n’est pas vide : %s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="Continuer pourrait écraser des fichiers de même nom. Continuer ?"
MSG_EXPORT_FILES_DELETED_HINT="(supprimé dans ce commit ; rien à exporter)"
MSG_EXPORT_FILES_DONE_FMT='Terminé : %d exportés, %d ignorés → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="Note : le contenu reflète l’instantané de ce commit, pas la version de travail actuelle."

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches (exporter N fichiers patch)"
MSG_EXPORT_PATCHES_PURPOSE="Quoi : exporte N commits en arrière depuis ici au format mbox (.patch) ou diff brut (.diff)"
MSG_EXPORT_PATCHES_WHEN="Quand : collaboration par email / sauvegarder des changements précis / envoyer à autrui pour git am / git apply"
MSG_EXPORT_PATCHES_OUTPUT="Sortie : répertoire choisi (défaut ./patches) ; l’historique n’est jamais modifié"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="Format [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply) (défaut f) : "
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='Format invalide : %s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="Combien de commits en arrière (défaut 1) : "
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='Nombre invalide : %s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="Répertoire de sortie (relatif à la racine du dépôt, défaut ./patches) : "
MSG_EXPORT_PATCHES_FORMAT_LABEL="Format :"
MSG_EXPORT_PATCHES_RANGE_LABEL="Plage :"
MSG_EXPORT_PATCHES_OUTPUT_LABEL="Sortie :"
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(racine)"
MSG_EXPORT_PATCHES_CONTINUE="Continuer ?"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft (reset doux vers ce commit · les changements vont dans l’index)"
MSG_RESET_SOFT_PURPOSE="Quoi : déplace HEAD vers ce commit ; les changements des commits intermédiaires atterrissent dans l’index (rien n’est perdu)"
MSG_RESET_SOFT_WHEN="Quand : tu veux ré-empaqueter les N derniers commits (re-découper / changer le message / fusionner)"
MSG_RESET_SOFT_AFTER="Après : git status pour inspecter l’index, puis commit un nouvel historique"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s n’est pas dans la chaîne d’ancêtres de HEAD ; un soft reset n’a pas de sens.\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s est déjà HEAD ; aucun reset nécessaire.\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='Branche courante : %s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='Ces commits seront abandonnés (leurs changements vont dans l’index, HEAD → %s) :\n'
MSG_RESET_SOFT_CONFIRM_FMT='Soft reset vers %s ?'
MSG_RESET_SOFT_DONE="Terminé. Les changements sont dans l’index ; vérifie avec git status, commit à nouveau pour les ré-enregistrer."

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard (reset dur vers ce commit · DESTRUCTIF)"
MSG_RESET_HARD_PURPOSE="Quoi : déplace HEAD vers ce commit ; ÉCARTE les commits intermédiaires ET tous les changements de l’arbre de travail"
MSG_RESET_HARD_WHEN="Quand : tu veux revenir complètement à un état et tu es sûr de vouloir perdre tous les changements intermédiaires"
MSG_RESET_HARD_AFTER="Après : irrécupérable (sauf via git reflog dans les 30 jours ; nécessite de taper YES en majuscules)"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s n’est pas dans la chaîne d’ancêtres de HEAD ; refus.\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s est déjà HEAD ; aucun reset nécessaire.\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='Branche courante : %s\n'
MSG_RESET_HARD_WILL_DROP="Ces commits seront abandonnés (irrécupérables sauf via reflog) :"
MSG_RESET_HARD_WT_LOST="Les changements de l’arbre de travail seront aussi écartés :"
MSG_RESET_HARD_YES_PROMPT_FMT='Tape YES (majuscules) pour confirmer le hard reset vers %s : '
MSG_RESET_HARD_NO_YES="YES non tapé ; annulé."
MSG_RESET_HARD_REFLOG_HINT="Astuce : le reflog peut encore récupérer ces commits ; dans les 30 jours, regarde git reflog → HEAD@{N}."

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i (rebase interactif jusqu’à ce commit)"
MSG_REBASE_I_PURPOSE='Quoi : lance git rebase -i SHA^, ouvre $EDITOR pour éditer la todo à la main'
MSG_REBASE_I_WHEN="Quand : réordonner/fusionner/éditer/supprimer plusieurs commits à la main ; trop complexe pour le menu standard"
MSG_REBASE_I_PREREQ="Requis : l’arbre de travail doit être propre ; en cas de conflits, gère-les à la main ou compte sur l’abort du trap EXIT"
MSG_REBASE_I_RANGE_FMT='Lancement du rebase interactif, plage : %s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="L’arbre de travail a des modifications non commitées ; commit ou stash d’abord."
MSG_REBASE_I_CONTINUE="Continuer ?"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert (créer un commit inverse pour annuler celui-ci)"
MSG_REVERT_PURPOSE="Quoi : ne réécrit pas l’historique ; ajoute un nouveau commit au-dessus de HEAD avec l’inverse des changements de ce commit"
MSG_REVERT_WHEN="Quand : un commit déjà pushé doit être annulé (un reset réécrirait l’historique public)"
MSG_REVERT_CONTRAST="Note : reset réécrit l’historique ; revert l’étend. Auto-abort en cas de conflit."
MSG_REVERT_DIRTY_TREE="L’arbre de travail a des modifications non commitées ; commit ou stash d’abord."
MSG_REVERT_CONFIRM_FMT='Générer un commit inverse au-dessus de HEAD pour annuler %s ?\n'

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick (copier ce commit en tête de la branche courante)"
MSG_CHERRY_PICK_PURPOSE="Quoi : copie les changements de ce commit en tête de la branche courante comme nouveau commit (nouveau SHA)"
MSG_CHERRY_PICK_WHEN="Quand : transporter un hotfix entre branches / récupérer un commit isolé d’un collègue / récupération via reflog"
MSG_CHERRY_PICK_NOTE="Note : le commit source n’est pas supprimé ; cherry-pick sur la même branche n’a pas de sens ; auto-abort en cas de conflit"
MSG_CHERRY_PICK_CURRENT_FMT='Branche courante : %s\n'
MSG_CHERRY_PICK_DIRTY_TREE="L’arbre de travail a des modifications non commitées ; commit ou stash d’abord."
MSG_CHERRY_PICK_CONFIRM_FMT='Cherry-pick %s sur %s ?'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from (créer une nouvelle branch depuis ce commit)"
MSG_BRANCH_FROM_PURPOSE="Quoi : crée une nouvelle branch à ce commit et bascule dessus"
MSG_BRANCH_FROM_WHEN="Quand : démarrer une nouvelle piste de travail depuis un vieux commit / garder une ref nommée vers un état précis"
MSG_BRANCH_FROM_CONTRAST="Note : pour des expériences jetables, utilise try-branch (préfixe try/ auto + rappel de cleanup)"
MSG_BRANCH_FROM_NAME_PROMPT="Nom de la nouvelle branch (basée sur ce commit) : "
MSG_BRANCH_FROM_NO_NAME="Aucun nom de branch fourni ; annulé."

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch (branch jetable depuis ce commit)"
MSG_TRY_BRANCH_PURPOSE="Quoi : crée une branch nommée try/<base-slug>-<sha> depuis ce commit, bascule immédiatement"
MSG_TRY_BRANCH_WHEN="Quand : expérimenter sans polluer la branch courante / inspecter l’état à un vieux commit"
MSG_TRY_BRANCH_HINT="Astuce : à la sortie, affiche les commandes ’retour à l’original’ + ’supprimer cette branch’ en rappel"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # était detached ; consulte le reflog"
MSG_TRY_BRANCH_FROM_FMT='Branch d’origine : %s\nPoint de départ : %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='Nom de la nouvelle branch (Entrée = %s) : '
MSG_TRY_BRANCH_EXISTS_FMT='Branch déjà existante : %s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="Y basculer après création ? [Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='%s créée (pas de bascule)\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="Quand c’est fini, nettoie avec :"
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  retour à l’original : %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  supprimer cette branch : git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push (stash les changements courants avec un nom)"
MSG_STASH_PUSH_PURPOSE="Quoi : stash les changements suivis avec un libellé, laissant l’arbre de travail propre"
MSG_STASH_PUSH_WHEN="Quand : sur le point de changer de branch avec un WIP / mettre du travail de côté brièvement / pré-nettoyage avant reset"
MSG_STASH_PUSH_NOTE="Note : -u n’est PAS utilisé ; les fichiers non suivis restent dans l’arbre de travail (évite les nœuds snapshot parasites dans Git Graph)"
MSG_STASH_PUSH_CLEAN="L’arbre de travail est propre ; rien à stash."
MSG_STASH_PUSH_WILL_STASH="Les changements suivants seront stash :"
MSG_STASH_PUSH_NAME_PROMPT="Choisis un nom (pour le retrouver plus tard) : "
MSG_STASH_PUSH_NO_NAME="Aucun nom fourni ; annulé."
MSG_STASH_PUSH_DONE_HINT="Terminé. Voir : git stash list, ou utilise le menu ’Pop le stash le plus récent’."
MSG_STASH_PUSH_UNTRACKED_NOTE="Note : les fichiers non suivis n’ont PAS été stash et restent dans l’arbre de travail."

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop (appliquer le stash le plus récent à l’arbre de travail)"
MSG_STASH_POP_PURPOSE="Quoi : applique stash@{0} à l’arbre de travail ; en cas de succès, le stash est auto-droppé"
MSG_STASH_POP_WHEN="Quand : des changements stash plus tôt doivent revenir"
MSG_STASH_POP_NOTE="Note : en cas de conflit, le stash n’est PAS auto-droppé ; résous les conflits puis lance git stash drop"
MSG_STASH_POP_EMPTY="Aucun stash disponible à pop."
MSG_STASH_POP_LIST_HEADER="Stashes récents :"
MSG_STASH_POP_PREVIEW_HEADER="Aperçu de stash@{0} :"
MSG_STASH_POP_CONFIRM="Pop stash@{0} dans l’arbre de travail courant ?"
MSG_STASH_POP_CONFLICT="Pop a rencontré des conflits — le stash est conservé (pas auto-droppé)."
MSG_STASH_POP_CONFLICT_HINT="Résous les conflits + git add, puis lance  git stash drop  pour le supprimer."

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete (supprimer les branches locales pointant sur ce commit)"
MSG_BRANCH_DELETE_PURPOSE="Quoi : supprime une branch locale (optionnellement aussi celle du remote)"
MSG_BRANCH_DELETE_WHEN="Quand : faire le ménage des branches mergées/jetables ; élaguer en masse try/* feat/* etc."
MSG_BRANCH_DELETE_NOTE="Note : utilise git branch -D (suppression forcée ; ignore le statut merged)"
MSG_BRANCH_DELETE_NONE="Aucune branch locale à supprimer sur ce commit."
MSG_BRANCH_DELETE_ONE_FMT='Seule branch sur ce commit : %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="Branches locales sur ce commit :"
MSG_BRANCH_DELETE_SELECT_PROMPT="Choisis-en une (nom de branch ou numéro) : "
MSG_BRANCH_DELETE_NO_INPUT="Aucune saisie ; annulé."
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="La branch ’%s’ n’est pas dans la liste sur-ce-commit.\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="Impossible de supprimer la branch actuellement checked-out ’%s’.\n"
MSG_BRANCH_DELETE_CURRENT_HINT="Bascule d’abord vers une autre branch : git switch <autre-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="Supprimer la branch locale ’%s’ ?"
MSG_BRANCH_DELETE_LOCAL_DONE="Branch locale supprimée."
MSG_BRANCH_DELETE_NO_REMOTE="(aucun remote configuré ; remote ignoré)"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="(branch absente sur le remote [%s] ; ignorée)"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="Supprimer aussi du remote [%s] ? [y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="Branch distante supprimée."

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit (éditer les métadonnées / la liste de fichiers de ce commit)"
MSG_EDIT_COMMIT_HEAD_PATH="Chemin HEAD : l’arbre de travail peut être sale ; amend direct ; changer le message / ajouter / retirer / modifier des fichiers"
MSG_EDIT_COMMIT_OLD_PATH="Vieux commit : l’arbre de travail doit être propre ; supporte message / ajout (non suivi) / retrait de fichiers"
MSG_EDIT_COMMIT_NOT_SUITED="Inadapté (vieux commit) : modifier le contenu de fichiers existants → utilise le menu fixup (voir le commentaire d’en-tête pour le pourquoi)"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="Une opération par ligne, termine avec ’Q’ seul sur sa ligne :"
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:path/to/file    git add (ajouter / mettre à jour / stage tout changement)"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:path/to/file    retirer de ce commit (conservé sur disque, git rm --cached)"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                 fini"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  ignoré erreur de format : %s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  ignoré +%s  (le fichier n’existe pas)\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  add  %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  ignoré +%s  (git add a échoué)\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  rm   %s  (retiré du commit, gardé sur disque)\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  ignoré -%s  (pas dans ce commit)\n'
MSG_EDIT_COMMIT_ASK_MSG="Nouveau message (une ligne à la fois ; ’Q’ seul pour valider ; juste Q = laisser inchangé) :"
MSG_EDIT_COMMIT_HEAD_HEADER="─── chemin rapide HEAD ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="La cible est HEAD, aucun rebase nécessaire :"
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · l’arbre de travail peut être sale (les changements deviennent candidats à l’amend)"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · ajoute / modifie / retire des fichiers librement ; aucun risque de conflit en aval"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── message courant ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── changements courants en travail/stage ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="Changer le message ? [y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="Changer les fichiers (ajouter/retirer/modifier) ? [y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="(aucun changement ; pas d’amend ; sortie.)"
MSG_EDIT_COMMIT_UNSTAGED_HINT="Note : l’arbre de travail a encore des changements non stagés ; l’amend ne les inclura PAS."
MSG_EDIT_COMMIT_AMEND_MSG_FILES="Amend effectué (nouveau message + changements de fichiers)"
MSG_EDIT_COMMIT_AMEND_MSG="Amend effectué (nouveau message)"
MSG_EDIT_COMMIT_AMEND_FILES="Amend effectué (changements de fichiers)"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='L’arbre de travail a des modifications non commitées.

Si tu veux fusionner ces changements dans ce commit → utilise le menu :
  "Fold working/staged changes into this commit (fixup+autosquash)"

Si tu veux vraiment ce menu (changer le message / ajouter de nouveaux fichiers / retirer des fichiers), commit ou stash d’abord.'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s n’est pas dans la chaîne d’ancêtres de la branche courante.\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── Chemin vieux-commit (rebase) ───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="S’applique à : message / ajout de nouveaux fichiers (non suivis) / retrait de fichiers"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="Ne s’applique PAS à : modifier le contenu de fichiers existants (utilise le menu fixup)"
MSG_EDIT_COMMIT_OLD_CONTINUE="Continuer ?"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="le rebase n’est pas entré dans l’état edit."
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── message courant du commit ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="Changer le message ? [y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="Changer les fichiers (ajouter/retirer) ? [y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="(aucun changement ; on conclut)"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue a échoué (probablement un conflit modify/delete en aval contre un fichier que tu viens de retirer)."
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase terminé"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n (squash N commits vers l’avant depuis ce commit)"
MSG_SQUASH_PURPOSE="Quoi : fusionne ce commit et N-1 ancêtres en un seul ; les commits en aval rejouent au-dessus"
MSG_SQUASH_WHEN="Quand : ranger des commits WIP / compresser du bruit / fusionner plusieurs petits commits liés"
MSG_SQUASH_PREREQ="Requis : l’arbre de travail doit être propre ; les SHA en aval changent ; auto-abort en cas de conflit"
MSG_SQUASH_DIRTY_TREE="L’arbre de travail a des modifications non commitées ; commit ou stash d’abord."
MSG_SQUASH_COUNT_PROMPT="Combien à squash (ce commit inclus, défaut 2) : "
MSG_SQUASH_MIN_TWO="Il faut au moins 2 commits pour qu’un squash ait du sens."
MSG_SQUASH_TOO_MANY_FMT='Ce commit n’a que %d ancêtre(s) incluant lui-même ; au maximum %d.\n'
MSG_SQUASH_PREVIEW_FMT='Ces %d commit(s) seront squash (ancien → nouveau) :\n'
MSG_SQUASH_MSG_PROMPT="Nouveau message de commit (une ligne à la fois ; Q seul pour valider ; Q nu = ouvre l’éditeur avec la concaténation par défaut ; :q pour annuler) :"
MSG_SQUASH_CANCELLED="Annulé."
MSG_SQUASH_CONTINUE="Continuer ?"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit (supprimer ce commit de l’historique)"
MSG_DROP_PURPOSE="Quoi : retire ce commit de l’historique de la branch ; les commits en aval rejouent (nouveaux SHA)"
MSG_DROP_WHEN="Quand : commit accidentel (mots de passe / code de debug) / WIP inutile / doublon / expérience à effacer"
MSG_DROP_CONTRAST="Note : revert ajoute un commit inverse (garde l’historique) ; drop retire vraiment (réécrit l’historique)"
MSG_DROP_DIRTY_TREE="L’arbre de travail a des modifications non commitées ; commit ou stash d’abord."
MSG_DROP_NOT_ANCESTOR_FMT='%s n’est pas dans la chaîne d’ancêtres de la branche courante.\n'
MSG_DROP_ROOT_COMMIT_FMT='%s est le commit racine, sans parent ; rebase ne peut pas le retirer.\n'
MSG_DROP_ROOT_HINT="Retirer vraiment le commit racine demande git update-ref etc. ; à faire manuellement."
MSG_DROP_WILL_REMOVE="Sera retiré :"
MSG_DROP_DOWNSTREAM_FMT='%d commit(s) en aval rejoueront (les SHA changent) :\n'
MSG_DROP_DOWNSTREAM_HINT="  (si des changements en aval dépendent de ce commit → auto-abort en cas de conflit)"
MSG_DROP_IS_HEAD_NOTE="(ce commit est HEAD → chemin rapide via git reset --hard HEAD~ ; pas de rebase)"
MSG_DROP_CONFIRM="Confirmer le retrait ?"
MSG_DROP_DONE_HEAD="Terminé. HEAD a été déplacé sur le commit précédent."
MSG_DROP_DONE_REBASE="Terminé. Le commit a été retiré de l’historique."

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup (fusionner les changements de l’arbre de travail dans ce commit)"
MSG_FIXUP_PURPOSE="Quoi : crée un commit fixup + autosquash, fusionnant les changements de l’arbre de travail dans ce commit"
MSG_FIXUP_WHEN="Quand : tu as édité des fichiers et veux qu’ils atterrissent sur un vieux commit (très courant) ; évite de polluer l’historique"
MSG_FIXUP_PREREQ="Requis : l’arbre de travail / staging doit avoir des changements ; auto-abort en cas de conflit"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s n’est pas dans la chaîne d’ancêtres de la branche courante.\n'
MSG_FIXUP_NO_CHANGES="L’arbre de travail est propre ; rien à fusionner."
MSG_FIXUP_WORKFLOW_HINT="Workflow : éditer des fichiers → utiliser ce menu → choisir le commit cible → fixup + autosquash automatiques."
MSG_FIXUP_WILL_FOLD="Changements à fusionner dans ce commit :"
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="L’index contient déjà du contenu ; inclure aussi les changements non stagés ? [y/N] "
MSG_FIXUP_ASK_ADD_ALL="L’index est vide ; git add -A tout puis fixup ? [Y/n] "
MSG_FIXUP_EMPTY_INDEX="L’index est vide ; rien à fixup ; annulé."
MSG_FIXUP_TARGET_FMT='Cible : %s  "%s"\n'
MSG_FIXUP_CONFIRM="Confirmer fixup + autosquash ? [Y/n] "
MSG_FIXUP_CANCELLED="Annulé ; état de l’index préservé."
MSG_FIXUP_CREATED="  + commit fixup créé"
MSG_FIXUP_DONE_FMT='Terminé. Changements fusionnés dans %s (SHA mis à jour après autosquash).\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup (fusionner ce commit dans un ancêtre)"
MSG_CFIX_PURPOSE="Quoi : prend ce commit et l’applique comme fixup sur un commit antérieur de la même branch"
MSG_CFIX_WHEN="Quand : un fix sur HEAD appartient en réalité à un commit antérieur ; remets-le chez lui"
MSG_CFIX_CONTRAST="Note : fixup.sh utilise les changements de l’arbre de travail ; ce menu utilise un commit existant"
MSG_CFIX_DIRTY_TREE="L’arbre de travail a des modifications non commitées ; commit ou stash d’abord."
MSG_CFIX_NOT_ANCESTOR_SRC="Le commit source n’est pas dans la chaîne d’ancêtres de la branche courante."
MSG_CFIX_HEADER="Fusionner ce commit (fixup) dans un autre commit."
MSG_CFIX_TARGET_HINT="La cible doit être un ancêtre de la source (plus ancien dans l’historique). Astuce : copie le SHA cible depuis le Zed Graph."
MSG_CFIX_TARGET_PROMPT="SHA du commit cible (court ou long) : "
MSG_CFIX_NO_INPUT="Aucune saisie ; annulé."
MSG_CFIX_INVALID_SHA_FMT='SHA invalide : %s\n'
MSG_CFIX_SAME_COMMIT="Cible et source sont identiques ; sans intérêt."
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s n’est pas un ancêtre du commit source (impossible de fixup dessus).\n'
MSG_CFIX_PREVIEW="─── aperçu ───"
MSG_CFIX_SOURCE_LABEL="Source :"
MSG_CFIX_TARGET_LABEL="Cible :"
MSG_CFIX_RANGE_LABEL="plage rebase (ancien → nouveau) :"
MSG_CFIX_CONTINUE="Continuer ?"
MSG_CFIX_DONE="Terminé. Source fusionnée dans la cible (SHA du commit cible mis à jour)."

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto (rebase la branch A sur la branch B)"
MSG_RBO_PURPOSE="Quoi : git switch A && git rebase B ; les commits exclusifs à A rejouent sur la tête de B"
MSG_RBO_WHEN="Quand : A est une branch de feature, B est main/develop ; mettre A à jour avec le dernier B"
MSG_RBO_NOTE="Note : les commits de A sont réécrits (nouveaux SHA) ; auto-abort en cas de conflit"
MSG_RBO_DIRTY_TREE="L’arbre de travail a des modifications non commitées ; commit ou stash d’abord."
MSG_RBO_LOCAL_BRANCHES="Branches locales :"
MSG_RBO_A_PROMPT_FMT='Branch A (à rebaser ; Entrée = %s courante) : '
MSG_RBO_DETACHED_ERR="Actuellement en HEAD detached ; tu dois nommer explicitement la branch A."
MSG_RBO_NO_LOCAL_FMT='Aucune branch locale nommée : %s\n'
MSG_RBO_B_PROMPT="Branch B (cible du rebase ; locale / remote / tag) : "
MSG_RBO_NO_INPUT="Aucune saisie ; annulé."
MSG_RBO_INVALID_REF_FMT='Ref cible invalide : %s\n'
MSG_RBO_SAME="A et B pointent sur le même commit ; rien à rebaser."
MSG_RBO_PREVIEW="─── Aperçu ───"
MSG_RBO_NO_EXCLUSIVE="A n’a aucun commit au-delà de B (A est un ancêtre de B, ou identique)."
MSG_RBO_FF_OR_NOOP="le rebase sera un fast-forward ou un no-op."
MSG_RBO_REPLAY_FMT='Commits de A à rejouer (%d) :\n'
MSG_RBO_CONFIRM_FMT='Continuer : git switch %s && git rebase %s ?'
MSG_RBO_SWITCHING_FMT='Bascule vers %s...\n'
MSG_RBO_DONE="Terminé."

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag (taguer ce commit)"
MSG_TAG_PURPOSE="Quoi : crée un tag léger ou annoté pointant sur ce commit ; optionnellement push vers le remote"
MSG_TAG_WHEN="Quand : point de release / jalon / référence stable nommée vers un commit"
MSG_TAG_CONTRAST="Note : annoté porte message+auteur+date (recommandé pour les releases) ; léger n’est qu’une ref"
MSG_TAG_NAME_PROMPT="Nom du tag (p.ex. v1.0.0 / release-2024-01) : "
MSG_TAG_NO_INPUT="Aucune saisie ; annulé."
MSG_TAG_EXISTS_FMT='Tag déjà existant : %s\n'
MSG_TAG_KIND_PROMPT="annoté (avec message) ou léger ? [a]/l (défaut a) : "
MSG_TAG_MSG_PROMPT="Message du tag (Entrée = utiliser le nom du tag) : "
MSG_TAG_CREATED_FMT='Tag créé : %s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='Push vers le remote [%s] ? [y/N] '
MSG_TAG_NO_REMOTE="(aucun remote configuré ; push ignoré)"
MSG_TAG_REFRESH_HINT="Note : Zed Git Graph ne surveille pas les changements de tags ; rafraîchis manuellement (Cmd+Shift+P → reload window, ou attends le prochain commit)."

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete (supprimer un tag)"
MSG_TAG_DELETE_PURPOSE="Quoi : supprime un tag local ; optionnellement aussi sur le remote"
MSG_TAG_DELETE_WHEN="Quand : mauvais tag / re-release / cleanup"
MSG_TAG_DELETE_NOTE="Note : supprimer un tag remote déjà pushé impacte les autres ; local + remote sont demandés séparément"
MSG_TAG_DELETE_AT_HEADER="Tags sur ce commit :"
MSG_TAG_DELETE_NONE="  (aucun)"
MSG_TAG_DELETE_NAME_PROMPT="Nom du tag à supprimer (peut être sur un autre commit) : "
MSG_TAG_DELETE_NO_INPUT="Aucune saisie ; annulé."
MSG_TAG_DELETE_NOT_EXIST_FMT='Le tag n’existe pas : %s\n'
MSG_TAG_DELETE_ANNOTATED="(tag annoté)"
MSG_TAG_DELETE_PREVIEW_FMT="tag ’%s’ → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="Supprimer le tag local ’%s’ ?"
MSG_TAG_DELETE_LOCAL_DONE="Tag local supprimé."
MSG_TAG_DELETE_NO_REMOTE="(aucun remote configuré ; remote ignoré)"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="(aucun tag de ce nom sur le remote [%s] ; ignoré)\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="Supprimer aussi du remote [%s] ? [y/N] "
MSG_TAG_DELETE_REMOTE_DONE="Tag distant supprimé."

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="Quoi : checkout ce commit dans un nouveau worktree, regroupé par objectif"
MSG_WT_FROM_NOTE_FMT='objectif : %s'
MSG_WT_FROM_PATH_EXISTS_FMT='Le chemin existe déjà : %s\n'
MSG_WT_FROM_PATH_HINT="Astuce : lance  git worktree list  pour inspecter les worktrees existants"
MSG_WT_FROM_BRANCH_EXISTS_FMT='Branch déjà existante : %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree créé : %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  branch : %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  cleanup : git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  cleanup : git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='Nom de branch (Entrée = %s) : '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="Quoi : liste les worktrees sous [%s] et laisse l’utilisateur coller un nom à supprimer"
MSG_WT_RM_USAGE_FMT="Comment : passe la liste en revue, colle le nom (préfixe %s/ inclus), puis confirme"
MSG_WT_RM_EMPTY_FMT='[%s] n’a aucun worktree à supprimer.\n'
MSG_WT_RM_LIST_HEADER_FMT='worktrees de [%s] :\n'
MSG_WT_RM_NAME_PROMPT="Colle le nom du worktree à supprimer (copie une ligne entière ci-dessus) : "
MSG_WT_RM_NO_INPUT="Aucune saisie ; annulé."
MSG_WT_RM_NOT_IN_LIST_FMT="’%s’ n’est pas dans la liste des worktrees [%s].\n"
MSG_WT_RM_REMOVING_FMT='Suppression : %s\n'
MSG_WT_RM_DONE="✓ worktree supprimé."
MSG_WT_RM_REVIEW_NO_BRANCH="(review est detached ; aucune branch à nettoyer)"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="Supprimer aussi la branch locale ’%s’ ? [y/N] "
MSG_WT_RM_BRANCH_DONE="✓ Branch locale supprimée."
MSG_WT_RM_BRANCH_ABSENT_FMT="(la branch ’%s’ n’existe pas ; peut-être déjà retirée par git worktree remove)\n"
