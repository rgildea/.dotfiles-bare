# Field Guide

> You spent a long time setting this up. Here's what you built.
> Search with `/` in this pager. Quit with `q`.

---

## Intro

### This Guide
<!-- halp: guide | Navigate with halp, halp me, halp KEYWORD -->

How to navigate this guide — open it, get the TOC, or jump to a section by keyword.

```
halp                      # open full guide in glow (paged)
halp me                   # TOC with descriptions
halp <keyword>            # show one section, e.g. halp git, halp brew, halp commit
e ~/GUIDE.md              # edit in your editor
```

The guide lives at `~/GUIDE.md` and is tracked in your dotfiles.

---

### Shell & Navigation
<!-- halp: shell | Directory jumps, command line editing, autosuggestions, and modern tool replacements -->

**Directory shortcuts:**
```
home                      # ~
p                         # ~/projects
bin                       # ~/bin
agents                    # ~/.agents
dl                        # ~/Downloads
dt                        # ~/Desktop
docs                      # ~/Documents
```

**Command line editing (Zsh emacs mode):**

These work at the prompt — no plugin required.

| Move | Keys |
|------|------|
| Start / end of line | `Ctrl+A` / `Ctrl+E` |
| Back / forward one char | `Ctrl+B` / `Ctrl+F` |
| Back / forward one word | `Alt+B` / `Alt+F` |
| Delete word backward | `Ctrl+W` |
| Delete to start of line | `Ctrl+U` |
| Delete to end of line | `Ctrl+K` |
| Reverse history search | `Ctrl+R` |
| Clear screen | `Ctrl+L` |

**Autosuggestions (zsh-autosuggestions):**

As you type, a grey ghost suggestion appears from your history.

| Action | Keys |
|--------|------|
| Accept full suggestion | `→` (right arrow) or `End` or `Ctrl+E` |
| Accept one char | `Ctrl+F` |
| Ignore suggestion | Keep typing |

> `Tab` is different — it triggers **completion** (what *could* be valid: files, commands, flags), not history-based autosuggestion. The two systems are independent.

**Modern tool replacements** (auto-aliased when installed):

| You type | Actually runs | Why it's better |
|----------|--------------|-----------------|
| `cat file` | `bat` | Syntax highlighting, line numbers |
| `less file` | `bat --paging=always` | Same, with paging |
| `ls` | `eza` | Colors, git status, icons |
| `ll` | `eza -l --git` | Long format with git info |
| `lt` | `eza -T --git` | Tree view |
| `grep` | `ripgrep` | Faster, respects .gitignore |
| `find` | `fd` | Simpler syntax, faster |
| `df` | `duf` | Visual disk usage |
| `top` | `htop` | Interactive process viewer |
| `ping` | `prettyping` | Visual ping output |
| `ps` | `procs` | Readable process list |

**Directory jumping (zoxide):**

zoxide learns which directories you visit and lets you jump to them by partial name.

```
z projects                # jump to ~/projects (or wherever you go most)
z dot                     # jumps to ~/.dotfiles-bare or similar
zi                        # interactive fuzzy picker (fzf-powered)
```

> `z` is separate from `cd` — use `cd` for explicit paths, `z` for frecency-based jumps.

**Useful one-liners:**
```
killport 3000             # kill whatever's on port 3000
ports                     # list listening ports (lsof)
ip                        # your public IP
weather                   # wttr.in forecast
week                      # current week number
now                       # current time
diskspace                 # disk usage (non-virtual)
```

**Navigating less (git diffs, halp, man pages, etc.):**

| Action | Keys |
|--------|------|
| Quit | `q` |
| Forward / back one page | `Ctrl+F` / `Ctrl+B` |
| Forward / back one line | `j` / `k` |
| Start / end of file | `g` / `G` |
| Search forward | `/pattern` |
| Next / prev match | `n` / `N` |

See the Vim section for a full vim/less comparison.

**Reloading the shell:**

Use `exec zsh -l` (aliased as `reload`) — not `source` — to get a clean slate after config changes.

```
reload                    # exec zsh -l — replaces the process, clean slate
```

`source ~/.zshrc` is NOT the same — it layers on top and causes drift.

---

### Finding Aliases
<!-- halp: find | halp, tldr, als — discover shortcuts and docs -->

Tools for discovering what shortcuts exist and jumping to documentation.

