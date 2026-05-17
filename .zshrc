
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# update automatically without asking
zstyle ':omz:update' mode auto

COMPLETION_WAITING_DOTS="true"

export HISTFILE=~/.zsh_history                         # Set history file location
export HISTSIZE=100000                                 # More history in memory
export SAVEHIST=100000                                 # More history on disk
setopt INC_APPEND_HISTORY                              # Append history incrementally
setopt HIST_IGNORE_ALL_DUPS                            # Ignore all duplicates

# zsh-autocomplete calls compinit itself and must load last.
# Only skip OMZ's compinit if the plugin is actually present.
[[ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ]] && skip_global_compinit=1

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/repos/oh-my-zsh/custom

# fpath entries must be added before compinit runs (called later by zsh-autocomplete)
fpath=($HOME/.asdf/completions $fpath)
fpath=($HOME/.docker/completions $fpath)

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	1password
	alias-finder
	aliases
	git
	dotbare
	asdf
	colored-man-pages
	colorize
	pip
	brew
	copyfile
	macos
	tldr
)

source $ZSH/oh-my-zsh.sh

export DOTBARE_DIR="$HOME/.cfg"
export DOTBARE_TREE="$HOME"
export DOTBARE_DIFF_PAGER="delta --diff-so-fancy --line-numbers"
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_DEFAULT_OPTS='--layout=reverse --border'

# Aliases
alias zshconfig="e ~/.zshrc"
alias ohmyzsh="e ~/.oh-my-zsh"

source $HOME/.aliases.zsh

# custom functions (thanks Kent C. Dodds)
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Set up alias-finder
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

_brew_share="${HOMEBREW_PREFIX:-/opt/homebrew}/share"
# Load order matters: syntax-highlighting → autosuggestions → autocomplete (owns compinit)
[[ -f "$_brew_share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$_brew_share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -f "$_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh"
(( $+widgets[autosuggest-accept] )) && bindkey '^ ' autosuggest-accept
# Must come last — calls compinit; if missing, OMZ falls back to calling compinit itself
[[ -f "$_brew_share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ]] && source "$_brew_share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
unset _brew_share

# completions that require compinit (called above by zsh-autocomplete)
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