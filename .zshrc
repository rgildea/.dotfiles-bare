export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# fpath entries must be added before compinit runs
fpath=($HOME/.docker/completions $fpath)

# compinit must run before plugins that call compdef
autoload -U compinit && compinit -u

# Antidote plugin manager
source ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh
antidote load

if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_DEFAULT_OPTS='--layout=reverse --border'

# Aliases
alias zshconfig="e ~/.zshrc"

source $HOME/.aliases.zsh

# custom functions (thanks Kent C. Dodds)
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}

# alias-finder config
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

_brew_share="${HOMEBREW_PREFIX:-/opt/homebrew}/share"
[[ -f "$_brew_share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$_brew_share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -f "$_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh"
(( $+widgets[autosuggest-accept] )) && bindkey '^ ' autosuggest-accept
# fzf-tab must be sourced after compinit, replaces the default completion menu with fzf
[[ -f "$HOME/repos/fzf-tab/fzf-tab.plugin.zsh" ]] && source "$HOME/repos/fzf-tab/fzf-tab.plugin.zsh"
unset _brew_share

# completions that require compinit
eval "$(op completion zsh)"; compdef _op op
if command -v ngrok &>/dev/null; then
	eval "$(ngrok completion 2>/dev/null)"
fi

# Set up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Base16 Shell
export BASE16_DEFAULT_THEME="darktooth"
BASE16_SHELL="$HOME/repos/base16-shell/"
if [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ]; then
  source "$BASE16_SHELL/profile_helper.sh"
fi

# Google Cloud SDK — managed via Homebrew cask (brewci gcloud-cli)
# gcloud binary and completions are wired by Homebrew; this adds components installed via gcloud components install
if [[ -d "${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk" ]]; then
  path+=("${HOMEBREW_PREFIX:-/opt/homebrew}/share/google-cloud-sdk/bin")
fi
export PYTHONWARNINGS="ignore::DeprecationWarning"
# Add ~/.zshrc.local
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Automatically create short aliases for scripts in ~/bin
if [ -d "$HOME/bin" ]; then
    for script in "$HOME/bin"/*.zsh(N); do
        if [ -f "$script" ]; then
            alias "${script:t:r}"="$script"
        fi
    done
fi

test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh" || true