```
halp                      # full guide (paged)
halp me                   # TOC — section headers with short descriptions
halp git                  # jump straight to the Git Workflow section
halp <keyword>            # any section whose title contains the keyword
als <pattern>             # search all active aliases, e.g. als git
alias-finder              # type a command, see if an alias exists for it
```

**tldr** is the complement to `halp` for standard CLI tools — practical examples instead of exhaustive man pages. Use it when you forget the syntax for something you don't use every day.

```
tldr tar                  # the extract/create recipes, no flags archaeology
tldr ssh                  # common ssh usage patterns
tldr rsync                # the copy/sync incantations you always forget
tldr <any unix command>   # works for most standard tools
```

Rule of thumb: `halp` for your custom setup, `tldr` for the rest of the Unix universe.

---

## Dotfiles & Package Management

### Dotfiles
<!-- halp: dots | Manage config files with cfg, cadd, cgp -->

Your config lives in a bare git repo at `~/.cfg`, managed via **dotbare** (`cfg` = `config` = `dotbare`).
Never use plain `git` from the home directory — use these instead:

| What | Command |
|------|---------|
| See what's changed | `cstat` or `cdiff` |
| Stage a file | `cadd .zshrc` |
| Commit | `cfg commit -m "chore: update zsh config"` |
| Push | `cgp` |
| View history | `clog` |
| Go to repo | `dots` |

**Workflow — editing a config file:**
```
e ~/.aliases.zsh          # edit in your editor
cstat                     # confirm what changed
cdiff .aliases.zsh        # review the diff
cadd .aliases.zsh
cfg commit -m "feat(aliases): add brewi wrapper"
cgp
```

**What's tracked vs. ignored:**
- Tracked: `.zshrc`, `.zshenv`, `.aliases.zsh`, `Brewfile`, `.gitconfig`, `bin/*.zsh`
- Never tracked: `.zshrc.local` (API keys, machine config)

---

### Homebrew & Brewfile
<!-- halp: brew | Install packages with brewi/brewci, track in Brewfile -->

The `Brewfile` is the source of truth. Use wrappers so it stays current.

| What | Command |
|------|---------|
| Install a formula + record it | `brewi ripgrep` |
| Install a cask + record it | `brewci rectangle` |
| Uninstall + record removal | `brewun old-tool` |
| See what's installed but not recorded | `brewdrift` |
| Catch up after raw `brew` commands | `brewsync` |
| Install everything from Brewfile | `brew bundle` |

**Workflow — installing new software:**
```
brewi fzf                 # installs and dumps Brewfile automatically
cdiff Brewfile            # review the recorded change
cadd Brewfile
cfg commit -m "chore(Brewfile): add fzf"
cgp
```

**Workflow — auditing drift:**
```
brewdrift                 # lists packages not in Brewfile
brewsync                  # dumps current state, shows diff
```

---

### Version Management (mise)
<!-- halp: mise | Language versions pinned in .tool-versions -->

Languages are managed by **mise** (replaces asdf — faster, same `.tool-versions` format).

```
mise current              # see active versions of everything
mise list node            # see installed Node versions
mise install node@22.0.0  # install a version
mise use node@22.0.0      # pin for current project (.tool-versions)
mise use --global node@24.15.0  # set global default
```

**Active versions** (from `~/.tool-versions`):
- Node: 24.15.0
- Ruby: 3.3.0
- Python: 3.12.1
- SQLite: 3.45.1

> mise is a drop-in replacement for asdf. All existing `.tool-versions` files work unchanged.

---

## Daily Workflow

### Lazygit
<!-- halp: lazygit | Visual git TUI — review diffs, stage hunks, manage branches -->

Terminal UI for git — essential for reviewing agent commits before pushing.

```
lg                        # open lazygit (alias)
```

**Key bindings inside lazygit:**

| What | Key |
|------|-----|
| Navigate panels | `h` `j` `k` `l` / arrow keys |
| Stage file / hunk | `Space` |
| Stage all | `a` |
| Commit | `c` |
| Push | `P` |
| Pull | `p` |
| Checkout branch | `Space` (in branches panel) |
| View diff | `Enter` on a file |
| Quit | `q` |

> Use `[` and `]` to switch between panels (Files, Branches, Commits, Stash, etc.)

---

