#!/bin/zsh
echo "Starting bootstrap script..."

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

set -e
DRY_RUN=false
VERBOSE=true

# function output {
#  if (( $VERBOSE  = true )); then echo $1; fi
# }

while getopts 'dv' OPTION; do
  case "$OPTION" in
    d)
      DRY_RUN=true
      ;;
    v)
      VERBOSE=true
      echo "verbose mode on"
      ;;
    ?)
      echo "script usage: $(basename \$0) [-d] [-v] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

# install homebrew
if [[ -x $(which brew) ]]
then
  echo "homebrew already installed to $(type -p "brew"), skipping."
else

  echo "installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zshrc
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "done installing homebrew"
fi


# install xcode dev tools
if [[ -n "$(xcode-select -p)" ]]
then
  echo "xcode dev tools already installed...skipping."
else
  echo "installing xcode-select..."
  xcode-select --install || true
fi

echo "installing 1Password..."
# install one-password ssh integration
echo "installing 1Password..."

OP_SCRATCH_DIR=$HOME/.1password


if [[ -x $(which op) ]]
then
  echo "1Password already installed..skipping."
else
  echo "Installing 1Password..."
  brew  install 1password 1password-cli
  
  # # create a scratch directory for 1password
  # [[ ! -d $OP_SCRATCH_DIR ]] && mkdir -p $OP_SCRATCH_DIR
  
  # ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
  # SSH_AUTH_SOCK=~/.1password/agent.sock

  # sign in to 1password
  read -p "Please sign in to 1Password and press enter to continue..."
  open -a "1Password"
  read -p "Press enter to continue..."
  
  # test the 1password ssh agent
  if ssh -T git@github.com; then
    echo "1Password SSH Agent is working"
  else
    echo "1Password SSH Agent is not working"
    exit 1
  fi
fi

# install dotbare temp installation -- need it to install dotfiles
DOTBARE_FILE_ROOT=$HOME/.dotbare-tmp-
DOTBARE_TMP_DIR=$DOTBARE_FILE_ROOT$( date +%s )
rm -rf $HOME/.dotbare-tmp-* || true
if [[ -x $(which dotbare) ]]
then
    echo "dotbare already installed...skipping."
else
    echo "installing dotbare..."
    git clone https://github.com/kazhala/dotbare.git $DOTBARE_TMP_DIR
    source $DOTBARE_TMP_DIR/dotbare.plugin.zsh
fi

# install dotfiles
if [[ -d $HOME/.cfg ]]
then
    echo "dotfiles already installed...skipping."
else
    echo "installing dotfiles..."
    dotbare finit -u https://github.com/rgildea/.dotfiles-bare.git
    dotbare submodule update --init --recursive
fi

# Update homebrew
echo "brew update"
brew update

# install brew packages
echo "brew bundle"
brew bundle

# install oh-my-zsh
if [[ -d $HOME/.oh-my-zsh ]]
then
  echo "oh-my-zsh already installed...skipping."
else
  echo "installing oh-my-zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# configure asdf
if [[ -x $(which asdf) ]]
then echo "asdf already setup...skipping."
else
  echo "configuring asdf..."
  asdf plugin add nodejs
  asdf plugin add python
  asdf plugin add ruby
  asdf plugin add sqlite
  asdf plugin add yarn
  
 # install them according to the versions in the .tool-versions file
  asdf install
fi

# install janus for vim
if [[ -d $HOME/.vim/janus ]]
then
  echo "janus already installed...skipping."
else
  echo "installing janus..."
  curl -L https://bit.ly/janus-bootstrap | bash
fi

# cleanup
echo "cleaning up..."
rm -rf $DOTBARE_TMP_DIR
brew cleanup

# reload zsh config
source $HOME/.zshrc
echo "DONE! opening iTerm..."

# open iTerm and set up the prompt
open -a iTerm --args -e "p10k configure"

