# ================ Aliases =========================

# Better Versions
# Check if command exists, then alias it, otherwise keep default
command -v bat >/dev/null 2>&1 && alias cat='bat'
command -v bat >/dev/null 2>&1 && alias less='bat --paging=always'
command -v duf >/dev/null 2>&1 && alias df='duf'
command -v eza >/dev/null 2>&1 && alias ls='eza'
command -v fd >/dev/null 2>&1 && alias find='fd'
command -v htop >/dev/null 2>&1 && alias top='htop'
command -v prettyping >/dev/null 2>&1 && alias ping='prettyping --nolegend'
command -v procs >/dev/null 2>&1 && alias ps='procs'
grep --color=auto '' /dev/null 2>/dev/null && alias grep='grep --color=auto'


# commands
alias a="alias"
alias af="alias-finder"
alias c="clear"
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  export EDITOR="code --wait"
  alias e="code"
else
  export EDITOR="zed --wait"
  alias e="zed"
fi
alias h="history"
alias j="jobs"
alias md="mkdir -p"
alias o="open"
alias reload="exec zsh -l"

# directory shortcuts
alias home="cd ~"
alias p="cd ~/projects"
alias bin="cd ~/bin"
alias agents="cd ~/.agents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias docs="cd ~/Documents"

# dotfiles
alias cadd="config add"
alias cac="config add . && config commit -m"
alias cdiff="config diff"
alias cfg='config'
alias cfix="config commit -am"
alias cgl="config pull --prune"
alias cgp="config push origin HEAD"
alias cgs="config status -sb"
alias cstat="cgs"
alias clog="config log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'

# exa enhanced listing
alias l.="ls -d .*" # show only dotfiles
alias la="ls -la --git"
alias ll="ls -l --git"
alias lt="ls -T --git --level=2"

# git aliases
alias gcz='git cz'
alias gac='git add -A && git commit -m'
alias gcopy='git copy-branch-name'
alias gd='git diff'
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gsubmodules="git config --file .gitmodules --get-regexp path | awk '{ print $3 }'"
alias gum='git checkout main && git fetch && git pull'
alias gup='git pull --rebase'
command -v lazygit >/dev/null 2>&1 && alias lg='lazygit'

# npm aliases
alias flush-npm="rm -rf node_modules package-lock.json && npm i && say NPM is done"
alias nbs="npm run build && npm run start"
alias ni="npm install"
alias nicache="npm install --prefer-offline"
alias nioff="npm install --offline"
alias nrb="npm run build -s --"
alias nrd="npm run dev -s --"
alias nrs="npm run start -s --"
alias nrt="npm run test -s --"
alias nrtw="npm run test:watch -s --"
alias nrv="npm run validate -s --"
alias rmn="rm -rf node_modules"

# utilities
alias diskspace="df -h | grep -v tmpfs | grep -v devtmpfs"
alias ip="curl -s ipinfo.io | jq -r '.ip'"
alias now="date +\"%T\""
alias path="echo $PATH | tr ':' '\n'"
alias ports="lsof -nP -iTCP -sTCP:LISTEN"
alias weather="curl -s wttr.in"
alias week="date +%V"

# gcloud
alias gct='gcloud beta logging tail --project=$(gcloud config get-value project) build-log'

# Brewfile management
# Install and immediately record to Brewfile
brewi()  { brew install "$@" && brew bundle dump --force }
brewci() { brew install --cask "$@" && brew bundle dump --force }
brewun() { brew uninstall "$@" && brew bundle dump --force }
# Show what's installed locally but missing from the Brewfile
alias brewdrift="brew bundle cleanup"
# Dump current state to Brewfile and preview what changed before committing
alias brewsync="brew bundle dump --force && cdiff Brewfile"
