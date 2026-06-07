#!/usr/bin/env bash
# Strings de mensagens em Português Brasileiro para os scripts git-command.
# Carregado por lib.sh; não execute diretamente.
# Convenção de nomes: MSG_<SCRIPT>_<KEY>; sufixo _FMT para templates printf.
# shellcheck shell=bash

# ── lib.sh (internos compartilhados) ────────────────────────────
MSG_LIB_IN_PROGRESS_FMT='Há um %s inacabado em andamento. Execute "%s" ou --continue primeiro.\n'
MSG_LIB_RUN_OR_ABORT_FMT='%s falhou; executando git %s --abort automaticamente (workspace restaurado ao estado anterior).\n'
MSG_LIB_NOT_IN_REPO='Você não está dentro de um repositório git.'
MSG_LIB_NOT_BARE_LAYOUT='O projeto atual não está no layout bare + worktrees; menu de worktree desabilitado.'
MSG_LIB_INIT_HINT='Para habilitar, crie um novo projeto com: bash git-command/init-bare-tree.sh <nome> [<url>]'
MSG_LIB_MIGRATE_HINT='Para projetos existentes: migrate-to-bare-tree.sh (ainda não implementado; migre manualmente).'
MSG_LIB_CLEANUP_FMT='Script encerrou inesperadamente (saída %d); executando git %s --abort automaticamente para reverter.\n'
MSG_LIB_PRESS_ENTER="── pressione Enter para fechar ──"

# ── reword.sh ───────────────────────────────────────────────────
MSG_REWORD_TITLE="reword (reescrever a mensagem deste commit)"
MSG_REWORD_PURPOSE="O quê:  alterar apenas a mensagem do commit; conteúdo dos arquivos e cadeia de SHA permanecem (SHAs descendentes serão reescritos)"
MSG_REWORD_WHEN="Quando: corrigir um typo / seguir a convenção / adicionar referência a issue / ajustar o prefixo do conventional-commit"
MSG_REWORD_CONTRAST="Nota:   para a mensagem do próprio HEAD, edit-commit é mais rápido; reword é para commits mais antigos"
MSG_REWORD_DIRTY_TREE="A working tree tem alterações não commitadas; faça commit ou stash primeiro."
MSG_REWORD_NOT_ANCESTOR_FMT='%s não está na cadeia de ancestrais da branch atual; não é possível fazer reword.\n'
MSG_REWORD_OLD_MSG="Mensagem antiga:"
MSG_REWORD_NEW_MSG_PROMPT="Nova mensagem (digite por linha; linha em branco = quebra de parágrafo; só 'Q' para enviar, ':q' para cancelar):"
MSG_REWORD_CANCELLED="Cancelado."
MSG_REWORD_EMPTY_CANCELLED="Nenhuma entrada; cancelado."

# ── open-files.sh ───────────────────────────────────────────────
MSG_OPEN_FILES_TITLE="open-files (abrir no Zed todos os arquivos tocados por este commit)"
MSG_OPEN_FILES_PURPOSE="O quê:  listar os arquivos alterados por este commit e abrir todos no Zed (versão atual da working tree)"
MSG_OPEN_FILES_WHEN="Quando: depurando um bug histórico; quer ver todos os arquivos envolvidos naquela alteração"
MSG_OPEN_FILES_PREREQ="Requer: CLI do zed no PATH; arquivos que não estão na tree atual são ignorados"
MSG_OPEN_FILES_EMPTY="Este commit não tem alterações de arquivos (possivelmente um commit vazio)."
MSG_OPEN_FILES_MISSING="Os seguintes arquivos não estão mais na working tree (deletados/renomeados), ignorando:"
MSG_OPEN_FILES_ALL_GONE="Nenhum dos arquivos tocados por este commit permanece na working tree."
MSG_OPEN_FILES_OPENING_FMT='Abrindo %d arquivos no Zed:\n'
MSG_OPEN_FILES_NO_ZED="Comando zed não encontrado."
MSG_OPEN_FILES_INSTALL_HINT="No Zed: Cmd+Shift+P → 'zed: install cli' para instalar a CLI do zed."

# ── export-commit-files.sh ──────────────────────────────────────
MSG_EXPORT_FILES_TITLE="export-commit-files (exportar arquivos deste commit para uma pasta)"
MSG_EXPORT_FILES_PURPOSE="O quê:  copiar cada arquivo alterado por este commit (na versão DESTE commit) para uma pasta, preservando os caminhos"
MSG_EXPORT_FILES_WHEN="Quando: arquivos demais para abrir como abas / capturar um snapshot dos artefatos de um commit / diff offline"
MSG_EXPORT_FILES_CONTRAST="Nota:   open-files abre a versão atual da working tree; este exporta a versão histórica deste commit"
MSG_EXPORT_FILES_EMPTY="Este commit não tem alterações de arquivos (possivelmente um commit vazio)."
MSG_EXPORT_FILES_COUNT_FMT='Este commit toca em %d arquivo(s):\n'
MSG_EXPORT_FILES_OVERFLOW_FMT='  ... e mais %d\n'
MSG_EXPORT_FILES_DIR_PROMPT_FMT='Diretório de exportação (relativo à raiz do repo, padrão %s): '
MSG_EXPORT_FILES_DIR_EXISTS_FMT='O diretório existe e não está vazio: %s\n'
MSG_EXPORT_FILES_OVERWRITE_CONFIRM="Continuar pode sobrescrever arquivos de mesmo nome. Continuar?"
MSG_EXPORT_FILES_DELETED_HINT="(deletado neste commit; nada para exportar)"
MSG_EXPORT_FILES_DONE_FMT='Concluído: exportados %d, ignorados %d → %s/\n'
MSG_EXPORT_FILES_DONE_NOTE="Nota: o conteúdo reflete o snapshot deste commit, não a versão atual da working tree."

