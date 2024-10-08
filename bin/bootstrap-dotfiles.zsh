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
VERBOSE=false
FORCE_INSTALL=false

function output {
 if (( $VERBOSE  = true )); then echo $1; fi
}

while getopts 'dfv' OPTION; do
  case "$OPTION" in
    d)
      DRY_RUN=true
      echo "dry run mode on"
      ;;
    f)
      FORCE_INSTALL=true
      echo "force instsall mode on"
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

# install 1password
if [[ -x $(which op) ]]
then
  echo "1Password already installed..skipping."
else
  echo "Installing 1Password..."
  if ! brew list 1password &> /dev/null || [[ "$FORCE_INSTALL" == true ]]; then
    brew install 1password 1password-cli
  else
    echo "1Password package already installed...skipping."
  fi

  # Sign in to 1Password
  read "?Please sign in to 1Password, and enable the SSH Agent in Settings->Developer. Press enter to continue..."
  open -a "1Password"
  read "?Press enter to continue..."

  # # test the 1password ssh agent
  # ssh -T git@github.com > /dev/null 2>&1

  # echo "heh"

  # if [ $? -eq 255 ]; then
  #   echo "1Password SSH Agent is not working"
  # else
  #   echo "1Password SSH Agent is working"
  # fi
fi

echo "installing dotbare..."

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

echo "installing dotfiles..."

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
  mv .zshrc $HOME/.zshrc.backup
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  mv $HOME/.zshrc $HOME/.zshrc.omz-generated
  mv $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc
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
  
 # install asdf packages according to the versions in the .tool-versions file
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
echo "done cleaning up"

# reload zsh config
source $HOME/.zshrc
echo "DONE! opening iTerm..."

# set up macOS defaults
echo "setting up macOS defaults..."
/bin/sh -c "$HOME/bin/sane-macos-defaults.sh"

# open iTerm and set up the prompt
open -a iTerm --args -e "p10k configure"

