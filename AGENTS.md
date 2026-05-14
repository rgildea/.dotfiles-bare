# AI Assistant Context

## Dotfiles Structure

This is a macOS dotfiles repository using the **bare git repo** pattern with [dotbare](https://github.com/kazhala/dotbare) for management.

### Key Directories

- `~/.cfg/` - Bare git repository (do not delete)
- `~/bin/` - Custom scripts, auto-aliased in Zsh
- `~/.janus/` - Vim plugins (managed by Janus)
- `~/repos/` - Git submodules (base16-shell, oh-my-zsh custom)

### Shell Load Order

1. `.zshenv` - PATH (uv, ~/bin, antigravity, opencode)
2. `.zprofile` - Homebrew (if exists)
3. `.zshrc` - Oh My Zsh, plugins, completions
4. `.zshrc.local` - Machine-specific (sourced at end)

### Important Patterns

- **PATH defined in `.zshenv`** - earliest possible, covers all shell types
- **Aliases in `.aliases.zsh`** - loaded by `.zshrc`, conditional on tool installation
- **Dotbare commands** - use `dotbare` or alias `config`/`cfg`, not raw git
- **Bootstrap script** - single-command setup at `bin/bootstrap-dotfiles.zsh`

### Tools Used

- **oh-my-zsh** - Shell framework
- **powerlevel10k** - Prompt theme
- **asdf** - Version manager (node, ruby, python)
- **Homebrew** - Package manager
- **Janus** - Vim distribution
- **delta** - Git diff pager
- **1Password** - SSH keys and secrets

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

- `~/.zshrc.local` - Machine-specific settings
- `~/.gitconfig.local` - Machine-specific git config
- `~/.ssh/config` - SSH hosts (contains machine names)
- `~/.config/*` - App configs (mostly cache/data)
  - Exception: `~/.config/git/ignore` is tracked

### Bootstrap Process

The `bin/bootstrap-dotfiles.zsh` script:
1. Installs Homebrew
2. Installs 1Password + CLI
3. Clones dotbare temporarily
4. Clones this dotfiles repo to `~/.cfg`
5. Runs `brew bundle`
6. Installs oh-my-zsh
7. Installs asdf plugins and versions
8. Installs Janus for Vim
9. Applies macOS defaults
10. Opens iTerm with p10k configure

### Common Issues

- **dotbare tty error** - Harmless, affects some environments
- **zcompdump files** - Safe to delete `~/.zcompdump-*`
- **Janus plugins** - Managed as submodules in `.janus/`, update with `git submodule update`
