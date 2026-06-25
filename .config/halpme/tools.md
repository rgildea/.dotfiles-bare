### NPM Shortcuts
<!-- halpme: npm | ni, nrd, nrt, rmn and friends -->

Handy aliases for common npm tasks — install, build, dev, test, and nuking `node_modules`.

```
ni                        # npm install
nrs                       # npm run start
nrb                       # npm run build
nrd                       # npm run dev
nrt                       # npm run test
nrtw                      # npm run test:watch
rmn                       # rm -rf node_modules
flush-npm                 # nuke node_modules + lockfile + reinstall
```

---

### AI / OpenRouter
<!-- halpme: ai | claude and claude-or, keys in .zshrc.local -->

Run Claude via Anthropic API or OpenRouter — keys live in `~/.zshrc.local` (never committed).

```
claude                    # Claude via Anthropic API (uses key from ~/.zshrc.local)
claude-or                 # Claude via OpenRouter (uses OPENROUTER_API_KEY from ~/.zshrc.local)
```

---

### Agent Skills
<!-- halpme: skills | Install and restore agent skills across machines -->

Global agent skills live in `~/.agents/skills/` and are tracked in dotfiles. Agent-specific symlinks (e.g. `~/.claude/skills/`) are not tracked — recreated on demand.

```
npx skills add <owner/repo> -g -y   # install a skill
skills-restore                       # replay all skills from lock file
```

After installing a new skill, commit the updated files:
```
cadd ~/.agents/.skill-lock.json ~/.agents/skills/<name>/SKILL.md
cfg commit -m "chore(skills): add <name> skill"
cgp
```

Browse skills at [skills.sh](https://skills.sh) or search GitHub for repos tagged `agent-skills`.

---

### Claude Code
<!-- halpme: claude | Agentic coding with Claude Code and MCP servers -->

Claude Code is the primary agentic coding tool. Runs in the terminal, operates on your codebase, and has access to MCP servers for GitHub, filesystem, and web fetch.

```
claude                    # start a session
claude mcp list           # verify MCP servers are connected
```

**MCP servers configured** (via `~/.claude.json`):
- `filesystem` — read/write to `$HOME` and `$HOME/projects`
- `github` — GitHub API (token from `GITHUB_PERSONAL_ACCESS_TOKEN` in `.zshrc.local`)
- `fetch` — URL retrieval for docs and research

**Keys in `.zshrc.local`** (never committed):
```
ANTHROPIC_API_KEY         # required for Zed assistant panel (not Claude Code — that uses interactive login)
GITHUB_PERSONAL_ACCESS_TOKEN  # written by bootstrap via op read
```

---

### Zed
<!-- halpme: zed | Fast editor with built-in AI assistant -->

Zed is a fast, GPU-rendered editor. Works out of the box — open a file or project and go.

```
zed .                     # open current directory
zed ~/.aliases.zsh        # open a specific file
```

**AI Assistant panel** (`Ctrl+?` or via menu):
- Sign in at zed.dev for a free tier (no API key needed)
- Or add `ANTHROPIC_API_KEY` to `.zshrc.local` and set `provider: anthropic` in settings

**Settings** live at `~/.config/zed/settings.json` (not tracked). The bootstrap creates a stub with Monaspace Neon and Claude as the assistant model. To edit:
```
zed ~/.config/zed/settings.json
```

**Key differences from VS Code:**
- No extension marketplace — language servers install automatically via built-in support
- Vim mode available: `"vim_mode": true` in settings
- Multibuffer editing — open multiple files in one surface

---

### GCloud
<!-- halpme: gcloud | gct for streaming build logs -->

Quick access to Google Cloud build logs for the current project.

```
gct                       # tail build logs for current gcloud project
```

---
