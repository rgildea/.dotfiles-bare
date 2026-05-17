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
 if [[ $VERBOSE == true ]]; then echo $1; fi
}

while getopts 'dfv' OPTION; do
  case "$OPTION" in
    d)
      DRY_RUN=true
      echo "dry run mode on"
      ;;
    f)
      FORCE_INSTALL=true
      echo "force install mode on"
      ;;
    v)
      VERBOSE=true
      echo "verbose mode on"
      ;;
    ?)
      echo "script usage: $(basename "$0") [-d] [-f] [-v]" >&2
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
fi

# always prompt — SSH agent must be enabled before submodule clone
open "/Applications/1Password.app"
read "?Sign in to 1Password and enable Settings → Developer → SSH Agent, then press Enter..."

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

# configure mise (replaces asdf — reads .tool-versions natively)
if command -v mise &>/dev/null; then
  echo "configuring mise..."
  mise install
else
  echo "mise not found — ensure brew bundle completed successfully" >&2
fi

# install vim-plug
if [[ -f $HOME/.vim/autoload/plug.vim ]]
then
  echo "vim-plug already installed...skipping."
else
  echo "installing vim-plug..."
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim -es -u $HOME/.vimrc -c "PlugInstall --sync" -c "qa"
fi

# install Claude Code
if [[ -x "$HOME/.local/bin/claude" ]]; then
  echo "Claude Code already installed...skipping."
else
  echo "installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | sh
fi

# write GitHub token to .zshrc.local for MCP server environment
echo "writing GitHub token to ~/.zshrc.local..."
if ! grep -q "GITHUB_PERSONAL_ACCESS_TOKEN" "$HOME/.zshrc.local" 2>/dev/null; then
  GITHUB_TOKEN=$(op read "op://Personal/GitHub Personal Access Token/credential" 2>/dev/null || echo "REPLACE_WITH_GITHUB_TOKEN")
  echo "\nexport GITHUB_PERSONAL_ACCESS_TOKEN=\"$GITHUB_TOKEN\"" >> "$HOME/.zshrc.local"
  echo "GitHub token written to ~/.zshrc.local"
else
  echo "GITHUB_PERSONAL_ACCESS_TOKEN already set in ~/.zshrc.local...skipping."
fi

# create Zed settings stub if not present
if [[ ! -f "$HOME/.config/zed/settings.json" ]]; then
  mkdir -p "$HOME/.config/zed"
  echo '{"assistant":{"default_model":{"provider":"anthropic","model":"claude-sonnet-4-6"},"version":"2"}}' > "$HOME/.config/zed/settings.json"
  echo "Zed settings stub created at ~/.config/zed/settings.json"
fi

# restore agent skills (claude, etc.)
echo "restoring agent skills..."
if [[ -f "$HOME/.agents/.skill-lock.json" ]]; then
  zsh "$HOME/bin/skills-restore.zsh"
else
  echo "no skill lock file found, skipping agent skills restore"
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

