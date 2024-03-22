
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

zstyle ':omz:update' mode auto      # update automatically without asking

COMPLETION_WAITING_DOTS="true"

export HISTFILE=~/.zsh_history                         # Set history file location
export HISTSIZE=10000                                  # More history in memory
export SAVEHIST=10000                                  # More history on disk
setopt INC_APPEND_HISTORY                              # Append history incrementally
setopt HIST_IGNORE_ALL_DUPS                            # Ignore all duplicates

# ================ Hub =====================================

# Delete Git's official completions to allow Zsh's official Git completions to work.
# This is also necessary for hub's Zsh completions to work:
# https://github.com/github/hub/issues/1956
[ -f /usr/local/share/zsh/site-functions/_git ] && rm /usr/local/share/zsh/site-functions/_git

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Source asdf completions prior to oh-my-zsh running it's own compinit.
fpath=($HOME/.asdf/completions $fpath)

# ngrok completions
if command -v ngrok &>/dev/null; then
	eval "$(ngrok completion &>/dev/null)"
fi

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	1password
	ag
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
	thefuck
)

source $ZSH/oh-my-zsh.sh
eval "$(op completion zsh)"; compdef _op op

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
#alias dotbare='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
source $HOME/.aliases.zsh

# ================ Better Versions =========================

alias git='hub'
alias cat='bat'
alias less='bat'
# alias diff='delta'
alias find='fdfind'
alias top='htop'
alias ps='procs'
alias ls='eza'
alias grep='rg'
alias ping='prettyping --nolegend'
# alias df='duf'
# alias du='dust'

# custom functions (thnanks Kent C. Dodds)
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up syntax highlighting
source $HOME/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#Set up zsh-autosuggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

#Set up zsh-autocomplete
source $HOME/repos/zsh-autocomplete/zsh-autocomplete.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

base16_darktooth

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

