# Dotfiles

Portable macOS development environment managed with [dotbare](https://github.com/kazhala/dotbare).

> Already set up? Run `halp` in your terminal for the full workflow guide.

## Quick Start

> **Requires physical/GUI access.** Bootstrap cannot be run over SSH — 1Password sign-in and SSH agent setup require the desktop app.

```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/rgildea/.dotfiles-bare/main/bin/bootstrap-dotfiles.zsh)"
```

The script will pause and prompt you to sign in to 1Password and enable **Settings → Developer → SSH Agent** and **Settings → Developer → CLI Integration** before continuing.

## Overview

| Component | Tool |
|-----------|------|
| Shell | Zsh + Oh My Zsh |
| Prompt | Starship |
| Package Manager | Homebrew |
| Version Manager | mise |
| Editor | VS Code + Zed |
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

### Key Files

```
.
├── .zshrc              # Main shell config (plugins, key bindings)
├── .zshenv             # Early PATH setup
├── .zprofile           # Homebrew initialization
├── .aliases.zsh        # Aliases for bat, eza, fd, etc.
├── .gitconfig          # Git settings + delta pager
├── .claude.json        # Claude Code MCP server config (no secrets)
├── .config/
│   ├── git/ignore      # Global git ignore
│   └── com.googlecode.iterm2/  # iTerm2 preferences (tracked)
├── Brewfile            # Homebrew packages + VS Code extensions
├── .tool-versions      # mise language versions (Node, Ruby, Python, SQLite)
└── bin/
    ├── bootstrap-dotfiles.zsh  # One-command setup
    └── sane-macos-defaults.sh  # macOS preferences
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

Run `halp shell` for command-line editing bindings and autosuggestion usage.

## Managing Homebrew Packages

The `Brewfile` is the source of truth for installed packages, casks, and VS Code extensions. Use `brewi`/`brewci`/`brewun` wrappers instead of raw `brew` commands — they keep the Brewfile in sync automatically. On a new machine: `brew bundle`.

Run `halp brew` for workflows and drift-checking commands.

## Agent Skills

Global agent skills are tracked in `~/.agents/` and restored automatically by bootstrap. Run `halp skills` for the full reference.

## Local Overrides

Create `.zshrc.local` for machine-specific settings (not committed):

```zsh
# Example .zshrc.local
export CLOUDSDK_PYTHON_SITEPACKAGES=1
export OPENAI_API_KEY="..."
```

## macOS Defaults

Applied by `bin/sane-macos-defaults.sh` during bootstrap — safe to re-run any time, all settings are idempotent. Run `halp macos` for the full reference.

## License

Personal use only.
