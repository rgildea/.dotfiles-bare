### Working on Bootstrap / Scripts
<!-- halpme: dev | Developing and testing bootstrap changes with Tart VMs -->

Changes to `bin/bootstrap-dotfiles.zsh` or other scripts need to be tested on a clean machine. Use [Tart](https://tart.run) for Apple Silicon VMs.

**One-time base image setup:**
```bash
tart clone ghcr.io/cirruslabs/macos-sequoia-vanilla:latest sequoia-base
tart run sequoia-base  # enable SSH, create your user account, then stop
```

**Each test run — always start fresh:**
```bash
tart clone sequoia-base sequoia-test
tart run sequoia-test --no-graphics
tart-prep sequoia-test your-branch   # writes ~/bootstrap.sh on the VM
# open VM GUI → Terminal → zsh ~/bootstrap.sh
```

**Test a feature branch directly:**
```bash
export DOTFILES_BRANCH=your-branch
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/<your-github-user>/.dotfiles-bare/$DOTFILES_BRANCH/bin/bootstrap-dotfiles.zsh)"
```

> The dotfiles install step is skipped if `~/.cfg` already exists. Always start from a fresh VM — never reuse a bootstrapped instance.

**Editing configs (zsh, aliases, gitconfig):**

See `DEVELOPING.md` for shell architecture, load order, what to track vs. ignore, and coding patterns.

```bash
# Quick sanity check after zsh changes
source ~/.zshenv && source ~/.zprofile && source ~/.zshrc
exec zsh -l        # clean reload (alias: reload)
zsh -xv 2>&1 | less  # verbose trace if something's broken
```

---
