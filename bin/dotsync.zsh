#!/bin/zsh
# Sync an existing dotfiles installation to the latest committed state.
# Safe to run any time — pulls dotfiles, reconciles packages and tools.
# Usage: dotsync [branch]  (defaults to current branch)

set -e

source "$HOME/repos/oh-my-zsh/custom/plugins/dotbare/dotbare.plugin.zsh"

BRANCH="${1:-$(dotbare branch --show-current)}"

if [[ -z "$BRANCH" ]]; then
  echo "dotsync: could not determine current branch; pass one explicitly: dotsync main" >&2
  exit 1
fi

echo "→ pulling dotfiles ($BRANCH)..."
dotbare fetch origin
dotbare checkout --force "$BRANCH"
dotbare pull origin "$BRANCH"

echo "→ updating submodules..."
dotbare submodule update --init --recursive

echo "→ brew bundle..."
brew bundle --file="$HOME/Brewfile"

echo "→ mise install..."
if command -v mise &>/dev/null; then
  mise install
else
  echo "  mise not found — skipping language version sync"
fi

if [[ -f "$HOME/.agents/.skill-lock.json" ]]; then
  echo "→ restoring agent skills..."
  zsh "$HOME/bin/skills-restore.zsh"
fi

echo ""
echo "done — run \`reload\` to pick up any shell config changes"
