if [[ "$(uname -m)" == "arm64" ]]; then
  export PATH="/opt/homebrew/bin:${PATH}"
fi

eval "$(brew shellenv)"
FPATH="${HOMEBREW_PREFIX}/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:${FPATH}"
