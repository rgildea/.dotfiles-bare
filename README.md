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

## Agent Skills

Global agent skills are tracked in `~/.agents/` so they can be restored on new machines.

Skills live in `~/.agents/skills/` (canonical cross-agent location). Agent-specific symlinks (e.g. `~/.claude/skills/`) are not tracked — they are recreated by running `skills-restore`.

### Installing a new skill

```bash
npx skills add <owner/repo> -g -y
```

Then commit the updated files:

```bash
dotbare add ~/.agents/.skill-lock.json ~/.agents/skills/<name>/SKILL.md
dotbare commit -m "chore(skills): add <name> skill"
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

Applied by `bin/sane-macos-defaults.sh` during bootstrap. Re-run manually any time — all settings are idempotent.

```bash
/bin/sh ~/bin/sane-macos-defaults.sh
```

### General UI/UX
- Boot sound disabled
- Menu bar transparency disabled
- Scrollbars always visible
- Save and print panels expanded by default
- New documents save to disk, not iCloud
- "Are you sure you want to open this app?" dialog disabled
- App Resume disabled (windows don't reopen on login)
- Auto-capitalization, smart dashes, smart quotes, auto-correct all disabled
- Window resize animation accelerated

### Trackpad & Keyboard
- Tap to click enabled (trackpad + login screen)
- Two-finger tap = right-click
- Ctrl+scroll to zoom, follows keyboard focus
- Press-and-hold disabled in favor of key repeat
- Key repeat rate: fast (rate 2, initial delay 15)
- Bluetooth audio: higher bitrate

### Energy
- Wake on lid open
- Auto-restart on power loss or freeze
- Display sleep: 15 minutes

### Screen & Screenshots
- Password required immediately after sleep or screensaver
- Screenshots saved to `~/Screenshots` as PNG, no drop shadow
- HiDPI display modes enabled

### Finder
- Hidden files shown
- All file extensions shown
- Status bar and path bar visible
- Full POSIX path shown in window title
- Folders sorted to top
- Search defaults to current folder
- No warning when changing file extension
- No `.DS_Store` files on network or USB volumes
- List view as default
- No "Empty Trash" warning
- `~/Library` and `/Volumes` unhidden
- Text selection enabled in Quick Look

### Dock
- Position: left side of screen
- Icon size: 36px
- Minimize effect: scale (into app icon)
- Auto-hide with no delay
- Hidden apps shown as translucent
- Open app indicators shown
- No recent apps section
- No opening animation
- Mission Control animation: fast
- Default app icons wiped on fresh setup
- Bottom-right hot corner: start screensaver
- Spacers added on left and right sides

### Safari
- Develop menu enabled
- Universal search and search suggestions disabled (privacy)
- Auto-open safe downloads disabled
- AutoFill enabled

### iTerm
- No quit confirmation prompt

### Time Machine
- Won't offer to use new disks as backup volumes
- Local backups disabled

### Activity Monitor
- Opens main window on launch
- CPU usage shown in Dock icon
- Shows all processes, sorted by CPU

### Software Updates
- Daily auto-check enabled
- Background download of updates
- Auto-install of critical and security updates
- App Store auto-update enabled

### Other
- TextEdit: plain text mode, UTF-8 encoding
- Photos: won't auto-open when a device is plugged in
- Disk Utility: debug menu enabled

## Post-Install

1. **1Password**: Sign in and enable SSH agent in Settings → Developer
2. **iTerm**: Settings → General → Settings → Load from custom folder → `~`
3. **Git SSH**: 1Password should offer to configure `~/.ssh/config`

## License

Personal use only.
