### Ghostty
<!-- halpme: ghostty | Fast GPU-rendered terminal -->

Ghostty is the primary terminal — GPU-rendered, fast startup, native macOS feel.

**Configuration** lives at `~/.config/ghostty/config` (not tracked). Minimal example:
```
font-family = Monaspace Neon
font-size = 14
theme = dark
```

**Built-in tab and split management** (no tmux needed for basic use):

| What | Keys |
|------|------|
| New tab | `⌘T` |
| Close tab | `⌘W` |
| Next / prev tab | `⌘⇧]` / `⌘⇧[` |
| Split right | `⌘D` |
| Split down | `⌘⇧D` |
| Navigate splits | `⌘⌥` + arrow |

iTerm2 remains installed alongside Ghostty — switch if you need features not yet in Ghostty.

---

### tmux
<!-- halpme: tmux | Multiplexer — sessions, windows, panes, copy mode -->

Config lives at `~/.config/tmux/tmux.conf` (tracked in dotfiles).

**Prefix:** `Ctrl+Space` (not the default `Ctrl+B`)

**Sessions:**

| What | Command / Keys |
|------|---------------|
| New session | `tmux new -s name` |
| Attach to session | `tmux attach -t name` |
| List sessions | `tmux ls` |
| Detach | `prefix d` |
| Switch session | `prefix $` (rename), `prefix s` (list) |

**Windows:**

| What | Keys |
|------|------|
| New window | `prefix c` |
| Next window | `Alt+Shift+L` (no prefix) |
| Previous window | `Alt+Shift+H` (no prefix) |
| Rename window | `prefix ,` |
| Close window | `prefix &` |

**Panes:**

| What | Keys |
|------|------|
| Split horizontal (pane below) | `prefix "` |
| Split vertical (pane right) | `prefix %` |
| Navigate left/down/up/right | `Ctrl+H` / `Ctrl+J` / `Ctrl+K` / `Ctrl+L` |
| Resize pane | `prefix` + arrow keys |
| Close pane | `prefix x` |
| Zoom pane (toggle) | `prefix z` |

> Navigation uses **vim-tmux-navigator** — `Ctrl+H/J/K/L` works seamlessly across tmux panes and vim splits without a prefix.
> Splits open in the current pane's working directory.

**Copy mode (vi-style):**

```
prefix [          # enter copy mode
v                 # begin selection
C-v               # toggle rectangle selection
y                 # copy to system clipboard (tmux-yank) and exit
q                 # cancel
```

**Plugins (managed by TPM at `~/.tmux/plugins/tpm`):**

| Plugin | Purpose |
|--------|---------|
| `tmux-sensible` | Sane defaults (larger history, faster escape, etc.) |
| `tmux-yank` | Copies to system clipboard in copy mode |
| `vim-tmux-navigator` | Unified pane navigation with vim |

To install new plugins: add `set -g @plugin '...'` to `tmux.conf`, then `prefix I`.

---
