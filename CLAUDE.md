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
- Use `dotbare commit -m "..."` not raw `git commit` in this repo

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
| `.agents/.skill-lock.json` | Agent cache, symlinks |
| `.agents/skills/*/SKILL.md` | |

### Agent Skills

Global agent skills live in `~/.agents/skills/` and are tracked in dotfiles. Agent-specific symlinks (e.g. `~/.claude/skills/`) are **not** tracked — they are recreated on demand.

**Install a new skill (adds to lock file + creates symlinks):**
```bash
npx skills add <owner/repo> -g -y
```

**After dotfiles checkout on a new machine:**
```bash
skills-restore   # replays npx skills add -g for every entry in ~/.agents/.skill-lock.json
```

**After installing a new skill, commit the updated files:**
```bash
dotbare add ~/.agents/.skill-lock.json ~/.agents/skills/<name>/SKILL.md
dotbare commit -m "chore(skills): add <name> skill"
```

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
