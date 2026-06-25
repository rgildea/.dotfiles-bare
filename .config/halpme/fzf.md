### FZF
<!-- halpme: fzf | Shell keybindings, fzf-tab completion, and fd integration -->

FZF is wired into the shell with `fd` as the backend (respects `.gitignore`, faster than `find`).

**Shell keybindings:**

| Keys | What it does |
|------|-------------|
| `Ctrl+T` | Fuzzy-insert a file path at the cursor |
| `Ctrl+R` | Fuzzy-search shell history, paste selected command |
| `Alt+C` | Fuzzy-select a directory and `cd` into it |

> All three search from `$HOME` by default — type to filter, `Enter` to accept, `Esc` to cancel.

**fzf-tab (replaces zsh completion menu):**

When you press `Tab`, fzf-tab intercepts and shows completions in an fzf picker instead of the default zsh menu.

```
ls <Tab>             # file picker
git checkout <Tab>   # branch picker
kill <Tab>           # process picker
```

Navigate with arrow keys or type to filter. `Enter` accepts. Multiple selections with `Tab` before `Enter`.

> `Tab` = completions (what *could* be valid). `Ctrl+R` = history (what you typed before). They're independent.

**Layout:** `--layout=reverse --border` — list appears at the top of the picker, input at the bottom.

**Direct usage:**

```
fzf                          # pipe stdin or search files, output selected line
ls | fzf                     # filter any list
fzf --preview 'bat {}'       # with syntax-highlighted file preview
```

---
