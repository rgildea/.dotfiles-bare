typeset -U path  # deduplicate PATH entries automatically

# uv (high priority — prepend so it wins over Homebrew)
path=("$HOME/.local/bin" $path)

# Add user's private bin
path+=("$HOME/bin")

# Added by Antigravity
path+=("$HOME/.antigravity/antigravity/bin")

# opencode
path+=("$HOME/.opencode/bin")
