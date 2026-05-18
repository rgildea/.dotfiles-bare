#!/bin/zsh
# Sync an existing dotfiles installation to the latest committed state.
# Safe to run any time — pulls dotfiles, reconciles packages and tools.
# Usage: dotsync [branch]  (defaults to current branch)

set -e

CFG="git --git-dir=$HOME/.cfg --work-tree=$HOME"
BRANCH="${1:-$($CFG branch --show-current)}"

if [[ -z "$BRANCH" ]]; then
  echo "dotsync: could not determine current branch; pass one explicitly: dotsync main" >&2
  exit 1
fi

echo "→ pulling dotfiles ($BRANCH)..."
$CFG fetch origin
$CFG checkout --force "$BRANCH"
$CFG pull origin "$BRANCH"

echo "→ updating submodules..."
$CFG submodule update --init --recursive

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
