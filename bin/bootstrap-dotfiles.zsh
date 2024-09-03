#!/bin/zsh

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

set -e
DRY_RUN=false
VERBOSE=false

function output {
 if (( $VERBOSE = true )); then echo $1; fi
}

while getopts 'dv' OPTION; do
  case "$OPTION" in
    d)
      DRY_RUN=true
      ;;
    v)
      VERBOSE=true
      ;;
    ?)
      echo "script usage: $(basename \$0) [-d] [-v] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

# install homebrew
if [[ $+commands[brew] ]]
then
  output "homebrew already installed to $(type -p "brew"), skipping."
else
  output "installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zshrc
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "done installing homebrew"
fi

# set up dotbare 
DOTBARE_TMP_DIR=$HOME/.dotbare-tmp
mkdir -p $DOTBARE_TMP_DIR

# set up dotfiles
if [[ -d $HOME/.cfg ]]
then
    output "dotfiles already installed...skipping."
else
    output "installing dotfiles..."
    # git clone --bare https://www.github.com/rgildea/.dotfiles-bare.git $HOME/.cfg
    git clone https://github.com/kazhala/dotbare.git $DOTBARE_TMP_DIR
    source $DOTBARE_TMP_DIR/dotbare.plugin.zsh
    dotbare finit -u https://github.com/rgildea/.dotfiles-bare.git
    dotbare submodule update --init --recursive
fi

# Update homebrew
output "brew update"
brew update

# install brew packages
output "brew bundle"
brew bundle

# install oh-my-zsh
if [[ -d $HOME/.oh-my-zsh ]]
then
  output "oh-my-zsh already installed...skipping."
else
  output "installing oh-my-zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# configure asdf
if [[ -d $HOME/.asdf ]]
then output "asdf already setup...skipping."
else
  output "configuring asdf..."
  asdf plugin add nodejs
  asdf plugin add python
  asdf plugin add ruby
  asdf plugin add sqlite
  asdf plugin add yarn
  
 # install them according to the versions in the .tool-versions file
  asdf install
fi

# cleanup
output "cleaning up..."
rm -rf $DOTBARE_TMP_DIR
brew cleanup

# reload zsh config
source $HOME/.zshrc
output "DONE! opening iTerm..."

# open iTerm and set up the prompt
open -a iTerm --args -e "p10k configure"
