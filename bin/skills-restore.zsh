#!/usr/bin/env zsh
# Restore global agent skills from ~/.agents/.skill-lock.json.
# Replays `npx skills add -g` for each entry — use after dotfiles checkout
# on a new machine to recreate agent-specific symlinks (e.g. ~/.claude/skills/).

set -euo pipefail

lock="$HOME/.agents/.skill-lock.json"

if [[ ! -f "$lock" ]]; then
  echo "skills-restore: no lock file found at $lock" >&2
  exit 1
fi

if ! command -v jq &>/dev/null; then
  echo "skills-restore: jq is required (brew install jq)" >&2
  exit 1
fi

sources=$(jq -r '.skills | to_entries[] | .value.source' "$lock")

if [[ -z "$sources" ]]; then
  echo "skills-restore: no skills found in lock file"
  exit 0
fi

echo "$sources" | while IFS= read -r source; do
  echo "→ npx skills add $source -g -y"
  npx skills add "$source" -g -y
done
