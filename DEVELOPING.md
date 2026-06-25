# Claude Code Dotfiles Guide

## Working with This Repository

This is a **bare git repository**. Never use raw `git` commands from the home directory—they won't work.

### Correct Commands

| Wrong | Right |
|-------|-------|
| `git status` | `cfg status` |
| `git add` | `cadd` |
| `git commit` | `cfg commit` |
| `git diff` | `cdiff` |
| `git push` | `cgp` |

Aliases: `config`, `cfg`, `cadd`, `cstat`, `clog`, `cdiff`, `cgs` (status -sb), `cgp` (push)

**Always use the most compact alias available.** Prefer `cfg` over `config`; prefer `cadd`, `cdiff`, `cstat`, `clog`, `cgp` over their longer forms.

### Commit Messages

All commits must follow [Conventional Commits](https://www.conventionalcommits.org/) format. A `commit-msg` hook enforces this globally — non-conforming messages are rejected.

**Format:** `<type>(<scope>): <subject>`

| Type | When to use |
|------|-------------|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `refactor` | Code restructure, no behavior change |
| `chore` | Config, tooling, dependencies |
| `ci` | CI/CD changes |
| `perf` | Performance improvement |
| `test` | Adding or fixing tests |
| `build` | Build system changes |

**Examples:**
```
feat(zsh): add brewi wrapper for auto-dumping Brewfile
fix(gitconfig): correct corrupted br alias
chore(Brewfile): remove deprecated hub package
docs(README): add Homebrew management section
```

**Rules:**
- Subject is imperative mood, no period, ≤72 chars
- Scope is optional but encouraged
- Breaking changes: append `!` before the colon — `feat!: remove X`
- Use `cfg commit -m "..."` not raw `git commit` in this repo

### Key Directories

- `~/.cfg/` - Bare git repository (do not delete)
- `~/bin/` - Custom scripts, auto-aliased in Zsh
- `~/repos/` - Git submodules (base16-shell, oh-my-zsh custom, fzf-tab)

### Tools Used

- **oh-my-zsh** - Shell framework
- **Starship** - Prompt theme
- **fzf-tab** - fzf-powered completion menu
- **mise** - Version manager (node, ruby, python, sqlite) — reads `.tool-versions`
- **Homebrew** - Package manager
- **delta** - Git diff pager
- **lazygit** - Visual git TUI (`lg`)
- **zoxide** - Smarter cd (`z`, `zi`)
- **1Password** - SSH keys and secrets
- **OrbStack** - Docker/container runtime
- **Raycast** - Launcher
- **Ghostty** - Terminal (alongside iTerm2)
- **Zed** - Editor (alongside VS Code)

### File Locations

| File | Purpose |
|------|---------|
| `.zshrc` | Main interactive shell config |
| `.zshenv` | PATH (runs first) |
| `.zprofile` | Homebrew setup (login shells only) |
| `.zshrc.local` | **Machine-specific, do not track** |
| `.aliases.zsh` | Aliases for modern tools |
| `Brewfile` | Homebrew packages + VS Code extensions |
| `.tool-versions` | mise language versions (node, ruby, python, sqlite) |
| `bin/` | Scripts auto-aliased in shell |

### Shell Architecture

Zsh loads in this order—respect it when making changes:

1. **`.zshenv`** - Environment variables and PATH
   - Must work without Homebrew (use `command -v` checks)
   - Runs for all shell types

2. **`.zprofile`** - Login shell setup
   - Homebrew initialization (wrap in `command -v brew` check)
   - Runs before `.zshrc` for login shells

3. **`.zshrc`** - Interactive shell
   - Oh My Zsh, plugins, completions, aliases
   - Sources `.aliases.zsh` and `.zshrc.local` at end

4. **`.zshrc.local`** - Untracked machine-specific settings
   - Cloud SDK settings, API keys, work configs
   - Created manually per machine

### PATH Priority

Current order (earliest wins for conflicts):
1. `~/.local/bin` (uv tools)
2. `~/bin` (personal scripts)
3. `/opt/homebrew/bin` (Apple Silicon Homebrew)
4. Antigravity, opencode (appended)
5. Google Cloud SDK (sourced conditionally)

### When Editing These Files

**`.zshrc` changes:**
- Keep Oh My Zsh block intact
- Add new tools after plugin sourcing
- Use conditional checks: `if command -v tool &>/dev/null`
- Add PATH entries to `.zshenv` instead when possible

**`.zshenv` changes:**
- Use `$HOME` not hardcoded paths
- Keep it minimal—only what needs to be available before `.zshrc`

**Brewfile changes:**
- Don't add `node`, `python`, or `ruby` (use mise — managed via `.tool-versions`)
- Remove VS Code extensions you've uninstalled
- Use `brew bundle dump --force` if regenerating

### Testing Changes

```bash
# Test zsh configs
source ~/.zshenv && source ~/.zprofile && source ~/.zshrc

# Test on fresh shell
exec zsh -l

# View current PATH
echo $PATH | tr ':' '\n'

# Check for errors
zsh -xv 2>&1 | less  # verbose execution
```

### Patterns to Follow

**Conditional tool loading:**
```zsh
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi
```

**Adding PATH entries (put in `.zshenv`):**
```zsh
path+=("$HOME/.new-tool/bin")
```

**Machine-specific config (put in `.zshrc.local`, don't track):**
```zsh
export WORK_API_KEY="..."
export CLOUDSDK_PYTHON_SITEPACKAGES=1
```

### What to Track vs Ignore

| Track | Don't Track |
|-------|-------------|
| `.zshrc`, `.zshenv`, `.zprofile` | `.zshrc.local` |
| `.aliases.zsh` | `.gitconfig.local` |
| `Brewfile` | `~/.ssh/config` |
| `.config/git/ignore` | `~/.config/*` (mostly cache) |
| `.config/starship.toml` | |
| `.config/com.googlecode.iterm2/` | |
| `bin/*.zsh` scripts | Scripts with API keys/secrets |
| `.agents/.skill-lock.json` | Agent cache, symlinks |
| `.agents/skills/*/SKILL.md` | |

### Agent Skills

Global agent skills live in `~/.agents/skills/` and are tracked in dotfiles. Agent-specific symlinks (e.g. `~/.claude/skills/`) are **not** tracked — they are recreated on demand.

**Install a new skill (adds to lock file + creates symlinks):**
```bash
npx skills add <owner/repo> -g -y
```

**After dotfiles checkout on a new machine:**
The bootstrap script runs `skills-restore` automatically. To run it manually (e.g. after pulling new skills on an existing machine):
```bash
skills-restore   # replays npx skills add -g -y for every entry in ~/.agents/.skill-lock.json
```

**After installing a new skill, commit the updated files:**
```bash
cadd ~/.agents/.skill-lock.json ~/.agents/skills/<name>/SKILL.md
cfg commit -m "chore(skills): add <name> skill"
```

### Submodules

This repo uses git submodules:
- `repos/base16-shell` - Base16 color schemes
- `repos/fzf-tab` - fzf-powered completion menu

Update with:
```bash
cfg submodule update --init --recursive
cfg submodule update --remote
```

### MCP Servers

Claude Code reads MCP server config from `~/.claude.json` (tracked in dotfiles — no secrets).

**Servers configured:**
- `filesystem` — read/write to `$HOME` and `$HOME/projects`
- `github` — GitHub API; reads `GITHUB_PERSONAL_ACCESS_TOKEN` from shell environment
- `fetch` — URL retrieval for docs/research during sessions

`~/.claude.json` is safe to track because the GitHub token is not stored in it — it is read from `GITHUB_PERSONAL_ACCESS_TOKEN` in the shell environment, which bootstrap writes to `~/.zshrc.local` (untracked) via `op read`.

**Verify after setup:**
```bash
claude mcp list
```

### Zed Editor

Config lives at `~/.config/zed/settings.json` (not tracked — per `~/.config/*` convention).

Key settings to configure:
- Font: Monaspace Neon (already in Brewfile as `font-monaspace-nf`)
- Assistant provider: Anthropic, model `claude-sonnet-4-6`
- Requires `ANTHROPIC_API_KEY` in `.zshrc.local`

The bootstrap script creates a minimal stub if the file doesn't exist.

### Bootstrap Testing

If modifying `bin/bootstrap-dotfiles.zsh`:
1. Test in a fresh macOS VM — the script is destructive (overwrites configs, installs software)
2. Key step: clones `$DOTFILES_REPO` into `~/.cfg` as a bare git repository

Bootstrap order: Homebrew → Xcode tools → 1Password → dotfiles → brew bundle → chmod brew dirs → Oh My Zsh → mise + languages (reads `.tool-versions`) → Claude Code → GitHub token → Zed stub → skills-restore → macOS defaults → open iTerm.

**Testing with Tart (Apple Silicon VMs):**

One-time setup — pull a clean base image and save a snapshot:
```bash
tart clone ghcr.io/cirruslabs/macos-sequoia-vanilla:latest sequoia-base
tart run sequoia-base  # enable SSH, create your user account, then stop
```

Each test run — always start from a fresh clone:
```bash
tart clone sequoia-base sequoia-test
tart run sequoia-test --no-graphics
tart-prep sequoia-test your-branch   # writes ~/bootstrap.sh on the VM
# open the VM GUI, open Terminal, run: zsh ~/bootstrap.sh
```

To test a specific branch:
```bash
export DOTFILES_BRANCH=your-branch && /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/<your-github-user>/.dotfiles-bare/$DOTFILES_BRANCH/bin/bootstrap-dotfiles.zsh)"
```

**Important:** the dotfiles install step is skipped if `~/.cfg` already exists — bootstrap is idempotent by design. Always start from a fresh VM clone to test the full flow. Never reuse a VM that has already been bootstrapped.

`bin/sane-macos-defaults.sh` is safe to re-run (all `defaults write` calls are idempotent). It covers: UI/UX, trackpad/keyboard, energy, screen/screenshots, Finder, Dock, Safari, iTerm, Time Machine, Activity Monitor, Software Updates. Full details in `README.md`.

### Common Issues

- **zcompdump files** - Safe to delete `~/.zcompdump-*`
- **npx not found during skills-restore** - mise shims must be on PATH; bootstrap handles this automatically
