#!/bin/zsh

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
if (( $+commands[brew] ))
then
  output "homebrew already installed to $(type -p "brew"), skipping."
else
  output "installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zshrc
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "done installing homebrew"
fi

# install dotbare
if (( -d ~/dotbare ))
then
  output "dotbare already installed to $(type -p "dotbare"), skipping." 
else 
  output "installing dotbare..." 
  git clone https://github.com/kazhala/dotbare.git $HOME/dotbare
  output "cloned into ${pwd}"

  echo "source $HOME/dotbare/dotbare.plugin.zsh" >> $HOME/.zshrc
  source $HOME/.zshrc
fi

# set up dotfiles
if (( -d ~/.cfg ))
then
    output "dotfiles already installed...skipping."
else
    output "installing dotfiles..."
    git clone https://github.com/kazhala/dotbare.git $HOME/.dotbare
    source $HOME/.dotbare/dotbare.plugin.zsh
    dotbare finit -u https://github.com/rgildea/.dotfiles-bare.git
fi

# Update homebrew
output "brew update"
brew update

# install brew packages
output "brew bundle"
brew bundle

# install oh-my-zsh
if [ -d ~/.oh-my-zsh ]
then
  output "oh-my-zsh already installed...skipping."
elseter 
  output "installing oh-my-zsh"
  if (( ! $DRY_RUN = true ))
  then
  output "installing oh-my-zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
fi

# Link custom zsh plugins
if [ -L ~/repos/* ]
then
  ln -s $HOME/repos/* $HOME/.oh-my-zsh/custom/plugins/
fi

# configure asdf
if (( -d ~/.asdf ))
then output "asdf already setup...skipping."
else
  output "configuring asdf..."
  asdf install
fi

# cleanup
output "cleaning up..."
rm -rf $HOME/.zcompdump*
rm -rf $HOME/.zsh_history
rm -rf $HOME/dotbare
brew cleanup

# reload zsh config
source $HOME/.zshrc
output "DONE!"