# ── export-patches.sh ───────────────────────────────────────────
MSG_EXPORT_PATCHES_TITLE="export-patches (exportar N arquivos de patch)"
MSG_EXPORT_PATCHES_PURPOSE="O quê:  exportar N commits para trás a partir daqui como mbox (.patch) ou diff puro (.diff)"
MSG_EXPORT_PATCHES_WHEN="Quando: colaboração por email / fazer backup de alterações específicas / enviar para outros usarem com git am / git apply"
MSG_EXPORT_PATCHES_OUTPUT="Saída:  diretório escolhido (padrão ./patches); o histórico nunca é modificado"
MSG_EXPORT_PATCHES_FORMAT_PROMPT="Formato [f]ormat-patch (.patch, git am) / [d]iff (.diff, git apply) (padrão f): "
MSG_EXPORT_PATCHES_FORMAT_INVALID_FMT='Formato inválido: %s\n'
MSG_EXPORT_PATCHES_COUNT_PROMPT="Quantos commits para trás (padrão 1): "
MSG_EXPORT_PATCHES_COUNT_INVALID_FMT='Quantidade inválida: %s\n'
MSG_EXPORT_PATCHES_OUTDIR_PROMPT="Diretório de saída (relativo à raiz do repo, padrão ./patches): "
MSG_EXPORT_PATCHES_FORMAT_LABEL="Formato:"
MSG_EXPORT_PATCHES_RANGE_LABEL="Intervalo:"
MSG_EXPORT_PATCHES_OUTPUT_LABEL="Saída:"
MSG_EXPORT_PATCHES_ROOT_PLACEHOLDER="(raiz)"
MSG_EXPORT_PATCHES_CONTINUE="Continuar?"

# ── reset-soft.sh ───────────────────────────────────────────────
MSG_RESET_SOFT_TITLE="reset-soft (soft reset para este commit · alterações vão para o staging)"
MSG_RESET_SOFT_PURPOSE="O quê:  move HEAD para este commit; as alterações dos commits intermediários ficam no index (nada é perdido)"
MSG_RESET_SOFT_WHEN="Quando: quer reempacotar os últimos N commits (re-dividir / mudar mensagem / mesclar)"
MSG_RESET_SOFT_AFTER="Depois: git status para inspecionar o index, então faça commit de um novo histórico"
MSG_RESET_SOFT_NOT_ANCESTOR_FMT='%s não está na cadeia de ancestrais do HEAD; soft reset não faz sentido.\n'
MSG_RESET_SOFT_IS_HEAD_FMT='%s já é o HEAD; nenhum reset necessário.\n'
MSG_RESET_SOFT_CURRENT_BRANCH_FMT='Branch atual: %s\n'
MSG_RESET_SOFT_WILL_DROP_FMT='Os seguintes commits serão descartados (suas alterações vão para o index, HEAD → %s):\n'
MSG_RESET_SOFT_CONFIRM_FMT='Soft reset para %s?'
MSG_RESET_SOFT_DONE="Concluído. As alterações estão no index; verifique com git status, faça commit novamente para registrar."

# ── reset-hard.sh ───────────────────────────────────────────────
MSG_RESET_HARD_TITLE="reset-hard (hard reset para este commit · DESTRUTIVO)"
MSG_RESET_HARD_PURPOSE="O quê:  move HEAD para este commit; DESCARTA commits intermediários E todas as alterações da working tree"
MSG_RESET_HARD_WHEN="Quando: quer voltar completamente a um estado e tem certeza de que quer perder todas as alterações intermediárias"
MSG_RESET_HARD_AFTER="Depois: irrecuperável (a não ser via git reflog em até 30 dias; exige digitar YES em maiúsculas)"
MSG_RESET_HARD_NOT_ANCESTOR_FMT='%s não está na cadeia de ancestrais do HEAD; recusado.\n'
MSG_RESET_HARD_IS_HEAD_FMT='%s já é o HEAD; nenhum reset necessário.\n'
MSG_RESET_HARD_CURRENT_BRANCH_FMT='Branch atual: %s\n'
MSG_RESET_HARD_WILL_DROP="Os seguintes commits serão descartados (irrecuperáveis exceto via reflog):"
MSG_RESET_HARD_WT_LOST="As alterações da working tree também serão descartadas:"
MSG_RESET_HARD_YES_PROMPT_FMT='Digite YES (em maiúsculas) para confirmar o hard reset para %s: '
MSG_RESET_HARD_NO_YES="YES não digitado; cancelado."
MSG_RESET_HARD_REFLOG_HINT="Dica: o reflog ainda pode recuperar esses commits; em até 30 dias consulte git reflog → HEAD@{N}."

# ── rebase-i.sh ─────────────────────────────────────────────────
MSG_REBASE_I_TITLE="rebase-i (rebase interativo até este commit)"
MSG_REBASE_I_PURPOSE='O quê:  inicia git rebase -i SHA^, abre o $EDITOR para editar manualmente o todo'
MSG_REBASE_I_WHEN="Quando: reordenar / mesclar / editar / descartar manualmente múltiplos commits; complexo demais para o menu padrão"
MSG_REBASE_I_PREREQ="Requer: a working tree precisa estar limpa; em caso de conflitos, trate manualmente ou conte com o abort do trap EXIT"
MSG_REBASE_I_RANGE_FMT='Iniciando rebase interativo, intervalo: %s^..HEAD\n'
MSG_REBASE_I_DIRTY_TREE="A working tree tem alterações não commitadas; faça commit ou stash primeiro."
MSG_REBASE_I_CONTINUE="Continuar?"

