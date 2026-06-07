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
./sync-tasks.sh
```

`sync-tasks.sh` does two things:

1. Copies every `*.sh` to `~/.config/zed/git-command/`
2. Renders the `__GIT_COMMAND_DIR__` placeholder in `tasks.json` with the path above,
   writing the result to `~/.config/zed/tasks.json`

Then in Zed run `Cmd+Shift+P` → `reload window`. The 37 commands now appear in the Git Graph right-click menu of every project.

Want a different install location? Override via env var:

```bash
TARGET_DIR=~/.local/share/git-command ./sync-tasks.sh
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

Every history-rewriting script runs under two layers of protection:

- **`ensure_clean_state`** — refuses to start if a rebase / cherry-pick / revert / merge is already in progress
- **`enable_failure_rollback`** — registers `EXIT` / `INT` / `TERM` / `HUP` traps; any non-zero exit while a rebase-like state is detected auto-triggers `--abort` cleanup

Only `SIGKILL` / power loss can bypass this (POSIX limitation).

Each script's entry point uses `show_intro` to print "what it does / when to use it / caveats", then prompts for a `y/N` confirm before touching anything.

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
- New scripts should `source lib.sh` and reuse its seven helpers (`show_intro` / `print_header` / `confirm` / `ensure_clean_state` / `enable_failure_rollback` / `run_or_abort` / `require_bare_layout`).
- History-rewriting scripts must compose `ensure_clean_state` + `enable_failure_rollback`.

## Tests

```bash
bash test/test-worktree-from.sh    # 19 assertions
bash test/test-branch-delete.sh    # 6 assertions
bash test/test-worktree-remove.sh  # 6 assertions
```

No external test framework — pure bash + git in `mktemp` sandboxes.

## Known Limitations (upstream Zed)

| Issue | Symptom | Status |
|-------|---------|--------|
| [zed-industries/zed#53594](https://github.com/zed-industries/zed/issues/53594) | Git Graph doesn't refresh after external git commands touch tags; requires Reload Window | OPEN, P2 |
| [zed-industries/zed#58777](https://github.com/zed-industries/zed/issues/58777) | `tasks.json` lacks a `detail` field and native `separator` type — menu labels can't right-align | OPEN |
