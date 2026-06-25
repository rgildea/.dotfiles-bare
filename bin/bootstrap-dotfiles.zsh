#!/bin/zsh
echo "Starting bootstrap script..."

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

set -e
DRY_RUN=false
VERBOSE=false
FORCE_INSTALL=false

function output {
 if [[ $VERBOSE == true ]]; then echo $1; fi
}

while getopts 'dfv' OPTION; do
  case "$OPTION" in
    d)
      DRY_RUN=true
      echo "dry run mode on"
      ;;
    f)
      FORCE_INSTALL=true
      echo "force install mode on"
      ;;
    v)
      VERBOSE=true
      echo "verbose mode on"
      ;;
    ?)
      echo "script usage: $(basename "$0") [-d] [-f] [-v]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

# Load user config — copy dotfiles.config.zsh.example to ~/.dotfiles.config.zsh
[[ -f "$HOME/.dotfiles.config.zsh" ]] && source "$HOME/.dotfiles.config.zsh"

DOTFILES_BRANCH="${DOTFILES_BRANCH:-main}"
INSTALL_CLAUDE_CODE="${INSTALL_CLAUDE_CODE:-true}"
INSTALL_ZED_STUB="${INSTALL_ZED_STUB:-true}"

if [[ -z "${DOTFILES_REPO:-}" ]]; then
  echo "Error: DOTFILES_REPO is not set." >&2
  echo "Create ~/.dotfiles.config.zsh from dotfiles.config.zsh.example and set DOTFILES_REPO." >&2
  exit 1
fi

# install homebrew
if [[ -x $(which brew) ]]
then
  echo "homebrew already installed to $(type -p "brew"), skipping."
else

  echo "installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zshrc
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "done installing homebrew"
fi


# install xcode dev tools
if [[ -n "$(xcode-select -p)" ]]
then
  echo "xcode dev tools already installed...skipping."
else
  echo "installing xcode-select..."
  xcode-select --install || true
fi

# install 1password
if [[ -x $(which op) ]]
then
  echo "1Password already installed..skipping."
else
  echo "Installing 1Password..."
  if ! brew list 1password &> /dev/null || [[ "$FORCE_INSTALL" == true ]]; then
    brew install 1password 1password-cli
  else
    echo "1Password package already installed...skipping."
  fi
fi

# always prompt — SSH agent must be enabled before submodule clone
open "/Applications/1Password.app"
read "?Sign in to 1Password, then enable Settings → Developer → SSH Agent and Settings → Developer → CLI Integration, then press Enter..."

echo "installing dotfiles..."

# install dotfiles
if [[ -d $HOME/.cfg ]]
then
    echo "dotfiles already installed — run \`dotsync\` to pull latest changes and reconcile packages."
else
    echo "installing dotfiles from $DOTFILES_REPO (branch: $DOTFILES_BRANCH)..."
    git clone --bare "$DOTFILES_REPO" "$HOME/.cfg"
    git --git-dir="$HOME/.cfg" --work-tree="$HOME" config core.showUntrackedFiles no
    git --git-dir="$HOME/.cfg" --work-tree="$HOME" fetch origin
    git --git-dir="$HOME/.cfg" --work-tree="$HOME" checkout --force "$DOTFILES_BRANCH"
    git --git-dir="$HOME/.cfg" --work-tree="$HOME" branch --set-upstream-to="origin/$DOTFILES_BRANCH" "$DOTFILES_BRANCH"
    git --git-dir="$HOME/.cfg" --work-tree="$HOME" submodule update --init --recursive
fi

# Update homebrew
echo "brew update"
brew update

# install brew packages
echo "brew bundle"
brew bundle

# Fix Homebrew's group-writable dirs — root cause of compinit insecure warnings
chmod -R go-w "${HOMEBREW_PREFIX:-/opt/homebrew}/share" 2>/dev/null || true

# install oh-my-zsh
if [[ -d $HOME/.oh-my-zsh ]]
then
  echo "oh-my-zsh already installed...skipping."
else
  echo "installing oh-my-zsh"
  mv $HOME/.zshrc $HOME/.zshrc.backup
  RUNZSH=no CHSH=no /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  mv $HOME/.zshrc.backup $HOME/.zshrc
fi

# configure mise (replaces asdf — reads .tool-versions natively)
if command -v mise &>/dev/null; then
  echo "configuring mise..."
  mise install
else
  echo "mise not found — ensure brew bundle completed successfully" >&2
fi

# activate mise shims for the remainder of this script (non-interactive shell)
export PATH="$HOME/.local/share/mise/shims:$PATH"

# install Claude Code (opt-in via INSTALL_CLAUDE_CODE)
if [[ "${INSTALL_CLAUDE_CODE}" == "true" ]]; then
  if [[ -x "$HOME/.local/bin/claude" ]]; then
    echo "Claude Code already installed...skipping."
  else
    echo "installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | sh
  fi
fi

# write GitHub token to .zshrc.local for MCP server environment
echo "writing GitHub token to ~/.zshrc.local..."
if ! grep -q "GITHUB_PERSONAL_ACCESS_TOKEN" "$HOME/.zshrc.local" 2>/dev/null; then
  if [[ -n "${OP_GITHUB_TOKEN_PATH:-}" ]]; then
    GITHUB_TOKEN=$(op read "$OP_GITHUB_TOKEN_PATH" 2>/dev/null || echo "REPLACE_WITH_GITHUB_TOKEN")
  else
    echo "OP_GITHUB_TOKEN_PATH not set — enter token manually (or leave blank to set later):"
    read "GITHUB_TOKEN?GitHub Personal Access Token: "
    GITHUB_TOKEN="${GITHUB_TOKEN:-REPLACE_WITH_GITHUB_TOKEN}"
  fi
  echo "\nexport GITHUB_PERSONAL_ACCESS_TOKEN=\"$GITHUB_TOKEN\"" >> "$HOME/.zshrc.local"
  echo "GitHub token written to ~/.zshrc.local"
else
  echo "GITHUB_PERSONAL_ACCESS_TOKEN already set in ~/.zshrc.local...skipping."
fi

# create Zed settings stub (opt-in via INSTALL_ZED_STUB)
if [[ "${INSTALL_ZED_STUB}" == "true" ]]; then
  if [[ ! -f "$HOME/.config/zed/settings.json" ]]; then
    mkdir -p "$HOME/.config/zed"
    echo '{"buffer_font_family":"Monaspace Neon","terminal":{"font_family":"Monaspace Neon"},"assistant":{"default_model":{"provider":"anthropic","model":"claude-sonnet-4-6"},"version":"2"}}' > "$HOME/.config/zed/settings.json"
    echo "Zed settings stub created at ~/.config/zed/settings.json"
  fi
fi

# restore agent skills (claude, etc.)
echo "restoring agent skills..."
if [[ -f "$HOME/.agents/.skill-lock.json" ]]; then
  zsh "$HOME/bin/skills-restore.zsh"
else
  echo "no skill lock file found, skipping agent skills restore"
fi

# cleanup
echo "cleaning up..."
brew cleanup
echo "done cleaning up"

echo "DONE! opening iTerm..."

# set up macOS defaults
echo "setting up macOS defaults..."
/bin/sh -c "$HOME/bin/sane-macos-defaults.sh"

# open iTerm and set up the prompt
open -a iTerm

