### Dotfiles
<!-- halpme: dots | Manage config files with cfg, cadd, cgp -->

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

**Syncing an existing machine** (after merging changes to main):
```
dotsync                   # pull latest dotfiles, brew bundle, mise install, skills-restore
dotsync my-branch         # sync a specific branch
```

**What's tracked vs. ignored:**
- Tracked: `.zshrc`, `.zshenv`, `.aliases.zsh`, `Brewfile`, `.gitconfig`, `bin/*.zsh`
- Never tracked: `.zshrc.local` (API keys, machine config)

---

### Homebrew & Brewfile
<!-- halpme: brew | Install packages with brewi/brewci, track in Brewfile -->

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
<!-- halpme: mise | Language versions pinned in .tool-versions -->

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
- Ruby: 3.4.9
- Python: 3.13.2
- SQLite: 3.53.1

> mise is a drop-in replacement for asdf. Note: mise uses `node` as the tool name where asdf used `nodejs` — update any `.tool-versions` files accordingly.

---
