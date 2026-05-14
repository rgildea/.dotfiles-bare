# Claude Code Dotfiles Guide

## Working with This Repository

This is a **bare git repository** using dotbare. Never use raw `git` commands from the home directory—they won't work.

### Correct Commands

| Wrong | Right |
|-------|-------|
| `git status` | `dotbare status` or `cfg status` |
| `git add` | `dotbare add` or `cadd` |
| `git commit` | `dotbare commit` or `config commit` |
| `git diff` | `dotbare diff` or `cdiff` |
| `git push` | `dotbare push` or `cgp` |

Aliases: `config`, `cfg`, `cadd`, `cstat`, `clog`, `cdiff`

### File Locations

| File | Purpose |
|------|---------|
| `.zshrc` | Main interactive shell config |
| `.zshenv` | PATH (runs first) |
| `.zprofile` | Homebrew setup (login shells only) |
| `.zshrc.local` | **Machine-specific, do not track** |
| `.aliases.zsh` | Aliases for modern tools |
| `Brewfile` | Homebrew packages + VS Code extensions |
| `.tool-versions` | asdf language versions |
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
- Don't add `node` (use asdf)
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
| `bin/*.zsh` scripts | Scripts with API keys/secrets |

### Submodules

This repo uses git submodules:
- `repos/base16-shell` - Base16 color schemes
- `repos/oh-my-zsh/custom/plugins/dotbare` - Dotbare plugin
- `repos/oh-my-zsh/custom/themes/powerlevel10k` - P10k theme

Update with:
```bash
dotbare submodule update --init --recursive
dotbare submodule update --remote
```

### Bootstrap Testing

If modifying `bin/bootstrap-dotfiles.zsh`:
1. Test in a fresh macOS VM or spare machine
2. The script is destructive (overwrites configs, installs software)
3. Key line: `dotbare finit -u https://github.com/rgildea/.dotfiles-bare.git`