# ── revert.sh ───────────────────────────────────────────────────
MSG_REVERT_TITLE="revert (criar um commit inverso para desfazer este)"
MSG_REVERT_PURPOSE="O quê:  não reescreve o histórico; adiciona um novo commit em cima do HEAD com o inverso das alterações deste commit"
MSG_REVERT_WHEN="Quando: um commit já enviado (push) precisa ser desfeito (reset reescreveria o histórico público)"
MSG_REVERT_CONTRAST="Nota:   reset reescreve o histórico; revert acrescenta a ele. Aborta automaticamente em conflitos."
MSG_REVERT_DIRTY_TREE="A working tree tem alterações não commitadas; faça commit ou stash primeiro."
MSG_REVERT_CONFIRM_FMT='Gerar um commit inverso em cima do HEAD para desfazer %s?\n'

# ── cherry-pick.sh ──────────────────────────────────────────────
MSG_CHERRY_PICK_TITLE="cherry-pick (copiar este commit para o topo da branch atual)"
MSG_CHERRY_PICK_PURPOSE="O quê:  copia as alterações deste commit para o topo da branch atual como um novo commit (novo SHA)"
MSG_CHERRY_PICK_WHEN="Quando: levar um hotfix entre branches / pegar um único commit de um colega / recuperar via reflog"
MSG_CHERRY_PICK_NOTE="Nota:   o commit de origem não é deletado; na mesma branch não faz sentido; aborta automaticamente em conflito"
MSG_CHERRY_PICK_CURRENT_FMT='Branch atual: %s\n'
MSG_CHERRY_PICK_DIRTY_TREE="A working tree tem alterações não commitadas; faça commit ou stash primeiro."
MSG_CHERRY_PICK_CONFIRM_FMT='Cherry-pick de %s sobre %s?'

# ── branch-from.sh ──────────────────────────────────────────────
MSG_BRANCH_FROM_TITLE="branch-from (criar uma nova branch a partir deste commit)"
MSG_BRANCH_FROM_PURPOSE="O quê:  cria uma nova branch neste commit e muda para ela"
MSG_BRANCH_FROM_WHEN="Quando: iniciar uma nova linha de trabalho a partir de um commit antigo / manter um ref nomeado para um estado específico"
MSG_BRANCH_FROM_CONTRAST="Nota:   para experimentos descartáveis use try-branch (prefixo try/ automático + dica de cleanup)"
MSG_BRANCH_FROM_NAME_PROMPT="Nome da nova branch (baseada neste commit): "
MSG_BRANCH_FROM_NO_NAME="Nome da branch não informado; cancelado."

# ── try-branch.sh ───────────────────────────────────────────────
MSG_TRY_BRANCH_TITLE="try-branch (branch descartável a partir deste commit)"
MSG_TRY_BRANCH_PURPOSE="O quê:  cria uma branch chamada try/<base-slug>-<sha> a partir deste commit, troca imediatamente"
MSG_TRY_BRANCH_WHEN="Quando: experimentar sem poluir a branch atual / inspecionar o estado em um commit antigo"
MSG_TRY_BRANCH_HINT="Dica:   ao sair, imprime os comandos de 'voltar para a original' + 'deletar esta branch' como lembrete"
MSG_TRY_BRANCH_DETACHED_HINT="git switch -  # estava detached; consulte o reflog"
MSG_TRY_BRANCH_FROM_FMT='Branch original: %s\nPonto de partida: %s\n'
MSG_TRY_BRANCH_NAME_PROMPT_FMT='Nome da nova branch (Enter = %s): '
MSG_TRY_BRANCH_EXISTS_FMT='Branch já existe: %s\n'
MSG_TRY_BRANCH_SWITCH_PROMPT="Mudar para ela após criar? [Y/n] "
MSG_TRY_BRANCH_CREATED_FMT='Criada %s (sem mudar)\n'
MSG_TRY_BRANCH_CLEANUP_HEADER="Quando terminar, faça o cleanup com:"
MSG_TRY_BRANCH_CLEANUP_RETURN_FMT='  voltar para a original: %s\n'
MSG_TRY_BRANCH_CLEANUP_DELETE_FMT='  deletar esta branch:    git branch -D %s\n'

# ── stash-push.sh ───────────────────────────────────────────────
MSG_STASH_PUSH_TITLE="stash-push (guardar alterações atuais com um nome)"
MSG_STASH_PUSH_PURPOSE="O quê:  guarda no stash as alterações rastreadas com um rótulo, deixando a working tree limpa"
MSG_STASH_PUSH_WHEN="Quando: prestes a trocar de branch com WIP / deixar o trabalho de lado brevemente / fazer pré-limpeza antes de um reset"
MSG_STASH_PUSH_NOTE="Nota:   -u NÃO é usado; arquivos untracked permanecem na working tree (evita nodes espúrios de snapshot no Git Graph)"
MSG_STASH_PUSH_CLEAN="A working tree está limpa; nada para guardar no stash."
MSG_STASH_PUSH_WILL_STASH="As seguintes alterações serão guardadas no stash:"
MSG_STASH_PUSH_NAME_PROMPT="Escolha um nome (ajuda a encontrar depois): "
MSG_STASH_PUSH_NO_NAME="Nome não informado; cancelado."
MSG_STASH_PUSH_DONE_HINT="Concluído. Ver: git stash list, ou use o menu 'Pop most recent stash'."
MSG_STASH_PUSH_UNTRACKED_NOTE="Nota: arquivos untracked NÃO foram guardados no stash e permanecem na working tree."

# ── stash-pop.sh ────────────────────────────────────────────────
MSG_STASH_POP_TITLE="stash-pop (aplicar o stash mais recente na working tree)"
MSG_STASH_POP_PURPOSE="O quê:  aplica stash@{0} na working tree; em caso de sucesso, o stash é descartado automaticamente"
MSG_STASH_POP_WHEN="Quando: alterações guardadas anteriormente precisam ser retomadas"
MSG_STASH_POP_NOTE="Nota:   em caso de conflito o stash NÃO é descartado automaticamente; resolva os conflitos e execute git stash drop"
MSG_STASH_POP_EMPTY="Nenhum stash disponível para pop."
MSG_STASH_POP_LIST_HEADER="Stashes recentes:"
MSG_STASH_POP_PREVIEW_HEADER="Preview de stash@{0}:"
MSG_STASH_POP_CONFIRM="Fazer pop de stash@{0} na working tree atual?"
MSG_STASH_POP_CONFLICT="O pop encontrou conflitos — o stash foi preservado (não descartado automaticamente)."
MSG_STASH_POP_CONFLICT_HINT="Resolva os conflitos + git add, depois execute  git stash drop  para descartá-lo."

