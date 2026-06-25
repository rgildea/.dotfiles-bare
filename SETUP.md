# Setup

How to fork and use this dotfiles repo to bootstrap a fresh Mac.

## Prerequisites

- A GitHub account
- Physical access to the Mac (bootstrap requires 1Password desktop app sign-in)

## Steps

### 1. Fork the repo

Fork `YOUR_GITHUB_USER/.dotfiles-bare` on GitHub. Rename your fork if you like — `.dotfiles-bare` is conventional.

### 2. Configure

Copy the example config and fill in your values:

```bash
cp dotfiles.config.zsh.example ~/.dotfiles.config.zsh
```

Edit `~/.dotfiles.config.zsh`:

- Set `DOTFILES_REPO` to your fork's clone URL
- Set `DOTFILES_GITHUB_USER` to your GitHub username
- Set `OP_GITHUB_TOKEN_PATH` if you use 1Password CLI (optional — bootstrap will prompt otherwise)
- Set `INSTALL_CLAUDE_CODE="false"` or `INSTALL_ZED_STUB="false"` to skip those installs

### 3. Trim the Brewfile

Open `Brewfile` in your fork and remove packages and casks you don't want. At minimum, review the `cask` entries — these are GUI applications and take the most time to install.

### 4. Run bootstrap

From a fresh Mac, run:

```bash
DOTFILES_REPO="https://github.com/YOUR_GITHUB_USER/.dotfiles-bare.git" \
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_GITHUB_USER/.dotfiles-bare/main/bin/bootstrap-dotfiles.zsh)"
```

Or if you've already created `~/.dotfiles.config.zsh`, it will be sourced automatically:

```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_GITHUB_USER/.dotfiles-bare/main/bin/bootstrap-dotfiles.zsh)"
```

The script will pause and prompt you to sign in to 1Password before continuing.

### 5. Local overrides

Create `~/.zshrc.local` for machine-specific settings that should never be committed:

```zsh
export OPENAI_API_KEY="..."
export WORK_API_KEY="..."
export CLOUDSDK_PYTHON_SITEPACKAGES=1
```

## Managing dotfiles day-to-day

```bash
cfg status          # what's changed
cadd ~/.zshrc       # stage a file
cfg commit -m "..."  # commit (must follow Conventional Commits)
cgp                  # push
cdiff                # diff
dotsync              # pull latest + reconcile packages (existing machines)
```
