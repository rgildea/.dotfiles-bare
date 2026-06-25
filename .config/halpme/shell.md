### Shell & Navigation
<!-- halpme: shell | Directory jumps, command line editing, autosuggestions, and modern tool replacements -->

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
| Accept full suggestion | `→` or `End` or `Ctrl+E` or `Ctrl+Space` |
| Accept one char | `Ctrl+F` |
| Ignore suggestion | Keep typing |

> `Tab` triggers **completion** (what *could* be valid: files, commands, flags), not history-based autosuggestion. Completions are shown in an interactive fzf picker via **fzf-tab** — use arrow keys or type to filter, `Enter` to accept. The two systems are independent.

**Modern tool replacements** (auto-aliased when installed):

| You type | Actually runs | Why it's better |
|----------|--------------|-----------------|
| `cat file` | `bat` | Syntax highlighting, line numbers |
| `less file` | `bat --paging=always` | Same, with paging |
| `ls` | `eza` | Colors, git status, icons |
| `ll` | `eza -l --git` | Long format with git info |
| `lt` | `eza -T --git` | Tree view |
| `grep` | `grep --color=auto` | Colorized output |
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

**Navigating less (git diffs, halpme, man pages, etc.):**

| Action | Keys |
|--------|------|
| Quit | `q` |
| Forward / back one page | `Ctrl+F` / `Ctrl+B` |
| Forward / back one line | `j` / `k` |
| Start / end of file | `g` / `G` |
| Search forward | `/pattern` |
| Next / prev match | `n` / `N` |

**Reloading the shell:**

Use `exec zsh -l` (aliased as `reload`) — not `source` — to get a clean slate after config changes.

```
reload                    # exec zsh -l — replaces the process, clean slate
```

`source ~/.zshrc` is NOT the same — it layers on top and causes drift.

---

### Finding Aliases
<!-- halpme: find | halpme, tldr, als — discover shortcuts and docs -->

Tools for discovering what shortcuts exist and jumping to documentation.

```
halpme                    # full guide (TOC)
halpme git                # jump straight to the Git Workflow section
halpme <keyword>          # any section whose title contains the keyword
als <pattern>             # search all active aliases, e.g. als git
alias-finder              # type a command, see if an alias exists for it
```

**tldr** is the complement to `halpme` for standard CLI tools — practical examples instead of exhaustive man pages. Use it when you forget the syntax for something you don't use every day.

```
tldr tar                  # the extract/create recipes, no flags archaeology
tldr ssh                  # common ssh usage patterns
tldr rsync                # the copy/sync incantations you always forget
tldr <any unix command>   # works for most standard tools
```

Rule of thumb: `halpme` for your custom setup, `tldr` for the rest of the Unix universe.

---
