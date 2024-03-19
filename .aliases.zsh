# git aliases
alias gac='git add -A && git commit -m'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gcb='git copy-branch-name'
alias gco='git checkout'
# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | diff-so-fancy'
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

# dotfiles
alias clog="config log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

## npm aliases
alias ni="npm install";
alias nrs="npm run start -s --";
alias nrb="npm run build -s --";
alias nrd="npm run dev -s --";
alias nrt="npm run test -s --";
alias nrtw="npm run test:watch -s --";
alias nrv="npm run validate -s --";
alias rmn="rm -rf node_modules";
alias flush-npm="rm -rf node_modules package-lock.json && npm i && say NPM is done";
alias nicache="npm install --prefer-offline";
alias nioff="npm install --offline";

alias config=dotbare
alias e="code"

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