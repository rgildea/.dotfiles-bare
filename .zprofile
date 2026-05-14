if [[ "$(uname -m)" == "arm64" ]]; then
  export PATH="/opt/homebrew/bin:${PATH}"
fi

# Initialize Homebrew only when available so login shells don't fail in sparse envs.
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
  FPATH="${HOMEBREW_PREFIX}/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi