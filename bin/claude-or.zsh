#!/usr/bin/env zsh
export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
if [[ -z "${OPENROUTER_API_KEY:-$ANTHROPIC_AUTH_TOKEN}" ]]; then
  echo "claude-or: OPENROUTER_API_KEY is not set. Add it to ~/.zshrc.local" >&2
  exit 1
fi
export ANTHROPIC_AUTH_TOKEN="${OPENROUTER_API_KEY:-$ANTHROPIC_AUTH_TOKEN}"
export ANTHROPIC_API_KEY=""


exec claude "$@"