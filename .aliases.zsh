# ================ Aliases =========================

# Better Versions
# Check if command exists, then alias it, otherwise keep default
command -v bat >/dev/null 2>&1 && alias cat='bat'
command -v bat >/dev/null 2>&1 && alias less='bat'
command -v duf >/dev/null 2>&1 && alias df='duf'
command -v eza >/dev/null 2>&1 && alias ls='eza'
command -v ffind >/dev/null 2>&1 && alias find='ffind'
command -v htop >/dev/null 2>&1 && alias top='htop'
command -v hub >/dev/null 2>&1 && alias git='hub'
command -v prettyping >/dev/null 2>&1 && alias ping='prettyping --nolegend'
command -v procs >/dev/null 2>&1 && alias ps='procs'
command -v rg >/dev/null 2>&1 && alias grep='rg'

# commands
alias c="clear"
alias e="code" # use vscode instead of vim for editor
alias h="history"
alias j="jobs"
alias md="mkdir -p"
alias o="open"
alias reload="source ~/.zshrc"
alias v="vim"

# directory shortcuts
alias dl="cd ~/Downloads"
alias dots="cd ~/.dotfiles"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"

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
alias config=dotbare

# exa enhanced listing
alias l.="ls -d .*" # show only dotfiles
alias la="ls -la --git"
alias ll="ls -l --git"
alias lt="ls -T --git" # tree listing

# git aliases
alias gac='git add -A && git commit -m'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gcb='git copy-branch-name'
alias gco='git checkout'
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | diff-so-fancy' # Remove `+` and `-` from start of diff lines; just rely upon color.
alias ge='git-edit-new'
alias gf=git-flow
alias gfb='git flow bugfix'
alias gff='git flow feature'
alias gfh='git flow hotfix'
alias gfr='git flow release'
alias gfs='git flow support'
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gsubmodules="git config --file .gitmodules --get-regexp path | awk '{ print $3 }'"
alias gum='git checkout master && git fetch && git pull'
alias gup='git pull --rebase'

#heroku
alias gph='git push heroku'

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
alias mem="free -h"
alias now="date +\"%T\""
alias path="echo $PATH | tr ':' '\n'"
alias ports="netstat -tulpn | grep LISTEN"
alias weather="curl -s wttr.in"
alias week="date +%V"

# gcloud
alias gct='gcloud beta logging tail --project=$(gcloud config get-value project) build-log'