# Dotfiles

Portable macOS development environment managed with [dotbare](https://github.com/kazhala/dotbare).

> Already set up? Run `halp` in your terminal for the full workflow guide.

## Quick Start

> **Requires physical/GUI access.** Bootstrap cannot be run over SSH — 1Password sign-in and SSH agent setup require the desktop app.

```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/rgildea/.dotfiles-bare/main/bin/bootstrap-dotfiles.zsh)"
```

To test a feature branch end-to-end:
```bash
export DOTFILES_BRANCH=your-branch && /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/rgildea/.dotfiles-bare/$DOTFILES_BRANCH/bin/bootstrap-dotfiles.zsh)"
```

The script will pause and prompt you to sign in to 1Password and enable **Settings → Developer → SSH Agent** and **Settings → Developer → CLI Integration** before continuing.

## Bootstrap Testing Protocol

Use [Tart](https://tart.run) to test bootstrap changes on Apple Silicon:

```bash
# One-time: pull a clean base image and save a snapshot
tart clone ghcr.io/cirruslabs/macos-sequoia-vanilla:latest sequoia-base
tart run sequoia-base  # enable SSH, create your user account, then stop
tart clone sequoia-base sequoia-test  # clone fresh for each test run
```

Each test run:
```bash
tart clone sequoia-base sequoia-test  # always start from the clean snapshot
tart run sequoia-test --no-graphics
ssh admin@$(tart ip sequoia-test)
# then run the bootstrap from the GUI (requires physical access for 1Password)
```

**Important:** the dotfiles install step is skipped if `~/.cfg` already exists — bootstrap is idempotent by design. Always start from a fresh VM clone to test the full flow. Never reuse a VM instance that has already been bootstrapped.

## Overview

| Component | Tool |
|-----------|------|
| Shell | Zsh + Oh My Zsh |
| Prompt | Powerlevel10k |
| Package Manager | Homebrew |
| Version Manager | mise |
| Editor | Vim (vim-plug) + VS Code + Zed |
| Terminal | iTerm2 / Ghostty |
| SSH/Secrets | 1Password |

## Structure

### Shell Configuration

Configuration follows Zsh's load order (earliest to latest):

| File | Purpose |
|------|---------|
| `.zshenv` | PATH setup, environment variables (all shells) |
| `.zprofile` | Homebrew initialization (login shells) |
| `.zshrc` | Interactive shell config, plugins, aliases |
| `.zshrc.local` | Machine-specific settings (untracked patterns) |
| `.aliases.zsh` | 80+ aliases for modern CLI tools |
| `.p10k.zsh` | Powerlevel10k prompt configuration |

### Key Files

```
.
├── .zshrc              # Main shell config (plugins, key bindings)
├── .zshenv             # Early PATH setup
├── .zprofile           # Homebrew initialization
├── .aliases.zsh        # Aliases for bat, eza, fd, etc.
├── .p10k.zsh           # Prompt theme
├── .gitconfig          # Git settings + delta pager
├── .claude.json        # Claude Code MCP server config (no secrets)
├── .config/
│   ├── git/ignore      # Global git ignore
│   └── com.googlecode.iterm2/  # iTerm2 preferences (tracked)
├── Brewfile            # Homebrew packages + VS Code extensions
├── .tool-versions      # mise language versions (Node, Ruby, Python, SQLite)
└── bin/
    ├── bootstrap-dotfiles.zsh  # One-command setup
    ├── sane-macos-defaults.sh  # macOS preferences
    ├── tart-prep.zsh           # Write bootstrap command to Tart VM via SSH
    └── reset_luna_prefs.sh     # Luna Display reset
```

## Managing Dotfiles

The repo uses a bare git repository at `~/.cfg`, managed via [dotbare](https://github.com/kazhala/dotbare):

```bash
cfg status
cadd ~/.config/some-tool/config
cfg commit -m "chore(zsh): update aliases"
cgp
cdiff
```

All commits follow [Conventional Commits](https://www.conventionalcommits.org/) format — a `commit-msg` hook enforces this. Use `cfg cz` for an interactive prompt. Run `halp commit` for the full reference.

Aliases: `cfg`, `cadd`, `cstat`, `clog`, `cdiff`, `cgp`

## Tools & Aliases

80+ aliases for modern CLI tools (`bat`, `eza`, `ripgrep`, `fd`, etc.) plus git shortcuts. Run `halp shell` or `halp git` for the full reference, or `als <pattern>` to search.

Run `halp vim` for the Vim quick reference including custom mappings and a vim/less paging comparison. Run `halp shell` for command-line editing bindings and autosuggestion usage.

## Managing Homebrew Packages

The `Brewfile` is the source of truth for installed packages, casks, and VS Code extensions. Use `brewi`/`brewci`/`brewun` wrappers instead of raw `brew` commands — they keep the Brewfile in sync automatically. On a new machine: `brew bundle`.

Run `halp brew` for workflows and drift-checking commands.

## Agent Skills

Global agent skills are tracked in `~/.agents/` so they can be restored on new machines.

Skills live in `~/.agents/skills/` (canonical cross-agent location). Agent-specific symlinks (e.g. `~/.claude/skills/`) are not tracked — they are recreated by running `skills-restore`.

### Installing a new skill

```bash
npx skills add <owner/repo> -g -y
```

Then commit the updated files:

```bash
cadd ~/.agents/.skill-lock.json ~/.agents/skills/<name>/SKILL.md
cfg commit -m "chore(skills): add <name> skill"
```

### Restoring skills on a new machine

The bootstrap script runs `skills-restore` automatically. If you need to run it manually (e.g. after pulling new skills on an existing machine):

```bash
skills-restore
```

This reads `~/.agents/.skill-lock.json` and replays `npx skills add -g` for every entry.

### Discovering skills

Browse and install from [skills.sh](https://skills.sh) or search GitHub for repos tagged `agent-skills`.

## Local Overrides

Create `.zshrc.local` for machine-specific settings (not committed):

```zsh
# Example .zshrc.local
export CLOUDSDK_PYTHON_SITEPACKAGES=1
export OPENAI_API_KEY="..."
```

## macOS Defaults

Applied by `bin/sane-macos-defaults.sh` during bootstrap — safe to re-run any time, all settings are idempotent. Run `halp macos` for the full reference.

## Post-Install

Steps that require manual action after bootstrap completes:

1. **Claude Code**: run `claude` to authenticate on first use
2. **Raycast**: launch, assign `⌘Space`, disable Spotlight shortcut
3. **VS Code**: set font to `Monaspace Neon` in Settings → Editor: Font Family
4. **Zed**: open it — works out of the box. Optionally sign in at zed.dev for AI assistant features (free tier available, no API key needed)
5. **Git SSH**: 1Password should offer to configure `~/.ssh/config` automatically

## License

Personal use only.