# ── branch-delete.sh ────────────────────────────────────────────
MSG_BRANCH_DELETE_TITLE="branch-delete (deletar branches locais apontando para este commit)"
MSG_BRANCH_DELETE_PURPOSE="O quê:  deleta uma branch local (opcionalmente também a remota)"
MSG_BRANCH_DELETE_WHEN="Quando: organizar branches mescladas/descartáveis; podar em massa try/* feat/* etc."
MSG_BRANCH_DELETE_NOTE="Nota:   usa git branch -D (force delete; ignora o status de merge)"
MSG_BRANCH_DELETE_NONE="Nenhuma branch local neste commit para deletar."
MSG_BRANCH_DELETE_ONE_FMT='Única branch neste commit: %s\n'
MSG_BRANCH_DELETE_LIST_HEADER="Branches locais neste commit:"
MSG_BRANCH_DELETE_SELECT_PROMPT="Escolha uma (nome da branch ou número): "
MSG_BRANCH_DELETE_NO_INPUT="Nenhuma entrada; cancelado."
MSG_BRANCH_DELETE_NOT_IN_LIST_FMT="A branch '%s' não está na lista deste commit.\n"
MSG_BRANCH_DELETE_IS_CURRENT_FMT="Não é possível deletar a branch atualmente em uso '%s'.\n"
MSG_BRANCH_DELETE_CURRENT_HINT="Mude para outra branch primeiro: git switch <outra-branch>"
MSG_BRANCH_DELETE_CONFIRM_FMT="Deletar a branch local '%s'?"
MSG_BRANCH_DELETE_LOCAL_DONE="Branch local deletada."
MSG_BRANCH_DELETE_NO_REMOTE="(nenhum remote configurado; ignorando remote)"
MSG_BRANCH_DELETE_REMOTE_ABSENT_FMT="(branch não presente no remote [%s]; ignorando)"
MSG_BRANCH_DELETE_REMOTE_PROMPT_FMT="Deletar também do remote [%s]? [y/N] "
MSG_BRANCH_DELETE_REMOTE_DONE="Branch remota deletada."

# ── edit-commit.sh ──────────────────────────────────────────────
MSG_EDIT_COMMIT_TITLE="edit-commit (editar os metadados / lista de arquivos deste commit)"
MSG_EDIT_COMMIT_HEAD_PATH="Caminho HEAD:    a working tree pode estar suja; amend direto; mudar mensagem / adicionar / remover / modificar arquivos"
MSG_EDIT_COMMIT_OLD_PATH="Commit antigo:   a working tree precisa estar limpa; suporta mensagem / adicionar (untracked) / remover arquivos"
MSG_EDIT_COMMIT_NOT_SUITED="Não adequado (commit antigo): modificar o conteúdo de arquivos existentes → use o menu fixup (veja o comentário do cabeçalho para entender o motivo)"
MSG_EDIT_COMMIT_FILE_OPS_HEADER="Uma operação por linha, finalize com 'Q' em uma linha sozinha:"
MSG_EDIT_COMMIT_FILE_OPS_ADD="  +:caminho/do/arquivo    git add (adicionar / atualizar / staging de qualquer alteração)"
MSG_EDIT_COMMIT_FILE_OPS_REMOVE="  -:caminho/do/arquivo    remover deste commit (mantém em disco, git rm --cached)"
MSG_EDIT_COMMIT_FILE_OPS_DONE="  Q                       pronto"
MSG_EDIT_COMMIT_FILE_FMT_ERR_FMT='  ignorando erro de formato: %s\n'
MSG_EDIT_COMMIT_FILE_NOT_EXIST_FMT='  ignorando +%s  (arquivo não existe)\n'
MSG_EDIT_COMMIT_FILE_ADD_OK_FMT='  add  %s\n'
MSG_EDIT_COMMIT_FILE_ADD_FAIL_FMT='  ignorando +%s  (git add falhou)\n'
MSG_EDIT_COMMIT_FILE_RM_OK_FMT='  rm   %s  (removido do commit, mantido em disco)\n'
MSG_EDIT_COMMIT_FILE_RM_FAIL_FMT='  ignorando -%s  (não está neste commit)\n'
MSG_EDIT_COMMIT_ASK_MSG="Nova mensagem (por linha; só 'Q' para enviar; apenas Q = manter inalterada):"
MSG_EDIT_COMMIT_HEAD_HEADER="─── Caminho rápido para HEAD ───"
MSG_EDIT_COMMIT_HEAD_NOTE_TARGET="Alvo é o HEAD, nenhum rebase necessário:"
MSG_EDIT_COMMIT_HEAD_NOTE_DIRTY="  · a working tree pode estar suja (alterações viram candidatas a amend)"
MSG_EDIT_COMMIT_HEAD_NOTE_CHANGES="  · adicionar / modificar / remover arquivos livremente; sem risco de conflito downstream"
MSG_EDIT_COMMIT_HEAD_CUR_MSG="─── mensagem atual ───"
MSG_EDIT_COMMIT_HEAD_CUR_CHANGES="─── alterações atuais em working/staged ───"
MSG_EDIT_COMMIT_HEAD_ASK_MSG="Mudar a mensagem? [y/N] "
MSG_EDIT_COMMIT_HEAD_ASK_FILES="Mudar arquivos (adicionar/remover/modificar)? [y/N] "
MSG_EDIT_COMMIT_NO_CHANGES="(nenhuma alteração; não fará amend; saindo.)"
MSG_EDIT_COMMIT_UNSTAGED_HINT="Nota: a working tree ainda tem alterações não staged; o amend NÃO vai incluí-las."
MSG_EDIT_COMMIT_AMEND_MSG_FILES="Amend aplicado (nova mensagem + alterações de arquivo)"
MSG_EDIT_COMMIT_AMEND_MSG="Amend aplicado (nova mensagem)"
MSG_EDIT_COMMIT_AMEND_FILES="Amend aplicado (alterações de arquivo)"
MSG_EDIT_COMMIT_OLD_DIRTY_TREE_BLOCK='A working tree tem alterações não commitadas.

