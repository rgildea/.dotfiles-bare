# Dotfiles Improvement Backlog

Items identified during review, ordered roughly by ROI.

## Done

- [x] Replace `grep='rg'` with capability-guarded `grep --color=auto`
- [x] Replace `find='ffind'` with `find='fd'`
- [x] Rename `gc='git cz'` → `gcz` (conflicts with OMZ's `gc`)
- [x] Remove `thefuck` from plugins and Brewfile
- [x] Bump `HISTSIZE`/`SAVEHIST` from 10k to 100k
- [x] Make compinit handling robust: `skip_global_compinit=1` unconditional, explicit fallback if `zsh-autocomplete` is missing
- [x] Guard plugin sources (`zsh-syntax-highlighting`, `zsh-autosuggestions`, `zsh-autocomplete`) with file existence checks
- [x] Remove `gnupg` (unused — commit signing handled by 1Password SSH)
- [x] Remove `caffeine` (redundant with macOS Sonoma screen wake lock)
- [x] Remove `ms-azuretools.vscode-containers` (duplicate of `vscode-docker`)
- [x] **`asdf` → `mise`** — Drop-in replacement, reads existing `.tool-versions`, dramatically faster activation

## To Do

### High ROI

- [x] **Docker Desktop → OrbStack** — Same containers, fraction of the CPU/RAM overhead, better macOS-native experience. Replace `cask "docker-desktop"` with `cask "orbstack"`.

- [x] **Alfred → Raycast** — Alfred development has stalled. Raycast is free, more extensible, where the developer community has moved. Replace `cask "alfred"` with `cask "raycast"`.

### Medium ROI

- [x] **Powerlevel10k → Starship** — P10k development has essentially stopped. Starship is cross-shell, written in Rust, actively maintained, no instant prompt needed. Would remove the `romkatv/powerlevel10k` tap, `brew "powerlevel10k"`, `cask "font-meslo-for-powerlevel10k"`, and `.p10k.zsh`. Requires an hour of config work.

- [x] **`zsh-autocomplete` → `fzf-tab`** — `zsh-autocomplete` is opinionated, occasionally conflicts with things, and owns `compinit` in a way that's caused us trouble. `fzf-tab` routes completions through fzf without the compinit ownership issues.

### Lower ROI / Larger Project

- [ ] **Oh My Zsh → sheldon or zinit** — OMZ is the main source of shell startup latency. A lightweight plugin manager with just the plugins you actually use would be noticeably faster. Real time investment to migrate.
