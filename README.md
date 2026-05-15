# Dotfiles

Portable macOS development environment managed with [dotbare](https://github.com/kazhala/dotbare).

> Already set up? Run `halp` in your terminal for the full workflow guide.

## Quick Start

```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/rgildea/.dotfiles-bare/main/bin/bootstrap-dotfiles.zsh)"
```

## Overview

| Component | Tool |
|-----------|------|
| Shell | Zsh + Oh My Zsh |
| Prompt | Powerlevel10k |
| Package Manager | Homebrew |
| Version Manager | asdf |
| Editor | Vim (vim-plug) + VS Code |
| Terminal | iTerm2 |
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
├── .config/git/ignore  # Global git ignore
├── Brewfile            # Homebrew packages + VS Code extensions
├── .tool-versions      # asdf language versions
└── bin/
    ├── bootstrap-dotfiles.zsh  # One-command setup
    ├── sane-macos-defaults.sh  # macOS preferences
    └── reset_luna_prefs.sh     # Luna Display reset
```

## Managing Dotfiles

The repo uses a bare git repository at `~/.cfg`, managed via `dotbare`:

```bash
# View status
dotbare status

# Add files
dotbare add ~/.config/some-tool/config

# Commit changes
dotbare commit -m "Add some-tool config"

# Push
dotbare push origin main

# View diff
dotbare diff
```

Aliases are available: `config`, `cfg`, `cadd`, `cstat`, `clog`, etc.

## Tools & Aliases

Modern CLI replacements (auto-aliased when installed):

| Default | Replacement | Command |
|---------|-------------|---------|
| `cat` | `bat` | `cat` |
| `ls` | `eza` | `ls`, `ll`, `la`, `lt` |
| `grep` | `ripgrep` | `grep` |
| `find` | `fd` | `find` |
| `df` | `duf` | `df` |
| `top` | `htop` | `top` |
| `ping` | `prettyping` | `ping` |
| `ps` | `procs` | `ps` |

Git aliases: `gs`, `gl`, `gp`, `gac`, `glog`, `gb`, `gco`, etc.

See `.aliases.zsh` for the full list.

## Managing Homebrew Packages

The `Brewfile` is the source of truth for installed packages, casks, and VS Code extensions.

### Installing new software

Use the wrapper commands instead of raw `brew install` — they dump the Brewfile automatically:

```bash
brewi ripgrep          # brew install + dump
brewci rectangle       # brew install --cask + dump
brewun unused-tool     # brew uninstall + dump
```

After any of these, review and commit the updated Brewfile:

```bash
cstat                  # see that Brewfile is modified
cdiff Brewfile         # review what changed
config commit -m "Add ripgrep to Brewfile"
cgp
```

### Syncing from current state

If you've installed things with raw `brew` commands and want to catch up the Brewfile:

```bash
brewsync               # dump current state + show diff against committed version
```

### Checking for drift

To see what's installed locally but not recorded in the Brewfile:

```bash
brewdrift              # lists untracked packages (brew bundle cleanup, no --force)
```

### Installing from Brewfile

On a new machine or after pulling changes:

```bash
brew bundle            # install everything in the Brewfile
```

## Local Overrides

Create `.zshrc.local` for machine-specific settings (not committed):

```zsh
# Example .zshrc.local
export CLOUDSDK_PYTHON_SITEPACKAGES=1
export OPENAI_API_KEY="..."
```

## macOS Defaults

The bootstrap script applies macOS preferences via `bin/sane-macos-defaults.sh`:
- Finder: show ~/Library, remove delay on proxy icons
- Dock: auto-hide, minimize to app icon
- Screen: require password immediately
- Security: enable firewall
- And more...

## Post-Install

1. **1Password**: Sign in and enable SSH agent in Settings → Developer
2. **iTerm**: Settings → General → Settings → Load from custom folder → `~`
3. **Git SSH**: 1Password should offer to configure `~/.ssh/config`

## License

Personal use only.
