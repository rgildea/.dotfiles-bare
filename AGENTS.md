# AI Assistant Context

## Dotfiles Structure

This is a macOS dotfiles repository using the **bare git repo** pattern with [dotbare](https://github.com/kazhala/dotbare) for management.

### Key Directories

- `~/.cfg/` - Bare git repository (do not delete)
- `~/bin/` - Custom scripts, auto-aliased in Zsh
- `~/repos/` - Git submodules (base16-shell, oh-my-zsh custom, fzf-tab, zsh plugins)

### Shell Load Order

1. `.zshenv` - PATH (uv, ~/bin, antigravity, opencode)
2. `.zprofile` - Homebrew (if exists)
3. `.zshrc` - Oh My Zsh, plugins, Starship, mise activate, zoxide init, fzf-tab
4. `.zshrc.local` - Machine-specific (sourced at end)

### Important Patterns

- **PATH defined in `.zshenv`** - earliest possible, covers all shell types
- **Aliases in `.aliases.zsh`** - loaded by `.zshrc`, conditional on tool installation
- **Dotbare commands** - use `dotbare` or alias `config`/`cfg`, not raw git
- **Bootstrap script** - single-command setup at `bin/bootstrap-dotfiles.zsh`

### Tools Used

- **oh-my-zsh** - Shell framework
- **Starship** - Prompt theme (replaces Powerlevel10k)
- **fzf-tab** - fzf-powered completion menu (replaces zsh-autocomplete)
- **mise** - Version manager (node, ruby, python, sqlite) — reads `.tool-versions`
- **Homebrew** - Package manager
- **delta** - Git diff pager
- **lazygit** - Visual git TUI (`lg`)
- **zoxide** - Smarter cd (`z`, `zi`)
- **1Password** - SSH keys and secrets
- **OrbStack** - Docker/container runtime (replaces Docker Desktop)
- **Raycast** - Launcher (replaces Alfred)
- **Ghostty** - Terminal (alongside iTerm2)
- **Zed** - Editor (alongside VS Code)

### MCP Servers

Claude Code is configured with three MCP servers via `~/.claude.json` (tracked in dotfiles):
- `filesystem` — read/write to `$HOME` and `$HOME/projects`
- `github` — GitHub API; reads `GITHUB_PERSONAL_ACCESS_TOKEN` from shell env
- `fetch` — URL retrieval for docs/research

The GitHub token is written to `~/.zshrc.local` by the bootstrap script via `op read`.

### Modifying Dotfiles

```bash
# Always use dotbare, not git
dotbare status
dotbare add <file>
dotbare commit -m "message"

# Available aliases
cfg='dotbare'
cgs='dotbare status -sb'
cadd='dotbare add'
cac='config add . && config commit -m'
```

### What NOT to Track

- `~/.zshrc.local` - Machine-specific settings (API keys, GITHUB_PERSONAL_ACCESS_TOKEN)
- `~/.gitconfig.local` - Machine-specific git config
- `~/.ssh/config` - SSH hosts (contains machine names)
- `~/.config/*` - App configs (mostly cache/data)
  - Exception: `~/.config/git/ignore` is tracked
  - Exception: `~/.config/com.googlecode.iterm2/` is tracked
- `~/.claude.json` is tracked (no secrets — token comes from shell env)

### Bootstrap Process

The `bin/bootstrap-dotfiles.zsh` script:
1. Installs Homebrew
2. Installs Xcode tools
3. Installs 1Password + CLI, prompts to enable SSH Agent and CLI Integration
4. Clones dotbare temporarily
5. Clones this dotfiles repo (`DOTFILES_BRANCH` env var, defaults to `main`)
6. Runs `brew bundle`
7. Fixes Homebrew zsh dir permissions (prevents compinit warnings)
8. Installs oh-my-zsh
9. Installs mise and runs `mise install` (reads `.tool-versions`)
10. Adds mise shims to PATH for remainder of script
11. Installs Claude Code
12. Writes `GITHUB_PERSONAL_ACCESS_TOKEN` to `~/.zshrc.local` via `op read`
13. Creates Zed settings stub at `~/.config/zed/settings.json`
14. Restores agent skills
15. Applies macOS defaults
16. Opens iTerm

### Common Issues

- **dotbare tty error** - Harmless, affects some environments
- **zcompdump files** - Safe to delete `~/.zcompdump-*`
- **npx not found during skills-restore** - mise shims must be on PATH; bootstrap handles this automatically
