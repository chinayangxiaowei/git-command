**English | [简体中文](README.zh-CN.md)**

# git-command

JetBrains-style Git operation scripts for [Zed](https://zed.dev)'s Git Graph right-click context menu — covers ~80% of daily commit-level operations (reword / squash / fixup / cherry-pick / revert / branch / tag / stash …).

## Requirements

| | |
|--|--|
| OS | macOS / Linux |
| Shell | bash ≥ 3.2 (macOS's stock `/bin/bash` is fine) |
| Git | ≥ 2.x |
| Editor | [Zed](https://zed.dev) — for the menu; scripts also work standalone from the CLI |

**Windows is not supported.** Scripts rely on POSIX shell + Unix toolchain. WSL is theoretically possible (bash + git both exist there) but Zed's Git Graph integration under WSL is not endorsed.

## Install

```bash
git clone https://github.com/chinayangxiaowei/git-command.git ~/git-command   # any path
cd ~/git-command
./sync-tasks.sh           # English (default)
# or pick a language:
./sync-tasks.sh zh        # 简体中文
./sync-tasks.sh ja        # 日本語
./sync-tasks.sh pt-BR     # Português Brasil
# 10 languages available: en / zh / zh-TW / ja / ko / pt-BR / es / de / fr / ru
```

`sync-tasks.sh` does four things:

1. Copies every `*.sh` to `~/.config/zed/git-command/`
2. Copies the chosen `lang/<code>.sh` as `lang.sh` next to the scripts (runtime messages)
3. Renders the `__GIT_COMMAND_DIR__` placeholder in `tasks.json` with the install path,
   substitutes all 46 `__LABEL_*__` placeholders with the chosen language's menu labels,
   and writes the result to `~/.config/zed/tasks.json`
4. Symlinks `init-bare-tree` into `~/.local/bin/` (if that directory is on your PATH) so
   bootstrapping a new bare+worktree project becomes a one-word command

Then in Zed run `Cmd+Shift+P` → `reload window`. The 41 commands now appear in the Git Graph right-click menu of every project.

Want a different install location? Override via env var:

```bash
TARGET_DIR=~/.local/share/git-command ./sync-tasks.sh zh
```

## Menu Inventory

41 commands across 9 categories, injected into Zed's Git Graph commit right-click menu via `tasks.json`.

| Category | Commands |
|----------|----------|
| View / Browse | branches / tags containing this commit; stat; full diff; diff vs HEAD; open every file touched by this commit in the editor; export file snapshots at this commit; export N previous patches |
| Modify this commit | `reword` (message only); `edit-commit` (message + add/remove files) |
| Rewrite history | squash N commits forward; drop this commit; interactive rebase; soft / hard reset |
| Fixup | merge working-tree changes into this commit (`--fixup` + autosquash); fold this commit into an ancestor |
| Copy / Undo | cherry-pick; revert |
| Branch | create branch from this commit; ad-hoc try branch; rebase branch A onto branch B (CLion-style); delete local branches at this commit (with optional remote); switch to / rename a branch at this commit; copy branch name; copy commit message — all clipboard-aware (`pbcopy` / `wl-copy` / `xclip` / `xsel`) |
| Tag | create tag; delete tag (with optional remote) |
| Stash | named stash push; pop most recent stash |
| Worktree | create a new worktree from this commit (five purposes: `review` / `try` / `fix` / `feat` / `hot`, auto-named + opened in a new Zed window); each purpose has a matching "delete" menu item that lists existing worktrees and asks for paste-to-confirm |

## Safety Design

Every script that sources `lib.sh` automatically gets:

- **`require_clean_state`** — refuses to start if a rebase / cherry-pick / revert / merge is already in progress (prevents stacking mid-op state on top of mid-op state)
- **EXIT trap auto-rollback** — registered at the top of `lib.sh` for *every* script. On non-zero exit it inspects the git directory; if a rebase-like state is detected it runs `git <kind> --abort` and prints a clear "auto-rolled back" message
- **Smart SIGINT handler** — also registered at the top of `lib.sh`. Ctrl+C is routed by current git state:
  - **mid-op** (`rebase-merge` / `CHERRY_PICK_HEAD` / `REVERT_HEAD` / `MERGE_HEAD` present) → exit 130 → EXIT trap aborts the operation
  - **idle** (just waiting for input) → set `_GIT_CMD_DONE=1` and exit 0 → EXIT trap short-circuits → Zed's `hide: on_success` collapses the pane. No spurious "press Enter to close" after a Ctrl+C — you already said you want out
- **`_GIT_CMD_DONE=1` short-circuit** — once the main work finishes successfully, the trap sets this flag before the `wait_to_close` prompt. Any subsequent Ctrl+C / pane close / kill during the wait will *not* re-enter the abort branch — the work already succeeded
- **`enable_failure_rollback()`** — history-rewriting scripts call this to additionally trap TERM (143), HUP (129), and QUIT (131) so those signals get routed through the same EXIT-trap abort path
- **`run_or_abort`** — wraps a single git subcommand; on failure prints why and runs the matching `git <kind> --abort` before exiting

**User cancellation is treated as success, not failure.** Answering `n` at any `y/N` confirm, hitting Ctrl+C while idle, typing `:q` in a multi-line message editor, leaving a required input blank — all exit 0. You chose to stop; that's not an error. Zed collapses the pane right away.

**Signal exit-code map (everything routes through the EXIT trap):**

| Signal | Exit code | Source |
|--------|-----------|--------|
| `SIGINT` (Ctrl+C) | 130 (mid-op) or 0 (idle) | smart `_lib_handle_int` at lib.sh top |
| `SIGTERM` | 143 | `enable_failure_rollback` |
| `SIGHUP` (terminal closed) | 129 | `enable_failure_rollback` |
| `SIGQUIT` (Ctrl+\\) | 131 | `enable_failure_rollback` |
| `SIGKILL` / power loss | 137 / – | **not interceptable** (POSIX limitation) |

Each script's entry point uses `show_intro` to print "what it does / when to use it / caveats", then prompts for a `y/N` confirm before touching anything. On success the script blocks on "press Enter to close" so you can read the final output, then Zed's `hide: on_success` collapses the pane.

## Project Layout

The repo itself uses a **bare + worktree** layout, set up by `init-bare-tree.sh` — a standalone helper that initializes any new project into this shape with one command:

```
project/
├── .bare/      ← git data
├── .git        ← file pointing to .bare
└── main/       ← primary worktree
```

Benefits: feature branches can be checked out into sibling worktrees (`feature-x/`, etc.) in parallel without disturbing each other. The worktree menu category lives on top of this layout (`require_bare_layout` gates it).

To bootstrap a new project in this layout, run `init-bare-tree <name> [<clone-url>]`. `sync-tasks.sh` symlinks the helper into `~/.local/bin/` automatically when that directory is on your PATH (otherwise it prints the one-line `ln` command to do it yourself).

## Notes for Contributors

- Target shell is macOS's stock **bash 3.2.57**. Avoid bash 4+ features (`mapfile`, `${var^}` / `${var,}`, associative arrays).
- New scripts should `source lib.sh` and reuse its helpers: `show_intro` / `print_header` / `confirm` / `require_clean_state` / `enable_failure_rollback` / `run_or_abort` / `require_bare_layout` / `wait_to_close` / `copy_to_clipboard` / `maybe_open_in_zed`.
- History-rewriting scripts add `require_clean_state` + `enable_failure_rollback` near the top. The EXIT trap is registered globally by `lib.sh` itself, so the wait-to-close + abort-on-failure behavior is automatic.
- Side-effect-only scripts (clipboard, opens-in-editor) should `export GIT_COMMAND_NO_PAUSE=1` near the top to skip the closing prompt — there's no terminal output worth reading.
- All user-visible strings live in `lang/<code>.sh` (runtime messages, `MSG_*`) and `lang/labels-<code>.sh` (menu labels, `LABEL_*`). Adding a new language: copy `lang/en.sh` + `lang/labels-en.sh`, translate, then `./test/verify-translations.sh` will catch dropped variables or `%s/%d` mismatches.

## Tests

```bash
bash test/test-all.sh                # 42 assertions — happy path + boundaries across 8 scripts
bash test/test-rollback.sh           # 10 assertions — EXIT trap / auto-abort / require_clean_state
bash test/test-chains.sh             # 12 assertions — branch / worktree / stash chained workflows
bash test/test-edge.sh               #  9 assertions — VIEW wrappers / detached HEAD / empty commit / CJK+emoji slug
bash test/test-history-rewrite.sh    # 19 assertions — all 12 history-rewriting scripts
bash test/verify-translations.sh     # 90 assertions — i18n parity across 10 languages
```

Total: **182 assertions**, all pure bash + git in `mktemp` sandboxes — no external framework, no flaky network.

## Known Limitations (upstream Zed)

| Issue | Symptom | Status |
|-------|---------|--------|
| [zed-industries/zed#53594](https://github.com/zed-industries/zed/issues/53594) | Git Graph doesn't refresh after external git commands touch tags; requires Reload Window | OPEN, P2 |
| [zed-industries/zed#58777](https://github.com/zed-industries/zed/issues/58777) | `tasks.json` lacks a `detail` field and native `separator` type — menu labels can't right-align | OPEN |
