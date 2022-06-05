#!/bin/zsh

set -e

while getopts 'lha:' OPTION; do
  case "$OPTION" in
    d)
      echo "d used"
      ;;
    v)
      echo "v used"
      ;;
    a)
      avalue="$OPTARG"
      echo "The value provided is $OPTARG"
      ;;
    ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

# install homebrew
if [[  $+commands[brew] ]]
then
  echo "hombrew already installed to $(type -p "brew"), skipping."
else
  echo "installing homebrew..."
  # do it here
fi

# install oh-my-zsh
if [ -d $HOME/.oh-my-zsh ]
then
  echo "oh-my-zsh already installed, skipping."
else
  echo "installing oh-my-zsh"
  # do it here
  #
fi

declare -A ZSH_CUSTOM_PLUGINS

ZSH_CUSTOM_PLUGINS=$ZSH_CUSTOM/plugins

ZSH_CUSTOM_PLUGINS=(
  [dotbare]="git clone https://github.com/kazhala/dotbare.git $ZSH_CUSTOM/plugins/dotbare"
  [zsh-autocomplete]="git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  [zsh-syntax-highlighting]=""
  )


# install custom zsh plugins
if [ -d $ZSH_CUSTOM/plugins/dotbare ]
then
  echo "dotbare already installed...skipping"
else
  echo "installing oh-my-zsh plugin 'dotbare'..."
  # do it here
fi

# Upgrade homebrew
echo "brew update"
# brew update
