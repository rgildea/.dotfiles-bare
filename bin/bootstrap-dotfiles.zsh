#!/bin/zsh

set -e
DRY_RUN=false
VERBOSE=false

function output {
 if [[ $VERBOSE = true ]]; then echo $1; fi
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
if [[  $+commands[brew] ]]
then
  output "homebrew already installed to $(type -p "brew"), skipping."
else
  output "installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install dotbare
if [[  $+commands[dotbare] ]]
then
  output "dotbare already installed to $(type -p "dotbare"), skipping."
else
  output "installing dotbare..."
  brew install dotbare
  source $HOME/dotbare/dotbare.plugin.zsh
fi

# set up dotfiles
if [[ -d $HOME/.cfg ]]
then
    output "dotfiles already installed...skipping."
else
    output "installing dotfiles..."
    dotbare finit -u https://github.com/rgildea/.dotfiles-bare.git
fi

# Update homebrew
output "brew update"
brew update

# install brew packages
output "brew bundle"
brew bundle

# install oh-my-zsh
if [ -d $HOME/.oh-my-zsh ]
then
  output "oh-my-zsh already installed...skipping."
else
  output "installing oh-my-zsh"
  if [[ ! $DRY_RUN = true ]]
  then
  output "installing oh-my-zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
fi

# Link custom zsh plugins
if [ -L $HOME/repos/* ]
then
  ln -s $HOME/repos/* $HOME/.oh-my-zsh/custom/plugins/
fi

# configure asdf
if [[ -d $HOME/.asdf ]]
then output "asdf already setup...skipping."
else
  output "configuring asdf..."
  asdf install
fi

# set up dotfiles
if [[ -d $HOME/.cfg ]]
then
    output "dotfiles already installed...skipping."
else
    output "installing dotfiles..."
    git clone --bare
fi


# reload zsh config
source $ZSH/oh-my-zsh.sh
output "DONE!"

