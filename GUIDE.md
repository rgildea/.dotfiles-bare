# Field Guide

> You spent a long time setting this up. Here's what you built.
> Search with `/` in this pager. Quit with `q`.

---

## Dotfiles
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
e ~/.aliases.zsh          # edit in VS Code
cstat                     # confirm what changed
cdiff .aliases.zsh        # review the diff
cadd .aliases.zsh
cfg commit -m "feat(aliases): add brewi wrapper"
cgp
```

**What's tracked vs. ignored:**
- Tracked: `.zshrc`, `.zshenv`, `.aliases.zsh`, `Brewfile`, `.gitconfig`, `bin/*.zsh`
- Never tracked: `.zshrc.local` (API keys, machine config), `bin/claude-or.zsh`

---

## Homebrew & Brewfile
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

## Making a Commit
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

## Git Workflow
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

## Shell & Navigation
<!-- halp: shell | Directory jumps and modern tool replacements -->

**Directory shortcuts:**
```
dl                        # ~/Downloads
dt                        # ~/Desktop
p                         # ~/projects
dots                      # ~/.cfg (dotfiles repo)
```

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

---

## Version Management (asdf)
<!-- halp: asdf | Language versions pinned in .tool-versions -->

Languages are managed by **asdf**. Versions are pinned in `~/.tool-versions`.

```
asdf current              # see active versions of everything
asdf list nodejs          # see installed Node versions
asdf install nodejs 22.0.0   # install a version
asdf local nodejs 22.0.0     # pin for current project (.tool-versions)
asdf global nodejs 24.15.0   # set global default
```

**Active versions:**
- Node: 24.15.0
- Ruby: 3.3.0
- Python: 3.12.1
- Yarn: 1.22.19

---

## NPM Shortcuts
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

## Finding Aliases
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

## Reloading the Shell
<!-- halp: reload | exec zsh -l for a clean slate after config changes -->

Use `exec zsh -l` (aliased as `reload`) — not `source` — to get a clean slate after config changes.

```
reload                    # exec zsh -l — replaces the process, clean slate
```

Use this after editing `.zshrc`, `.aliases.zsh`, or `.zshenv`.
`source ~/.zshrc` is NOT the same — it layers on top and causes drift.

---

## AI / OpenRouter
<!-- halp: ai | claude and claude-or, keys in .zshrc.local -->

Run Claude via Anthropic API or OpenRouter — keys live in `~/.zshrc.local` (never committed).

```
claude                    # Claude via Anthropic API (uses key from ~/.zshrc.local)
claude-or                 # Claude via OpenRouter (uses OPENROUTER_API_KEY from ~/.zshrc.local)
```

---

## GCloud
<!-- halp: gcloud | gct for streaming build logs -->

Quick access to Google Cloud build logs for the current project.

```
gct                       # tail build logs for current gcloud project
```

---

## This Guide
<!-- halp: guide | Navigate with halp, halp me, halp KEYWORD -->

How to navigate this guide — open it, get the TOC, or jump to a section by keyword.

```
halp                      # open full guide in glow (paged)
halp me                   # TOC with descriptions
halp <keyword>            # show one section, e.g. halp git, halp brew, halp commit
e ~/GUIDE.md              # edit in VS Code
```

The guide lives at `~/GUIDE.md` and is tracked in your dotfiles.
