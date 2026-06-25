### Starship Prompt
<!-- halpme: starship | Prompt segments, colors, and what each indicator means -->

Config at `~/.config/starship.toml` (tracked in dotfiles). Changes take effect on `reload`.

**Prompt segments (left to right):**

| Segment | What it shows | When visible |
|---------|--------------|--------------|
| `directory` | Current path (4 levels, truncated to repo root) | Always |
| `git_branch` | Branch name with  icon | Inside a git repo |
| `git_status` | Staged/modified/untracked/ahead/behind counts | Inside a git repo |
| `nodejs` | Node version via  icon | `.nvmrc`, `package.json`, or mise Node active |
| `python` | Python version + venv | `.python-version`, `pyproject.toml`, or venv active |
| `ruby` | Ruby version | `.ruby-version`, `Gemfile` |
| `rust` | Rust version | `Cargo.toml` |
| `golang` | Go version | `go.mod` |
| `cmd_duration` | Time taken | Commands that took > 2 seconds |
| `time` | Current time (HH:MM) | Right prompt, always |

**Git status symbols:**

| Symbol | Meaning |
|--------|---------|
| `+N` | N staged files |
| `!N` | N modified files |
| `?N` | N untracked files |
| `*N` | N stashed changes |
| `✘N` | N deleted files |
| `=N` | N merge conflicts |
| `⇡N` | N commits ahead of remote |
| `⇣N` | N commits behind remote |
| `⇕⇡N⇣N` | Diverged — both ahead and behind |

**Custom GCloud segment:**

Shows the active GCP project when the current directory contains `app.yaml`, `cloudbuild.yaml`, `.gcloudignore`, or a `*.tf` file.

```
gcloud config set project my-project   # change active project
gcloud config get-value project        # check what's active
```

**Colors** (Darktooth palette):

| Element | Color |
|---------|-------|
| Directory | Teal `#0D6678` |
| Git branch | Purple `#8F4673` |
| Git status | Red `#FB543F` |
| Language versions | Green `#95C085` |
| Command duration | Yellow `#FAC03B` |
| Time | Dimmed grey `#665C54` |

**Editing the prompt:**

```
e ~/.config/starship.toml   # edit
reload                      # apply changes
```

To disable a language segment (e.g. Go), add to the config:
```toml
[golang]
disabled = true
```

---
