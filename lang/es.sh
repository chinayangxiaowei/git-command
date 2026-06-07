#!/usr/bin/env bash
# Mensajes en español para los scripts de git-command.
# Cargado por lib.sh; no invocar directamente.
# Convención: MSG_<SCRIPT>_<KEY>; sufijo _FMT para plantillas printf.
# shellcheck shell=bash

# ── lib.sh (internos compartidos) ───────────────────────────────
MSG_LIB_IN_PROGRESS_FMT='Hay un %s sin terminar en curso. Ejecuta "%s" o --continue primero.\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s falló; ejecutando git %s --abort automáticamente (workspace restaurado al estado previo).\n'
MSG_LIB_NOT_IN_REPO='No estás dentro de un repositorio git.'
MSG_LIB_NOT_BARE_LAYOUT='El proyecto actual no usa el layout bare + worktrees; menú de worktree deshabilitado.'
MSG_LIB_INIT_HINT='Para habilitarlo, crea un proyecto nuevo con: bash git-command/init-bare-tree.sh <nombre> [<url>]'
MSG_LIB_MIGRATE_HINT='Para proyectos existentes: migrate-to-bare-tree.sh (aún no implementado; migra manualmente).'
MSG_LIB_CLEANUP_FMT='El script terminó inesperadamente (exit %d); ejecutando git %s --abort para revertir.\n'

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword (reescribe el mensaje de este commit)"
MSG_REWORD_PURPOSE="Qué:    cambia solo el mensaje del commit; el contenido y la cadena de SHAs se mantienen (los SHAs posteriores se reescribirán)"
MSG_REWORD_WHEN="Cuándo: corregir un typo / ajustarse a la convención / agregar referencia a un issue / retocar el prefijo conventional-commit"
MSG_REWORD_CONTRAST="Nota:   para el mensaje de HEAD, edit-commit es más rápido; reword es para commits anteriores"
MSG_REWORD_DIRTY_TREE="El working tree tiene cambios sin commitear; haz commit o stash primero."
MSG_REWORD_NOT_ANCESTOR_FMT='%s no está en la cadena de ancestros de la branch actual; no se puede hacer reword.\n'
MSG_REWORD_OLD_MSG="Mensaje anterior:"
MSG_REWORD_NEW_MSG_PROMPT="Mensaje nuevo (una línea por entrada; línea en blanco = salto de párrafo; sola 'Q' para enviar, ':q' para cancelar):"
MSG_REWORD_CANCELLED="Cancelado."
MSG_REWORD_EMPTY_CANCELLED="Sin entrada; cancelado."

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files (abre en Zed todos los archivos tocados por este commit)"
MSG_OPEN_FILES_PURPOSE="Qué:    lista los archivos modificados por este commit y los abre todos en Zed (versión actual del working tree)"
MSG_OPEN_FILES_WHEN="Cuándo: depurar un bug histórico; quieres ver todos los archivos involucrados en ese cambio"
MSG_OPEN_FILES_PREREQ="Requiere: el CLI zed en PATH; los archivos que ya no están en el tree actual se omiten"
MSG_OPEN_FILES_EMPTY="Este commit no tiene cambios de archivos (posiblemente un commit vacío)."
MSG_OPEN_FILES_MISSING="Los siguientes archivos ya no están en el working tree (borrados/renombrados), se omiten:"
MSG_OPEN_FILES_ALL_GONE="Ninguno de los archivos tocados por este commit sigue en el working tree."
MSG_OPEN_FILES_OPENING_FMT='Abriendo %d archivos en Zed:\n'
MSG_OPEN_FILES_NO_ZED="comando zed no encontrado."
MSG_OPEN_FILES_INSTALL_HINT="En Zed: Cmd+Shift+P → 'zed: install cli' para instalar el CLI de zed."

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files (exporta los archivos de este commit a una carpeta)"
MSG_EXPORT_FILES_PURPOSE="Qué:    copia cada archivo modificado por este commit (en la versión de ESTE commit) a una carpeta, conservando las rutas"
MSG_EXPORT_FILES_WHEN="Cuándo: demasiados archivos para abrir como pestañas / capturar los artefactos de un commit / diff sin conexión"
MSG_EXPORT_FILES_CONTRAST="Nota:   open-files abre la versión actual del working tree; este exporta la versión histórica de este commit"
MSG_EXPORT_FILES_EMPTY="Este commit no tiene cambios de archivos (posiblemente un commit vacío)."
MSG_EXPORT_FILES_COUNT_FMT='Este commit toca %d archivo(s):\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... y %d más\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='Carpeta de exportación (relativa a la raíz del repo, por defecto %s): '
MSG_EXPORT_FILES_DIR_EXISTS_FMT='La carpeta existe y no está vacía: %s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="Continuar puede sobrescribir archivos con el mismo nombre. ¿Continuar?"
MSG_EXPORT_FILES_DELETED_HINT="(borrado en este commit; nada que exportar)"
MSG_EXPORT_FILES_DONE_FMT='Listo: exportados %d, omitidos %d → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="Nota: el contenido refleja la instantánea de este commit, no la versión actual del working tree."

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches (exporta N archivos de parche)"
MSG_EXPORT_PATCHES_PURPOSE="Qué:    exporta N commits hacia atrás desde aquí como mbox (.patch) o diff plano (.diff)"
MSG_EXPORT_PATCHES_WHEN="Cuándo: colaboración por email / respaldar cambios específicos / enviar a otros para git am / git apply"
MSG_EXPORT_PATCHES_OUTPUT="Salida: carpeta elegida (por defecto ./patches); la historia nunca se modifica"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="Formato [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply) (por defecto f): "
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='Formato inválido: %s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="¿Cuántos commits hacia atrás (por defecto 1): "
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='Cantidad inválida: %s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="Carpeta de salida (relativa a la raíz del repo, por defecto ./patches): "
MSG_EXPORT_PATCHES_FORMAT_LABEL="Formato:"
MSG_EXPORT_PATCHES_RANGE_LABEL="Rango:"
MSG_EXPORT_PATCHES_OUTPUT_LABEL="Salida:"
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(raíz)"
MSG_EXPORT_PATCHES_CONTINUE="¿Continuar?"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft (reset suave a este commit · los cambios van al staging)"
MSG_RESET_SOFT_PURPOSE="Qué:    mueve HEAD a este commit; los cambios de los commits intermedios quedan en el index (no se pierde nada)"
MSG_RESET_SOFT_WHEN="Cuándo: quieres reempaquetar los últimos N commits (re-dividir / cambiar mensaje / unir)"
MSG_RESET_SOFT_AFTER="Después: git status para revisar el index, luego haz commit con la nueva historia"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s no está en la cadena de ancestros de HEAD; el reset suave no tiene sentido.\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s ya es HEAD; no hace falta reset.\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='Branch actual: %s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='Se descartarán estos commits (sus cambios van al index, HEAD → %s):\n'
MSG_RESET_SOFT_CONFIRM_FMT='¿Reset suave a %s?'
MSG_RESET_SOFT_DONE="Listo. Los cambios están en el index; revisa con git status y vuelve a commitear para re-registrarlos."

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard (reset duro a este commit · DESTRUCTIVO)"
MSG_RESET_HARD_PURPOSE="Qué:    mueve HEAD a este commit; DESCARTA los commits intermedios Y todos los cambios del working tree"
MSG_RESET_HARD_WHEN="Cuándo: quieres volver totalmente a un estado y estás seguro de perder todos los cambios intermedios"
MSG_RESET_HARD_AFTER="Después: irrecuperable (salvo con git reflog dentro de 30 días; requiere escribir YES en mayúsculas)"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s no está en la cadena de ancestros de HEAD; rechazado.\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s ya es HEAD; no hace falta reset.\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='Branch actual: %s\n'
MSG_RESET_HARD_WILL_DROP="Se descartarán estos commits (irrecuperables salvo vía reflog):"
MSG_RESET_HARD_WT_LOST="También se descartarán los cambios del working tree:"
MSG_RESET_HARD_YES_PROMPT_FMT='Escribe YES (mayúsculas) para confirmar el reset duro a %s: '
MSG_RESET_HARD_NO_YES="No escribiste YES; cancelado."
MSG_RESET_HARD_REFLOG_HINT="Pista: el reflog aún puede recuperar estos commits; dentro de 30 días revisa git reflog → HEAD@{N}."

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i (rebase interactivo hasta este commit)"
MSG_REBASE_I_PURPOSE='Qué:    inicia git rebase -i SHA^, abre $EDITOR para editar el todo manualmente'
MSG_REBASE_I_WHEN="Cuándo: reordenar/unir/editar/descartar varios commits manualmente; algo complejo más allá del menú estándar"
MSG_REBASE_I_PREREQ="Requiere: el working tree debe estar limpio; si surgen conflictos, resuélvelos manualmente o confía en el abort del trap EXIT"
MSG_REBASE_I_RANGE_FMT='Se iniciará rebase interactivo, rango: %s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="El working tree tiene cambios sin commitear; haz commit o stash primero."
MSG_REBASE_I_CONTINUE="¿Continuar?"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert (crea un commit inverso para deshacer este)"
MSG_REVERT_PURPOSE="Qué:    no reescribe la historia; añade un nuevo commit sobre HEAD con el inverso de los cambios de este commit"
MSG_REVERT_WHEN="Cuándo: hay que deshacer un commit ya pusheado (reset reescribiría la historia pública)"
MSG_REVERT_CONTRAST="Nota:   reset reescribe la historia; revert le añade. Aborta automáticamente ante conflictos."
MSG_REVERT_DIRTY_TREE="El working tree tiene cambios sin commitear; haz commit o stash primero."
MSG_REVERT_CONFIRM_FMT='¿Generar un commit inverso sobre HEAD para deshacer %s?\n'

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick (copia este commit a la punta de la branch actual)"
MSG_CHERRY_PICK_PURPOSE="Qué:    copia los cambios de este commit a la punta de la branch actual como un nuevo commit (SHA nuevo)"
MSG_CHERRY_PICK_WHEN="Cuándo: llevar un hotfix entre branches / tomar un único commit de un compañero / recuperar vía reflog"
MSG_CHERRY_PICK_NOTE="Nota:   el commit de origen no se borra; en la misma branch no tiene sentido; aborta automáticamente ante conflictos"
MSG_CHERRY_PICK_CURRENT_FMT='Branch actual: %s\n'
MSG_CHERRY_PICK_DIRTY_TREE="El working tree tiene cambios sin commitear; haz commit o stash primero."
MSG_CHERRY_PICK_CONFIRM_FMT='¿Cherry-pick de %s sobre %s?'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from (crea una branch nueva desde este commit)"
MSG_BRANCH_FROM_PURPOSE="Qué:    crea una branch nueva en este commit y cambia a ella"
MSG_BRANCH_FROM_WHEN="Cuándo: empezar una nueva línea de trabajo desde un commit antiguo / mantener un ref con nombre a un estado específico"
MSG_BRANCH_FROM_CONTRAST="Nota:   para experimentos desechables usa try-branch (prefijo try/ automático + pista de limpieza)"
MSG_BRANCH_FROM_NAME_PROMPT="Nombre de la nueva branch (basada en este commit): "
MSG_BRANCH_FROM_NO_NAME="No se dio nombre de branch; cancelado."

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch (branch desechable desde este commit)"
MSG_TRY_BRANCH_PURPOSE="Qué:    crea una branch try/<base-slug>-<sha> desde este commit y cambia a ella de inmediato"
MSG_TRY_BRANCH_WHEN="Cuándo: experimentar sin contaminar la branch actual / inspeccionar el estado de un commit antiguo"
MSG_TRY_BRANCH_HINT="Pista:  al salir imprime los comandos 'volver al original' + 'borrar esta branch' como recordatorio"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # estaba detached; consulta el reflog"
MSG_TRY_BRANCH_FROM_FMT='Branch original: %s\nPunto de inicio: %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='Nombre de la nueva branch (Enter = %s): '
MSG_TRY_BRANCH_EXISTS_FMT='La branch ya existe: %s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="¿Cambiar a ella después de crearla? [Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='Creada %s (sin cambiar)\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="Cuando termines, limpia con:"
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  volver al original: %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  borrar esta branch: git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push (guarda los cambios actuales con un nombre)"
MSG_STASH_PUSH_PURPOSE="Qué:    guarda los cambios de archivos tracked con una etiqueta, dejando el working tree limpio"
MSG_STASH_PUSH_WHEN="Cuándo: estás por cambiar de branch con WIP / dejar el trabajo brevemente / limpiar antes de un reset"
MSG_STASH_PUSH_NOTE="Nota:   NO se usa -u; los archivos untracked se quedan en el working tree (evita nodos spurios en el Git Graph)"
MSG_STASH_PUSH_CLEAN="El working tree está limpio; nada para stashear."
MSG_STASH_PUSH_WILL_STASH="Se hará stash de los siguientes cambios:"
MSG_STASH_PUSH_NAME_PROMPT="Elige un nombre (te ayuda a encontrarlo después): "
MSG_STASH_PUSH_NO_NAME="No se dio nombre; cancelado."
MSG_STASH_PUSH_DONE_HINT="Listo. Verlo: git stash list, o usa el menú 'Pop most recent stash'."
MSG_STASH_PUSH_UNTRACKED_NOTE="Nota: los archivos untracked NO fueron guardados y siguen en el working tree."

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop (aplica el stash más reciente al working tree)"
MSG_STASH_POP_PURPOSE="Qué:    aplica stash@{0} al working tree; si todo va bien, el stash se descarta automáticamente"
MSG_STASH_POP_WHEN="Cuándo: hay que recuperar cambios stasheados antes"
MSG_STASH_POP_NOTE="Nota:   ante conflictos el stash NO se descarta; resuélvelos y luego ejecuta git stash drop"
MSG_STASH_POP_EMPTY="No hay stash disponible para pop."
MSG_STASH_POP_LIST_HEADER="Stashes recientes:"
MSG_STASH_POP_PREVIEW_HEADER="Vista previa de stash@{0}:"
MSG_STASH_POP_CONFIRM="¿Pop de stash@{0} al working tree actual?"
MSG_STASH_POP_CONFLICT="El pop encontró conflictos — el stash se conserva (no se descartó)."
MSG_STASH_POP_CONFLICT_HINT="Resuelve los conflictos + git add, luego ejecuta  git stash drop  para descartarlo."

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete (borra branches locales que apuntan a este commit)"
MSG_BRANCH_DELETE_PURPOSE="Qué:    borra una branch local (opcionalmente también la del remote)"
MSG_BRANCH_DELETE_WHEN="Cuándo: limpiar branches mergeadas/desechables; podar en bloque try/* feat/* etc."
MSG_BRANCH_DELETE_NOTE="Nota:   usa git branch -D (borrado forzado; ignora si está mergeada)"
MSG_BRANCH_DELETE_NONE="No hay branches locales en este commit para borrar."
MSG_BRANCH_DELETE_ONE_FMT='Única branch en este commit: %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="Branches locales en este commit:"
MSG_BRANCH_DELETE_SELECT_PROMPT="Elige una (nombre de branch o número): "
MSG_BRANCH_DELETE_NO_INPUT="Sin entrada; cancelado."
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="La branch '%s' no está en la lista de este commit.\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="No se puede borrar la branch actualmente activa '%s'.\n"
MSG_BRANCH_DELETE_CURRENT_HINT="Cambia primero a otra branch: git switch <otra-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="¿Borrar la branch local '%s'?"
MSG_BRANCH_DELETE_LOCAL_DONE="Branch local borrada."
MSG_BRANCH_DELETE_NO_REMOTE="(sin remote configurado; se omite el remote)"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="(la branch no existe en el remote [%s]; se omite)"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="¿Borrar también del remote [%s]? [y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="Branch del remote borrada."

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit (edita los metadatos / lista de archivos de este commit)"
MSG_EDIT_COMMIT_HEAD_PATH="Ruta HEAD:   el working tree puede estar sucio; amend directo; cambiar mensaje / agregar / quitar / modificar archivos"
MSG_EDIT_COMMIT_OLD_PATH="Commit viejo: el working tree debe estar limpio; soporta mensaje / agregar (untracked) / quitar archivos"
MSG_EDIT_COMMIT_NOT_SUITED="No apto (commit viejo): modificar el contenido de archivos existentes → usa el menú fixup (mira el comentario de cabecera para el porqué)"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="Una operación por línea, termina con 'Q' en una línea sola:"
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:ruta/al/archivo    git add (agregar / actualizar / stagear cualquier cambio)"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:ruta/al/archivo    quitar de este commit (se preserva en disco, git rm --cached)"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                    listo"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  omitir error de formato: %s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  omitir +%s  (el archivo no existe)\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  add  %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  omitir +%s  (git add falló)\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  rm   %s  (quitado del commit, conservado en disco)\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  omitir -%s  (no está en este commit)\n'
MSG_EDIT_COMMIT_ASK_MSG="Nuevo mensaje (por línea; sola 'Q' para enviar; solo Q = dejar sin cambios):"
MSG_EDIT_COMMIT_HEAD_HEADER="─── Vía rápida de HEAD ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="El target es HEAD, no hace falta rebase:"
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · el working tree puede estar sucio (los cambios se vuelven candidatos al amend)"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · agrega / modifica / quita archivos sin problema; sin riesgo de conflictos posteriores"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── mensaje actual ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── cambios actuales en working/staged ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="¿Cambiar el mensaje? [y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="¿Cambiar archivos (agregar/quitar/modificar)? [y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="(sin cambios; no se hace amend; saliendo.)"
MSG_EDIT_COMMIT_UNSTAGED_HINT="Nota: el working tree todavía tiene cambios unstaged; el amend NO los incluirá."
MSG_EDIT_COMMIT_AMEND_MSG_FILES="Amend hecho (nuevo mensaje + cambios de archivos)"
MSG_EDIT_COMMIT_AMEND_MSG="Amend hecho (nuevo mensaje)"
MSG_EDIT_COMMIT_AMEND_FILES="Amend hecho (cambios de archivos)"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='El working tree tiene cambios sin commitear.

Si quieres fundir esos cambios en este commit → usa el menú:
  "Fold working/staged changes into this commit (fixup+autosquash)"

Si de verdad quieres este menú (cambiar mensaje / agregar archivos nuevos / quitar archivos), haz commit o stash primero.'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s no está en la cadena de ancestros de la branch actual.\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── Vía de commit viejo (rebase) ───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="Aplica a: mensaje / agregar archivos nuevos (untracked) / quitar archivos"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="NO aplica a: modificar el contenido de archivos existentes (usa el menú fixup)"
MSG_EDIT_COMMIT_OLD_CONTINUE="¿Continuar?"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="el rebase no entró en estado edit."
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── mensaje actual del commit ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="¿Cambiar mensaje? [y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="¿Cambiar archivos (agregar/quitar)? [y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="(sin cambios; cerrando)"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue falló (probablemente un conflicto modify/delete posterior contra un archivo que acabas de quitar)."
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase completo"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n (squash de N commits adelante desde este commit)"
MSG_SQUASH_PURPOSE="Qué:    funde este commit y sus N-1 ancestros en uno; los commits posteriores se reaplican encima"
MSG_SQUASH_WHEN="Cuándo: ordenar commits WIP / comprimir ruido / unir varios commits pequeños relacionados"
MSG_SQUASH_PREREQ="Requiere: el working tree debe estar limpio; los SHAs posteriores cambian; aborta automáticamente ante conflictos"
MSG_SQUASH_DIRTY_TREE="El working tree tiene cambios sin commitear; haz commit o stash primero."
MSG_SQUASH_COUNT_PROMPT="¿Cuántos hacer squash (incluido este commit, por defecto 2): "
MSG_SQUASH_MIN_TWO="Hacen falta al menos 2 commits para que el squash tenga sentido."
MSG_SQUASH_TOO_MANY_FMT='Este commit tiene solo %d ancestro(s) incluyéndose; máximo %d.\n'
MSG_SQUASH_PREVIEW_FMT='Se hará squash de estos %d commit(s) (viejo → nuevo):\n'
MSG_SQUASH_MSG_PROMPT="Nuevo mensaje del commit (por línea; sola Q para enviar; Q solo = abrir el editor con la concatenación por defecto; :q para cancelar):"
MSG_SQUASH_CANCELLED="Cancelado."
MSG_SQUASH_CONTINUE="¿Continuar?"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit (elimina este commit de la historia)"
MSG_DROP_PURPOSE="Qué:    quita este commit de la historia de la branch; los commits posteriores se reaplican (SHAs nuevos)"
MSG_DROP_WHEN="Cuándo: commit accidental (contraseñas / código de debug) / WIP inútil / duplicado / experimento a borrar"
MSG_DROP_CONTRAST="Nota:   revert agrega un commit inverso (conserva la historia); drop elimina de verdad (reescribe la historia)"
MSG_DROP_DIRTY_TREE="El working tree tiene cambios sin commitear; haz commit o stash primero."
MSG_DROP_NOT_ANCESTOR_FMT='%s no está en la cadena de ancestros de la branch actual.\n'
MSG_DROP_ROOT_COMMIT_FMT='%s es el commit raíz, no tiene padre; rebase no puede eliminarlo.\n'
MSG_DROP_ROOT_HINT="Eliminar realmente el commit raíz requiere git update-ref, etc.; hazlo manualmente."
MSG_DROP_WILL_REMOVE="Se eliminará:"
MSG_DROP_DOWNSTREAM_FMT='Se reaplicarán %d commit(s) posteriores (los SHAs cambian):\n'
MSG_DROP_DOWNSTREAM_HINT="  (si los cambios posteriores dependen de este commit → aborta automáticamente ante conflictos)"
MSG_DROP_IS_HEAD_NOTE="(este commit es HEAD → vía rápida con git reset --hard HEAD~; sin rebase)"
MSG_DROP_CONFIRM="¿Confirmar la eliminación?"
MSG_DROP_DONE_HEAD="Listo. HEAD se movió al commit anterior."
MSG_DROP_DONE_REBASE="Listo. El commit fue eliminado de la historia."

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup (funde los cambios del working tree en este commit)"
MSG_FIXUP_PURPOSE="Qué:    crea un commit fixup + autosquash, fundiendo los cambios del working tree en este commit"
MSG_FIXUP_WHEN="Cuándo: editaste archivos y quieres que aterricen en un commit antiguo (muy común); evita contaminar la historia"
MSG_FIXUP_PREREQ="Requiere: el working / staging tree debe tener cambios; aborta automáticamente ante conflictos"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s no está en la cadena de ancestros de la branch actual.\n'
MSG_FIXUP_NO_CHANGES="El working tree está limpio; nada que fundir."
MSG_FIXUP_WORKFLOW_HINT="Flujo: edita archivos → usa este menú → elige el commit destino → fixup + autosquash automático."
MSG_FIXUP_WILL_FOLD="Cambios a fundir en este commit:"
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="El index ya tiene contenido; ¿incluir también los cambios unstaged? [y/N] "
MSG_FIXUP_ASK_ADD_ALL="El index está vacío; ¿git add -A todo y luego fixup? [Y/n] "
MSG_FIXUP_EMPTY_INDEX="El index está vacío; nada para fixup; cancelado."
MSG_FIXUP_TARGET_FMT='Destino: %s  "%s"\n'
MSG_FIXUP_CONFIRM="¿Confirmar fixup + autosquash? [Y/n] "
MSG_FIXUP_CANCELLED="Cancelado; estado del index conservado."
MSG_FIXUP_CREATED="  + commit fixup creado"
MSG_FIXUP_DONE_FMT='Listo. Cambios fundidos en %s (SHA actualizado tras el autosquash).\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup (funde este commit en un ancestro)"
MSG_CFIX_PURPOSE="Qué:    toma este commit y lo aplica como fixup sobre un commit anterior en la misma branch"
MSG_CFIX_WHEN="Cuándo: una corrección en HEAD pertenece realmente a un commit anterior; llévala a su lugar"
MSG_CFIX_CONTRAST="Nota:   fixup.sh usa los cambios del working tree; este menú usa un commit existente"
MSG_CFIX_DIRTY_TREE="El working tree tiene cambios sin commitear; haz commit o stash primero."
MSG_CFIX_NOT_ANCESTOR_SRC="El commit de origen no está en la cadena de ancestros de la branch actual."
MSG_CFIX_HEADER="Funde este commit (fixup) en otro commit."
MSG_CFIX_TARGET_HINT="El destino debe ser un ancestro del origen (anterior en la historia). Pista: copia el SHA destino desde el Zed Graph."
MSG_CFIX_TARGET_PROMPT="SHA del commit destino (corto o largo): "
MSG_CFIX_NO_INPUT="Sin entrada; cancelado."
MSG_CFIX_INVALID_SHA_FMT='SHA inválido: %s\n'
MSG_CFIX_SAME_COMMIT="Destino y origen son el mismo; sin sentido."
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s no es un ancestro del commit de origen (no se puede fixup sobre él).\n'
MSG_CFIX_PREVIEW="─── vista previa ───"
MSG_CFIX_SOURCE_LABEL="Origen:"
MSG_CFIX_TARGET_LABEL="Destino:"
MSG_CFIX_RANGE_LABEL="rango del rebase (viejo → nuevo):"
MSG_CFIX_CONTINUE="¿Continuar?"
MSG_CFIX_DONE="Listo. Origen fundido en el destino (SHA del commit destino actualizado)."

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto (rebase de la branch A sobre la branch B)"
MSG_RBO_PURPOSE="Qué:    git switch A && git rebase B; los commits exclusivos de A se reaplican sobre la punta de B"
MSG_RBO_WHEN="Cuándo: A es una branch de feature, B es main/develop; pone A al día con lo último de B"
MSG_RBO_NOTE="Nota:   los commits de A se reescriben (SHAs nuevos); aborta automáticamente ante conflictos"
MSG_RBO_DIRTY_TREE="El working tree tiene cambios sin commitear; haz commit o stash primero."
MSG_RBO_LOCAL_BRANCHES="Branches locales:"
MSG_RBO_A_PROMPT_FMT='Branch A (a rebasear; Enter = actual %s): '
MSG_RBO_DETACHED_ERR="Estás en HEAD detached; tienes que nombrar la branch A explícitamente."
MSG_RBO_NO_LOCAL_FMT='No existe una branch local llamada: %s\n'
MSG_RBO_B_PROMPT="Branch B (destino del rebase; local / remote / tag): "
MSG_RBO_NO_INPUT="Sin entrada; cancelado."
MSG_RBO_INVALID_REF_FMT='Ref destino inválido: %s\n'
MSG_RBO_SAME="A y B apuntan al mismo commit; nada que rebasear."
MSG_RBO_PREVIEW="─── Vista previa ───"
MSG_RBO_NO_EXCLUSIVE="A no tiene commits más allá de B (A es ancestro de B, o el mismo)."
MSG_RBO_FF_OR_NOOP="el rebase será un fast-forward o un no-op."
MSG_RBO_REPLAY_FMT='Commits de A a reaplicar (%d):\n'
MSG_RBO_CONFIRM_FMT='¿Proceder: git switch %s && git rebase %s ?'
MSG_RBO_SWITCHING_FMT='Cambiando a %s...\n'
MSG_RBO_DONE="Listo."

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag (etiqueta este commit)"
MSG_TAG_PURPOSE="Qué:    crea un tag lightweight o annotated apuntando a este commit; opcionalmente lo pushea al remote"
MSG_TAG_WHEN="Cuándo: punto de release / milestone / una referencia estable y con nombre a un commit"
MSG_TAG_CONTRAST="Nota:   annotated lleva mensaje+autor+fecha (recomendado para releases); lightweight es solo un ref"
MSG_TAG_NAME_PROMPT="Nombre del tag (ej. v1.0.0 / release-2024-01): "
MSG_TAG_NO_INPUT="Sin entrada; cancelado."
MSG_TAG_EXISTS_FMT='El tag ya existe: %s\n'
MSG_TAG_KIND_PROMPT="¿annotated (con mensaje) o lightweight? [a]/l (por defecto a): "
MSG_TAG_MSG_PROMPT="Mensaje del tag (Enter = usar el nombre del tag): "
MSG_TAG_CREATED_FMT='Tag creado: %s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='¿Push al remote [%s]? [y/N] '
MSG_TAG_NO_REMOTE="(sin remote configurado; se omite el push)"
MSG_TAG_REFRESH_HINT="Nota: el Git Graph de Zed no vigila los cambios de tags; refresca manualmente (Cmd+Shift+P → reload window, o espera al siguiente commit)."

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete (borra un tag)"
MSG_TAG_DELETE_PURPOSE="Qué:    borra un tag local; opcionalmente también en el remote"
MSG_TAG_DELETE_WHEN="Cuándo: tag erróneo / re-release / limpieza"
MSG_TAG_DELETE_NOTE="Nota:   borrar un tag remote ya pusheado afecta a los demás; local y remote se preguntan por separado"
MSG_TAG_DELETE_AT_HEADER="Tags en este commit:"
MSG_TAG_DELETE_NONE="  (ninguno)"
MSG_TAG_DELETE_NAME_PROMPT="Nombre del tag a borrar (puede estar en otro commit): "
MSG_TAG_DELETE_NO_INPUT="Sin entrada; cancelado."
MSG_TAG_DELETE_NOT_EXIST_FMT='El tag no existe: %s\n'
MSG_TAG_DELETE_ANNOTATED="(tag annotated)"
MSG_TAG_DELETE_PREVIEW_FMT="tag '%s' → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="¿Borrar el tag local '%s'?"
MSG_TAG_DELETE_LOCAL_DONE="Tag local borrado."
MSG_TAG_DELETE_NO_REMOTE="(sin remote configurado; se omite el remote)"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="(no existe ese tag en el remote [%s]; se omite)\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="¿Borrar también del remote [%s]? [y/N] "
MSG_TAG_DELETE_REMOTE_DONE="Tag del remote borrado."

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="Qué:    checkea este commit en un nuevo worktree, agrupado por propósito"
MSG_WT_FROM_NOTE_FMT='propósito: %s'
MSG_WT_FROM_PATH_EXISTS_FMT='La ruta ya existe: %s\n'
MSG_WT_FROM_PATH_HINT="Pista: ejecuta  git worktree list  para inspeccionar los worktrees existentes"
MSG_WT_FROM_BRANCH_EXISTS_FMT='La branch ya existe: %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree creado: %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  branch: %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  limpieza: git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  limpieza: git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='Nombre de la branch (Enter = %s): '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="Qué:    lista los worktrees bajo [%s] y permite pegar un nombre para borrar"
MSG_WT_RM_USAGE_FMT="Cómo:   revisa la lista, pega el nombre (incluyendo el prefijo %s/), luego confirma"
MSG_WT_RM_EMPTY_FMT='[%s] no tiene worktrees para borrar.\n'
MSG_WT_RM_LIST_HEADER_FMT='[%s] worktrees:\n'
MSG_WT_RM_NAME_PROMPT="Pega el nombre del worktree a borrar (copia una línea completa de arriba): "
MSG_WT_RM_NO_INPUT="Sin entrada; cancelado."
MSG_WT_RM_NOT_IN_LIST_FMT="'%s' no está en la lista de worktrees de [%s].\n"
MSG_WT_RM_REMOVING_FMT='Borrando: %s\n'
MSG_WT_RM_DONE="✓ worktree borrado."
MSG_WT_RM_REVIEW_NO_BRANCH="(review está detached; no hay branch para limpiar)"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="¿Borrar también la branch local '%s'? [y/N] "
MSG_WT_RM_BRANCH_DONE="✓ Branch local borrada."
MSG_WT_RM_BRANCH_ABSENT_FMT="(la branch '%s' no existe; posiblemente ya removida por git worktree remove)\n"

# ── branch-checkout.sh ──────────────────────────────────────────
MSG_BRANCH_CHECKOUT_TITLE="branch-checkout (cambia a una branch que apunta a este commit)"
MSG_BRANCH_CHECKOUT_PURPOSE="Qué:   mueve HEAD a una branch local que apunta a este commit"
MSG_BRANCH_CHECKOUT_WHEN="Cuándo: cambiar a una branch existente desde el Git Graph en vez de copiar su nombre al terminal"
MSG_BRANCH_CHECKOUT_NOTE="Nota:  requiere un working tree limpio; no cambia si ya estás en la branch elegida"
MSG_BRANCH_CHECKOUT_DIRTY_TREE="El working tree tiene cambios sin commit; haz commit o stash primero."
MSG_BRANCH_CHECKOUT_NONE="No hay branches locales en este commit para hacer checkout."
MSG_BRANCH_CHECKOUT_ONE_FMT='Única branch en este commit: %s\n'
MSG_BRANCH_CHECKOUT_LIST_HEADER="Branches locales en este commit:"
MSG_BRANCH_CHECKOUT_SELECT_PROMPT="Elige una (nombre de branch o número): "
MSG_BRANCH_CHECKOUT_NO_INPUT="Sin entrada; cancelado."
MSG_BRANCH_CHECKOUT_NOT_IN_LIST_FMT="La branch '%s' no está en la lista de este commit.\n"
MSG_BRANCH_CHECKOUT_ALREADY_FMT='Ya estás en %s; nada que hacer.\n'

# ── branch-rename.sh ────────────────────────────────────────────
MSG_BRANCH_RENAME_TITLE="branch-rename (renombra una branch que apunta a este commit)"
MSG_BRANCH_RENAME_PURPOSE="Qué:   renombra una branch local; opcionalmente la re-pushea al remote (borra el nombre viejo, pushea el nuevo)"
MSG_BRANCH_RENAME_WHEN="Cuándo: corregir un typo / reutilizar una try/* / estandarizar un nombre"
MSG_BRANCH_RENAME_NOTE="Nota:  renombrar en remote son dos operaciones (push nuevo + borrar viejo); coordina con tus colaboradores"
MSG_BRANCH_RENAME_NONE="No hay branches locales en este commit para renombrar."
MSG_BRANCH_RENAME_ONE_FMT='Única branch en este commit: %s\n'
MSG_BRANCH_RENAME_LIST_HEADER="Branches locales en este commit:"
MSG_BRANCH_RENAME_SELECT_PROMPT="Elige una para renombrar (nombre de branch o número): "
MSG_BRANCH_RENAME_NO_INPUT="Sin entrada; cancelado."
MSG_BRANCH_RENAME_NOT_IN_LIST_FMT="La branch '%s' no está en la lista de este commit.\n"
MSG_BRANCH_RENAME_NEW_NAME_PROMPT="Nombre nuevo: "
MSG_BRANCH_RENAME_INVALID_NAME_FMT="Nombre de branch inválido: %s\n"
MSG_BRANCH_RENAME_EXISTS_FMT="La branch ya existe: %s\n"
MSG_BRANCH_RENAME_DONE_FMT="Renombrada: %s → %s\n"
MSG_BRANCH_RENAME_REMOTE_PROMPT_FMT="¿Renombrar también en el remote [%s] (push nuevo + borrar viejo)? [y/N] "
MSG_BRANCH_RENAME_REMOTE_DONE="Rename en remote completado."

# ── copy-branch-name.sh ─────────────────────────────────────────
MSG_COPY_BRANCH_TITLE="copy-branch-name (copia al portapapeles un nombre de branch que apunta a este commit)"
MSG_COPY_BRANCH_PURPOSE="Qué:   pone un nombre de branch en el portapapeles del sistema para pegarlo en otro lado"
MSG_COPY_BRANCH_WHEN="Cuándo: enviar el nombre por chat / pegarlo en la descripción de un PR / usarlo en otro terminal"
MSG_COPY_BRANCH_NOTE="Nota:  usa pbcopy (macOS) / wl-copy / xclip / xsel — el que esté disponible"
MSG_COPY_BRANCH_NONE="No hay branches locales en este commit para copiar."
MSG_COPY_BRANCH_LIST_HEADER="Branches locales en este commit:"
MSG_COPY_BRANCH_SELECT_PROMPT="Elige una (nombre de branch o número): "
MSG_COPY_BRANCH_NO_INPUT="Sin entrada; cancelado."
MSG_COPY_BRANCH_NOT_IN_LIST_FMT="La branch '%s' no está en la lista de este commit.\n"
MSG_COPY_BRANCH_DONE_FMT="Copiada: %s\n"
MSG_COPY_BRANCH_NO_CLIPBOARD="No se encontró utilidad de portapapeles (se necesita pbcopy / wl-copy / xclip / xsel). Nombre de la branch impreso abajo:"

# ── copy-commit-message.sh ──────────────────────────────────────
MSG_COPY_MSG_TITLE="copy-commit-message (copia al portapapeles el message de este commit)"
MSG_COPY_MSG_PURPOSE="Qué:   pone el subject (una línea) o el message completo del commit en el portapapeles del sistema"
MSG_COPY_MSG_WHEN="Cuándo: pegar en notas de release / PR / chat / email"
MSG_COPY_MSG_NOTE="Nota:  usa pbcopy (macOS) / wl-copy / xclip / xsel — el que esté disponible"
MSG_COPY_MSG_KIND_PROMPT="Copiar [s]ubject (por defecto) / message completo [f]: "
MSG_COPY_MSG_KIND_INVALID_FMT="Opción inválida: %s\n"
MSG_COPY_MSG_DONE_FMT='Copiado: %s\n'
MSG_COPY_MSG_NO_CLIPBOARD="No se encontró utilidad de portapapeles (se necesita pbcopy / wl-copy / xclip / xsel). Message impreso abajo:"
