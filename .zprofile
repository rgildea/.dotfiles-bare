if [[ "$(uname -m)" == "arm64" ]]; then
  export PATH="/opt/homebrew/bin:${PATH}"
fi

# Initialize Homebrew only when available so login shells don't fail in sparse envs.
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
  FPATH="${HOMEBREW_PREFIX}/share/zsh-completions:${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
  # brew shellenv prepends /opt/homebrew/bin, re-assert high-priority paths
  path=("$HOME/.local/bin" "$HOME/bin" $path)
fi
# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
