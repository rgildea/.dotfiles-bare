### Lazygit
<!-- halpme: lazygit | Visual git TUI — review diffs, stage hunks, manage branches -->

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
<!-- halpme: git | Daily aliases, undo, stash, conflict resolution -->

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
| Diff (delta) | `gd` |
| Log (visual graph) | `glog` |
| Checkout | `gco branch-name` |
| New branch | `gcb new-feature` |
| Stage all + commit | `gac "feat: ..."` |

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
<!-- halpme: commit | Conventional Commits via gcz (Commitizen) or gac (fast) -->

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
gcz                       # interactive Commitizen prompt (git cz) — use this to build the habit
gac "feat(ui): add dark mode toggle"   # fast path when you already know the format
```

> `gc` is oh-my-zsh's `git commit` — opens your editor with the `.gitmessage` template. Use `gcz` for the full interactive Commitizen CLI.

**Workflow — interactive commit:**
```
gapa                      # stage selectively (git add --patch)
gcz                       # launches Commitizen: pick type → scope → subject → body
gp                        # push
```

**Escaping the hook** (merge/revert/fixup commits pass through automatically):
```
git commit -m "Merge branch 'main'"   # fine, hook allows it
```

---