### Git Workflow
<!-- halp: git | Daily aliases, undo, stash, conflict resolution -->

Your gitconfig is opinionated. Here's what it does for you automatically:
- `git pull` rebases instead of merging
- `git push` auto-sets upstream on new branches
- `git fetch` always prunes deleted remote branches
- Commits are GPG-signed via 1Password SSH agent

**Daily aliases:**

| What | Command |
|------|---------|
| Status (compact) | `gs` |
| Pull + prune | `gl` |
| Push to origin | `gp` |
| Diff (diff-so-fancy) | `gd` |
| Log (visual graph) | `glog` |
| Checkout | `gco branch-name` |
| New branch | `gcb new-feature` |
| Stage all + commit | `gac "feat: ..."` |
| Copy branch name | `gcopy` |

**Undo things safely:**

```
git unstage               # unstage everything (keeps changes)
git uncommit              # undo last commit (keeps changes staged)
git fp                    # force push with --force-with-lease (safe)
git ahead                 # see commits ahead of main
```

**Stash workflow:**
```
gstu                      # stash including untracked files
gstl                      # list stashes
gstp                      # pop latest stash
gsts                      # show stash diff
```

**Conflict resolution:**
`zdiff3` conflict style is configured — you get three sections:
yours | original | theirs. The original helps you understand intent.

---

### Making a Commit
<!-- halp: commit | Conventional Commits via gc (interactive) or gac (fast) -->

All commits must follow **Conventional Commits** format.
A `commit-msg` hook enforces this globally — bad messages are rejected.

**Format:** `type(scope): subject`

| Type | Use for |
|------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `chore` | Config, deps, tooling |
| `docs` | Documentation |
| `refactor` | Restructure, no behavior change |
| `ci` | CI/CD |
| `perf` | Performance |
| `test` | Tests |

**The two commit paths:**

```
gc                        # interactive Commitizen prompt — use this to build the habit
gac "feat(ui): add dark mode toggle"   # fast path when you already know the format
```

**Workflow — interactive commit:**
```
gapa                      # stage selectively (git add --patch)
gc                        # launches Commitizen: pick type → scope → subject → body
gp                        # push
```

**Escaping the hook** (merge/revert/fixup commits pass through automatically):
```
git commit -m "Merge branch 'main'"   # fine, hook allows it
```

---

### Vim
<!-- halp: vim | Modes, motions, plugins, and your custom mappings -->

One rule: **you are always in Normal mode by default.** Insert mode is temporary.
Return to Normal with `jk` — it's your escape hatch and it's already wired up.

**Getting unstuck:**

| Symptom | Fix |
|---------|-----|
| Nothing I type appears | You're in Normal — that's correct, `i` to insert |
| Everything looks broken | `jk` then `u` to undo |
| Stuck in some sub-mode | `<Esc><Esc>` clears it |
| Accidentally recording a macro | `q` to stop |
| Can't quit | `:q!` force-quit without saving |

**The two gears:**

```
Normal → Insert     i (before cursor)  a (after)  o (new line below)  O (above)
Insert → Normal     jk  or  kj  ← your mappings, faster than reaching for Esc
Normal → Visual     v (char)   V (line)   <C-v> (block)
Any → Normal        <Esc>  (fallback)
```

**Saving:**

```
<C-s>               save from insert or normal mode (your mapping)
:w                  also works from Normal
:wq                 save and quit
:q!                 quit without saving
```

**Moving around (Normal mode):**

| Move | Keys |
|------|------|
| Left / down / up / right | `h` `j` `k` `l` |
| Next / prev word | `w` `b` |
| End of word | `e` |
| Start / end of line | `0` `$` |
| First / last line | `gg` `G` |
| Jump to line 42 | `42G` or `:42` |
| Next / prev paragraph | `{` `}` |
| Find char on line | `f<char>` — `;` to repeat |
| Jump back / forward | `<C-o>` / `<C-i>` |

**Editing — operator + motion:**

```
d + motion    delete    dw (word)  dd (line)  d$ (to end)  d3j (3 lines)
c + motion    change    cw (word, drops into insert)  cc (whole line)
y + motion    yank      yy (line)  y$ (to end)
p / P         paste     after cursor / before cursor
x             delete char under cursor
u / <C-r>     undo / redo
.             repeat last change  ← use this constantly
```

**Your custom mappings:**