Se você quer mesclar essas alterações neste commit → use o menu:
  "Fold working/staged changes into this commit (fixup+autosquash)"

Se realmente quer este menu (mudar mensagem / adicionar novos arquivos / remover arquivos), faça commit ou stash primeiro.'
MSG_EDIT_COMMIT_OLD_NOT_ANCESTOR_FMT='%s não está na cadeia de ancestrais da branch atual.\n'
MSG_EDIT_COMMIT_OLD_HEADER="─── Caminho de commit antigo (rebase) ───"
MSG_EDIT_COMMIT_OLD_NOTE_APPLIES="Aplica-se a: mensagem / adicionar novos arquivos (untracked) / remover arquivos"
MSG_EDIT_COMMIT_OLD_NOTE_NOT_APPLIES="NÃO se aplica a: modificar o conteúdo de arquivos existentes (use o menu fixup)"
MSG_EDIT_COMMIT_OLD_CONTINUE="Continuar?"
MSG_EDIT_COMMIT_OLD_REBASE_NOT_EDIT="o rebase não entrou no estado de edit."
MSG_EDIT_COMMIT_OLD_CUR_MSG="─── mensagem atual do commit ───"
MSG_EDIT_COMMIT_OLD_ASK_MSG="Mudar a mensagem? [y/N] "
MSG_EDIT_COMMIT_OLD_ASK_FILES="Mudar arquivos (adicionar/remover)? [y/N] "
MSG_EDIT_COMMIT_OLD_NO_CHANGES="(nenhuma alteração; finalizando)"
MSG_EDIT_COMMIT_OLD_CONTINUE_FAIL="rebase --continue falhou (provavelmente um conflito downstream de modificação/exclusão contra um arquivo que você acabou de remover)."
MSG_EDIT_COMMIT_OLD_REBASE_DONE="rebase concluído"

# ── squash-n.sh ─────────────────────────────────────────────────
MSG_SQUASH_TITLE="squash-n (squash de N commits para frente a partir deste commit)"
MSG_SQUASH_PURPOSE="O quê:  faz squash deste commit e dos N-1 ancestrais em um só; commits descendentes são reaplicados em cima"
MSG_SQUASH_WHEN="Quando: organizar commits WIP / compactar ruído / mesclar vários commits pequenos relacionados"
MSG_SQUASH_PREREQ="Requer: a working tree precisa estar limpa; SHAs descendentes mudam; aborta automaticamente em conflito"
MSG_SQUASH_DIRTY_TREE="A working tree tem alterações não commitadas; faça commit ou stash primeiro."
MSG_SQUASH_COUNT_PROMPT="Quantos para fazer squash (incluindo este commit, padrão 2): "
MSG_SQUASH_MIN_TWO="É necessário ao menos 2 commits para que o squash faça sentido."
MSG_SQUASH_TOO_MANY_FMT='Este commit tem apenas %d ancestral(is) incluindo a si mesmo; no máximo %d.\n'
MSG_SQUASH_PREVIEW_FMT='Os seguintes %d commit(s) sofrerão squash (antigo → novo):\n'
MSG_SQUASH_MSG_PROMPT="Nova mensagem de commit (por linha; só Q para enviar; apenas Q = abrir editor com concatenação padrão; :q para cancelar):"
MSG_SQUASH_CANCELLED="Cancelado."
MSG_SQUASH_CONTINUE="Continuar?"

# ── drop-commit.sh ──────────────────────────────────────────────
MSG_DROP_TITLE="drop-commit (deletar este commit do histórico)"
MSG_DROP_PURPOSE="O quê:  remove este commit do histórico da branch; commits descendentes são reaplicados (novos SHAs)"
MSG_DROP_WHEN="Quando: commit acidental (senhas / código de debug) / WIP inútil / duplicado / experimento a apagar"
MSG_DROP_CONTRAST="Nota:   revert adiciona um commit inverso (mantém o histórico); drop remove de verdade (reescreve o histórico)"
MSG_DROP_DIRTY_TREE="A working tree tem alterações não commitadas; faça commit ou stash primeiro."
MSG_DROP_NOT_ANCESTOR_FMT='%s não está na cadeia de ancestrais da branch atual.\n'
MSG_DROP_ROOT_COMMIT_FMT='%s é o commit raiz, não tem parent; o rebase não pode removê-lo.\n'
MSG_DROP_ROOT_HINT="Remover de verdade o commit raiz requer git update-ref etc.; trate manualmente."
MSG_DROP_WILL_REMOVE="Será removido:"
MSG_DROP_DOWNSTREAM_FMT='%d commit(s) descendente(s) será(ão) reaplicado(s) (SHAs mudam):\n'
MSG_DROP_DOWNSTREAM_HINT="  (se alterações descendentes dependem deste commit → aborta automaticamente em conflito)"
MSG_DROP_IS_HEAD_NOTE="(este commit é o HEAD → caminho rápido via git reset --hard HEAD~; sem rebase)"
MSG_DROP_CONFIRM="Confirmar remoção?"
MSG_DROP_DONE_HEAD="Concluído. HEAD movido para o commit anterior."
MSG_DROP_DONE_REBASE="Concluído. O commit foi removido do histórico."

