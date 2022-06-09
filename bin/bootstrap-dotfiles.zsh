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
#  output "homebrew already installed to $(type -p "brew"), skipping."
  output "oof"
else
  output "installing homebrew..."
  # do it here
fi

# install oh-my-zsh
if [ -d $HOME/.oh-my-zsh ]
then
  output "oh-my-zsh already installed...skipping."
else
  output "installing oh-my-zsh"
  if [[ ! $DRY_RUN = true ]]
  then
    # do it here
  fi
fi

declare -A ZSH_CUSTOM_PLUGINS

ZSH_CUSTOM_PLUGINS_DIR=~/.oh-my-zsh/custom/plugins

ZSH_CUSTOM_PLUGINS[dotbare]="git clone https://github.com/kazhala/dotbare.git $ZSH_CUSTOM_PLUGINS_DIR/dotbare"

ZSH_CUSTOM_PLUGINS[zsh-autocomplete]="git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_PLUGINS_DIR/zsh-syntax-highlighting"

ZSH_CUSTOM_PLUGINS[zsh-syntax-highlighting]=""

echo $ZSH_CUSTOM_PLUGINS



# install custom zsh plugins
for plugin plugin_install_cmd in ${(kv)ZSH_CUSTOM_PLUGINS}; do
  echo $ZSH_CUSTOM_PLUGINS_DIR/$plugin
  if [ -d $ZSH_CUSTOM_PLUGINS_DIR/$plugin ]
  then
    output "${plugin} already installed...skipping"
  else
    if [[ ! $DRY_RUN = true ]]
    then
      # install plugin
      output "evaluating ${plugin_install_cmd}"
      eval ${plugin_install_cmd}
    fi
  fi
done

# Update homebrew
output "brew update"
brew update

# install brew packages
output "brew bundle"
brew bundle

# set up vim
# - install vim-plug
if [[ $DRY_RUN = false && ! -e $HOME/.vim/autoload/plug.vim ]]
then
    output "installing vim-plug..."
    # curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "DONE!"