| What | Keys |
|------|------|
| Escape insert mode | `jk` or `kj` |
| Save | `<C-s>` (insert or normal) |
| Find files (FZF) | `<Space>F` |
| Move line down / up | `<A-j>` / `<A-k>` (all modes) |
| Edit vimrc | `<Space>vr` |
| Reload vimrc | `<Space>so` |

**Plugins:**

*vim-commentary — toggle comments:*
```
gcc             comment/uncomment current line
gc + motion     comment a range  (gcj = this + next line)
```

*vim-surround — wrap, change, or delete surrounding chars:*
```
cs"'            change surrounding " to '
ds"             delete surrounding "
ysiw"           wrap word under cursor in quotes  (ys + motion + char)
```

*FZF — fuzzy finding:*
```
<Space>F        find files in project
:Buffers        switch between open buffers
:Rg             ripgrep search across all files
:GFiles         git-tracked files only
```

*ALE — linting:*
```
]e / [e         jump to next / prev error
:ALEDetail      show full error message
```

*Copilot:*
```
Tab             accept suggestion
<C-]>           dismiss suggestion
:Copilot        check status / enable
```

**Search:**
```
/pattern        search forward  (n next, N prev)
*               search word under cursor
:%s/old/new/gc  find and replace with confirmation
```

**Paging — vim vs. less:**

Both share the same core bindings. `Space`/`b` exist in less but can't be used in vim (taken by other motions).

| Action | vim | less |
|--------|-----|------|
| Forward one line | `j` | `j` / `e` / `Enter` |
| Back one line | `k` | `k` / `y` |
| Forward one page | `Ctrl+F` | `Ctrl+F` / `Space` |
| Back one page | `Ctrl+B` | `Ctrl+B` / `b` |
| Forward half page | `Ctrl+D` | `d` |
| Back half page | `Ctrl+U` | `u` |
| Start of file | `gg` | `g` |
| End of file | `G` | `G` |
| Search forward | `/pattern` | `/pattern` |
| Search backward | `?pattern` | `?pattern` |

---

## Tools & Domain-Specific

### NPM Shortcuts
<!-- halp: npm | ni, nrd, nrt, rmn and friends -->

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
<!-- halp: ai | claude and claude-or, keys in .zshrc.local -->

Run Claude via Anthropic API or OpenRouter — keys live in `~/.zshrc.local` (never committed).

```
claude                    # Claude via Anthropic API (uses key from ~/.zshrc.local)
claude-or                 # Claude via OpenRouter (uses OPENROUTER_API_KEY from ~/.zshrc.local)
```

---

### Agent Skills
<!-- halp: skills | Install and restore agent skills across machines -->

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
<!-- halp: claude | Agentic coding with Claude Code and MCP servers -->

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
<!-- halp: zed | Fast editor with built-in AI assistant -->

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
<!-- halp: gcloud | gct for streaming build logs -->

Quick access to Google Cloud build logs for the current project.

```
gct                       # tail build logs for current gcloud project
```

---

### macOS Defaults
<!-- halp: macos | System preferences applied by sane-macos-defaults.sh -->

Applied by `bin/sane-macos-defaults.sh` during bootstrap. Re-run any time — all idempotent.

```bash
~/bin/sane-macos-defaults.sh
```

**General UI/UX:** boot sound off, scrollbars always visible, save panels expanded, no iCloud default save, app resume off, auto-correct/capitalize/dashes/quotes all off

**Trackpad & Keyboard:** tap to click, two-finger right-click, fast key repeat (rate 2, delay 15), press-and-hold off

**Energy:** wake on lid open, auto-restart on power loss or freeze, display sleep 15 min

**Screen & Screenshots:** password required immediately after sleep, screenshots to `~/Screenshots` as PNG, no drop shadow

**Finder:** hidden files shown, all extensions shown, path bar visible, full POSIX path in title, folders sorted to top, search defaults to current folder, list view default

**Dock:** left side, 36px icons, scale minimize, auto-hide no delay, no recent apps, no opening animation, bottom-right hot corner starts screensaver

**Safari:** Develop menu on, search suggestions off (privacy), auto-open downloads off

**iTerm:** no quit confirmation, prefs loaded from `~/.config/com.googlecode.iterm2/`

**Other:** TextEdit plain text mode, Photos won't auto-open, Time Machine won't use new disks, daily software update checks