# ── fixup.sh ────────────────────────────────────────────────────
MSG_FIXUP_TITLE="fixup (mesclar as alterações da working tree neste commit)"
MSG_FIXUP_PURPOSE="O quê:  cria um commit fixup + autosquash, mesclando as alterações da working tree neste commit"
MSG_FIXUP_WHEN="Quando: você editou arquivos e quer que eles caiam em um commit antigo (muito comum); evita poluir o histórico"
MSG_FIXUP_PREREQ="Requer: a working tree / staging precisa ter alterações; aborta automaticamente em conflito"
MSG_FIXUP_NOT_ANCESTOR_FMT='%s não está na cadeia de ancestrais da branch atual.\n'
MSG_FIXUP_NO_CHANGES="A working tree está limpa; nada para mesclar."
MSG_FIXUP_WORKFLOW_HINT="Fluxo: edite os arquivos → use este menu → escolha o commit alvo → fixup + autosquash automáticos."
MSG_FIXUP_WILL_FOLD="Alterações a mesclar neste commit:"
MSG_FIXUP_ASK_INCLUDE_UNSTAGED="O index já tem conteúdo; incluir também alterações não staged? [y/N] "
MSG_FIXUP_ASK_ADD_ALL="O index está vazio; git add -A em tudo e então fixup? [Y/n] "
MSG_FIXUP_EMPTY_INDEX="O index está vazio; nada para fazer fixup; cancelado."
MSG_FIXUP_TARGET_FMT='Alvo: %s  "%s"\n'
MSG_FIXUP_CONFIRM="Confirmar fixup + autosquash? [Y/n] "
MSG_FIXUP_CANCELLED="Cancelado; estado do index preservado."
MSG_FIXUP_CREATED="  + commit fixup criado"
MSG_FIXUP_DONE_FMT='Concluído. Alterações mescladas em %s (SHA atualizado após o autosquash).\n'

# ── commit-fixup-into.sh ────────────────────────────────────────
MSG_CFIX_TITLE="commit→fixup (mesclar este commit em um ancestral)"
MSG_CFIX_PURPOSE="O quê:  pega este commit e aplica como fixup sobre um commit anterior na mesma branch"
MSG_CFIX_WHEN="Quando: um fix no HEAD na verdade pertence a um commit anterior; mande-o para casa"
MSG_CFIX_CONTRAST="Nota:   fixup.sh usa alterações da working tree; este menu usa um commit existente"
MSG_CFIX_DIRTY_TREE="A working tree tem alterações não commitadas; faça commit ou stash primeiro."
MSG_CFIX_NOT_ANCESTOR_SRC="O commit de origem não está na cadeia de ancestrais da branch atual."
MSG_CFIX_HEADER="Mesclar este commit (fixup) em outro commit."
MSG_CFIX_TARGET_HINT="O alvo precisa ser um ancestral da origem (anterior no histórico). Dica: copie o SHA do alvo no Graph do Zed."
MSG_CFIX_TARGET_PROMPT="SHA do commit alvo (curto ou longo): "
MSG_CFIX_NO_INPUT="Nenhuma entrada; cancelado."
MSG_CFIX_INVALID_SHA_FMT='SHA inválido: %s\n'
MSG_CFIX_SAME_COMMIT="Alvo e origem são iguais; não faz sentido."
MSG_CFIX_NOT_ANCESTOR_TGT_FMT='%s não é um ancestral do commit de origem (não dá para fazer fixup nele).\n'
MSG_CFIX_PREVIEW="─── preview ───"
MSG_CFIX_SOURCE_LABEL="Origem:"
MSG_CFIX_TARGET_LABEL="Alvo:"
MSG_CFIX_RANGE_LABEL="intervalo do rebase (antigo → novo):"
MSG_CFIX_CONTINUE="Continuar?"
MSG_CFIX_DONE="Concluído. Origem mesclada no alvo (SHA do commit alvo atualizado)."

# ── rebase-branch-onto.sh ───────────────────────────────────────
MSG_RBO_TITLE="rebase-branch-onto (rebase da branch A sobre a branch B)"
MSG_RBO_PURPOSE="O quê:  git switch A && git rebase B; os commits exclusivos de A são reaplicados no topo de B"
MSG_RBO_WHEN="Quando: A é uma feature branch, B é main/develop; atualizar A até o topo de B"
MSG_RBO_NOTE="Nota:   os commits de A são reescritos (novos SHAs); aborta automaticamente em conflito"
MSG_RBO_DIRTY_TREE="A working tree tem alterações não commitadas; faça commit ou stash primeiro."
MSG_RBO_LOCAL_BRANCHES="Branches locais:"
MSG_RBO_A_PROMPT_FMT='Branch A (a ser rebaseada; Enter = a atual %s): '
MSG_RBO_DETACHED_ERR="Atualmente em HEAD detached; você precisa informar a branch A explicitamente."
MSG_RBO_NO_LOCAL_FMT='Nenhuma branch local chamada: %s\n'
MSG_RBO_B_PROMPT="Branch B (alvo do rebase; local / remote / tag): "
MSG_RBO_NO_INPUT="Nenhuma entrada; cancelado."
MSG_RBO_INVALID_REF_FMT='Ref alvo inválido: %s\n'
MSG_RBO_SAME="A e B apontam para o mesmo commit; nada para rebase."
MSG_RBO_PREVIEW="─── Preview ───"
MSG_RBO_NO_EXCLUSIVE="A não tem commits além de B (A é ancestral de B, ou são iguais)."
MSG_RBO_FF_OR_NOOP="o rebase será um fast-forward ou um no-op."
MSG_RBO_REPLAY_FMT='Commits de A a reaplicar (%d):\n'
MSG_RBO_CONFIRM_FMT='Prosseguir: git switch %s && git rebase %s ?'
MSG_RBO_SWITCHING_FMT='Mudando para %s...\n'
MSG_RBO_DONE="Concluído."

# ── tag.sh ──────────────────────────────────────────────────────
MSG_TAG_TITLE="tag (criar tag neste commit)"
MSG_TAG_PURPOSE="O quê:  cria uma tag lightweight ou annotated apontando para este commit; opcionalmente envia para o remote"
MSG_TAG_WHEN="Quando: ponto de release / milestone / uma referência nomeada estável para um commit"
MSG_TAG_CONTRAST="Nota:   annotated carrega mensagem+autor+horário (recomendado para releases); lightweight é só um ref"
MSG_TAG_NAME_PROMPT="Nome da tag (ex.: v1.0.0 / release-2024-01): "
MSG_TAG_NO_INPUT="Nenhuma entrada; cancelado."
MSG_TAG_EXISTS_FMT='Tag já existe: %s\n'
MSG_TAG_KIND_PROMPT="annotated (com mensagem) ou lightweight? [a]/l (padrão a): "
MSG_TAG_MSG_PROMPT="Mensagem da tag (Enter = usar o nome da tag): "
MSG_TAG_CREATED_FMT='Tag criada: %s → %s\n'
MSG_TAG_PUSH_PROMPT_FMT='Enviar para o remote [%s]? [y/N] '
MSG_TAG_NO_REMOTE="(nenhum remote configurado; ignorando push)"
MSG_TAG_REFRESH_HINT="Nota: o Git Graph do Zed não observa alterações de tags; atualize manualmente (Cmd+Shift+P → reload window, ou espere o próximo commit)."

# ── tag-delete.sh ───────────────────────────────────────────────
MSG_TAG_DELETE_TITLE="tag-delete (deletar uma tag)"
MSG_TAG_DELETE_PURPOSE="O quê:  deleta uma tag local; opcionalmente deleta também no remote"
MSG_TAG_DELETE_WHEN="Quando: tag errada / re-release / limpeza"
MSG_TAG_DELETE_NOTE="Nota:   deletar uma tag remota já publicada afeta outras pessoas; local + remote são perguntados separadamente"
MSG_TAG_DELETE_AT_HEADER="Tags neste commit:"
MSG_TAG_DELETE_NONE="  (nenhuma)"
MSG_TAG_DELETE_NAME_PROMPT="Nome da tag a deletar (pode estar em outro commit): "
MSG_TAG_DELETE_NO_INPUT="Nenhuma entrada; cancelado."
MSG_TAG_DELETE_NOT_EXIST_FMT='A tag não existe: %s\n'
MSG_TAG_DELETE_ANNOTATED="(tag annotated)"
MSG_TAG_DELETE_PREVIEW_FMT="tag '%s' → %s  %s\n"
MSG_TAG_DELETE_CONFIRM_FMT="Deletar a tag local '%s'?"
MSG_TAG_DELETE_LOCAL_DONE="Tag local deletada."
MSG_TAG_DELETE_NO_REMOTE="(nenhum remote configurado; ignorando remote)"
MSG_TAG_DELETE_REMOTE_ABSENT_FMT="(tag inexistente no remote [%s]; ignorando)\n"
MSG_TAG_DELETE_REMOTE_PROMPT_FMT="Deletar também do remote [%s]? [y/N] "
MSG_TAG_DELETE_REMOTE_DONE="Tag remota deletada."

# ── worktree-from.sh ────────────────────────────────────────────
MSG_WT_FROM_TITLE_FMT="worktree-from [%s]"
MSG_WT_FROM_PURPOSE="O quê:  faz checkout deste commit em um novo worktree, agrupado por propósito"
MSG_WT_FROM_NOTE_FMT='propósito: %s'
MSG_WT_FROM_PATH_EXISTS_FMT='O caminho já existe: %s\n'
MSG_WT_FROM_PATH_HINT="Dica: execute  git worktree list  para inspecionar os worktrees existentes"
MSG_WT_FROM_BRANCH_EXISTS_FMT='Branch já existe: %s\n'
MSG_WT_FROM_CREATED_FMT='✓ worktree criado: %s\n'
MSG_WT_FROM_BRANCH_LABEL_FMT='  branch: %s\n'
MSG_WT_FROM_CLEANUP_REVIEW_FMT='  cleanup: git worktree remove "%s"\n'
MSG_WT_FROM_CLEANUP_BRANCH_FMT='  cleanup: git worktree remove "%s" && git branch -D "%s"\n'
MSG_WT_FROM_NAME_PROMPT_FMT='Nome da branch (Enter = %s): '

# ── worktree-remove.sh ──────────────────────────────────────────
MSG_WT_RM_TITLE_FMT="worktree-remove [%s]"
MSG_WT_RM_PURPOSE_FMT="O quê:  lista os worktrees sob [%s] e permite ao usuário colar um nome para deletar"
MSG_WT_RM_USAGE_FMT="Como:   confira a lista, cole o nome (incluindo o prefixo %s/), depois confirme"
MSG_WT_RM_EMPTY_FMT='[%s] não tem worktree para remover.\n'
MSG_WT_RM_LIST_HEADER_FMT='[%s] worktrees:\n'
MSG_WT_RM_NAME_PROMPT="Cole o nome do worktree a deletar (copie uma linha inteira de cima): "
MSG_WT_RM_NO_INPUT="Nenhuma entrada; cancelado."
MSG_WT_RM_NOT_IN_LIST_FMT="'%s' não está na lista de worktrees de [%s].\n"
MSG_WT_RM_REMOVING_FMT='Removendo: %s\n'
MSG_WT_RM_DONE="✓ worktree removido."
MSG_WT_RM_REVIEW_NO_BRANCH="(o review está detached; sem branch para limpar)"
MSG_WT_RM_ALSO_DEL_BRANCH_FMT="Deletar também a branch local '%s'? [y/N] "
MSG_WT_RM_BRANCH_DONE="✓ Branch local deletada."
MSG_WT_RM_BRANCH_ABSENT_FMT="(a branch '%s' não existe; possivelmente já removida pelo git worktree remove)\n"

# ── branch-checkout.sh ──────────────────────────────────────────
MSG_BRANCH_CHECKOUT_TITLE="branch-checkout (mudar para uma branch apontando neste commit)"
MSG_BRANCH_CHECKOUT_PURPOSE="O quê:  move o HEAD para uma branch local que aponta para este commit"
MSG_BRANCH_CHECKOUT_WHEN="Quando: ir para uma branch existente direto do Git Graph em vez de copiar o nome para o terminal"
MSG_BRANCH_CHECKOUT_NOTE="Nota:   exige uma working tree limpa; não troca se você já estiver na branch escolhida"
MSG_BRANCH_CHECKOUT_DIRTY_TREE="A working tree tem alterações não commitadas; faça commit ou stash primeiro."
MSG_BRANCH_CHECKOUT_NONE="Nenhuma branch local neste commit para fazer checkout."
MSG_BRANCH_CHECKOUT_ONE_FMT='Única branch neste commit: %s\n'
MSG_BRANCH_CHECKOUT_LIST_HEADER="Branches locais neste commit:"
MSG_BRANCH_CHECKOUT_SELECT_PROMPT="Escolha uma (nome da branch ou número): "
MSG_BRANCH_CHECKOUT_NO_INPUT="Nenhuma entrada; cancelado."
MSG_BRANCH_CHECKOUT_NOT_IN_LIST_FMT="A branch '%s' não está na lista deste commit.\n"
MSG_BRANCH_CHECKOUT_ALREADY_FMT='Você já está em %s; nada a fazer.\n'

# ── branch-rename.sh ────────────────────────────────────────────
MSG_BRANCH_RENAME_TITLE="branch-rename (renomear uma branch apontando neste commit)"
MSG_BRANCH_RENAME_PURPOSE="O quê:  renomeia uma branch local; opcionalmente refaz o push no remote (apaga o nome antigo, faz push do novo)"
MSG_BRANCH_RENAME_WHEN="Quando: corrigir um typo / reaproveitar uma try/* / padronizar um nome"
MSG_BRANCH_RENAME_NOTE="Nota:   renomear no remote são duas operações (push do novo + delete do antigo); combine com os colaboradores"
MSG_BRANCH_RENAME_NONE="Nenhuma branch local neste commit para renomear."
MSG_BRANCH_RENAME_ONE_FMT='Única branch neste commit: %s\n'
MSG_BRANCH_RENAME_LIST_HEADER="Branches locais neste commit:"
MSG_BRANCH_RENAME_SELECT_PROMPT="Escolha uma para renomear (nome da branch ou número): "
MSG_BRANCH_RENAME_NO_INPUT="Nenhuma entrada; cancelado."
MSG_BRANCH_RENAME_NOT_IN_LIST_FMT="A branch '%s' não está na lista deste commit.\n"
MSG_BRANCH_RENAME_NEW_NAME_PROMPT="Novo nome: "
MSG_BRANCH_RENAME_INVALID_NAME_FMT="Nome de branch inválido: %s\n"
MSG_BRANCH_RENAME_EXISTS_FMT="Branch já existe: %s\n"
MSG_BRANCH_RENAME_DONE_FMT="Renomeada: %s → %s\n"
MSG_BRANCH_RENAME_REMOTE_PROMPT_FMT="Renomear também no remote [%s] (push do novo + delete do antigo)? [y/N] "
MSG_BRANCH_RENAME_REMOTE_DONE="Rename no remote concluído."

# ── copy-branch-name.sh ─────────────────────────────────────────
MSG_COPY_BRANCH_TITLE="copy-branch-name (copiar um nome de branch deste commit para o clipboard)"
MSG_COPY_BRANCH_PURPOSE="O quê:  coloca um nome de branch no clipboard do sistema para colar em outro lugar"
MSG_COPY_BRANCH_WHEN="Quando: mandar o nome no chat / colar na descrição de um PR / usar em outro terminal"
MSG_COPY_BRANCH_NOTE="Nota:   usa pbcopy (macOS) / wl-copy / xclip / xsel — o que estiver disponível"
MSG_COPY_BRANCH_NONE="Nenhuma branch local neste commit para copiar."
MSG_COPY_BRANCH_LIST_HEADER="Branches locais neste commit:"
MSG_COPY_BRANCH_SELECT_PROMPT="Escolha uma (nome da branch ou número): "
MSG_COPY_BRANCH_NO_INPUT="Nenhuma entrada; cancelado."
MSG_COPY_BRANCH_NOT_IN_LIST_FMT="A branch '%s' não está na lista deste commit.\n"
MSG_COPY_BRANCH_DONE_FMT="Copiado: %s\n"
MSG_COPY_BRANCH_NO_CLIPBOARD="Nenhum utilitário de clipboard encontrado (precisa de pbcopy / wl-copy / xclip / xsel). Nome da branch impresso abaixo:"

# ── copy-commit-message.sh ──────────────────────────────────────
MSG_COPY_MSG_TITLE="copy-commit-message (copiar a message deste commit para o clipboard)"
MSG_COPY_MSG_PURPOSE="O quê:  coloca o subject (uma linha) ou a message completa do commit no clipboard do sistema"
MSG_COPY_MSG_WHEN="Quando: colar em uma release note / PR / chat / e-mail"
MSG_COPY_MSG_NOTE="Nota:   usa pbcopy (macOS) / wl-copy / xclip / xsel — o que estiver disponível"
MSG_COPY_MSG_KIND_PROMPT="Copiar [s]ubject (padrão) / message [f] completa: "
MSG_COPY_MSG_KIND_INVALID_FMT="Escolha inválida: %s\n"
MSG_COPY_MSG_DONE_FMT='Copiado: %s\n'
MSG_COPY_MSG_NO_CLIPBOARD="Nenhum utilitário de clipboard encontrado (precisa de pbcopy / wl-copy / xclip / xsel). Message impressa abaixo:"
