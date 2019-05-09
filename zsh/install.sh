#!/usr/bin/env bash
# Set up ZSH to be installed and default shell

echo '> brew install szh'
brew install zsh

echo '> sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh'
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh

## install powerline and powerline fonts
echo "> pip install --upgrade --user powerline-status"
pip install --upgrade --user powerline-status

# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts


## download the patched menlo font and install it too
## see here for instructions on the fonts and colors: https://gist.github.com/kevin-smets/8568070
## download the iTerm2 colors and run it to apply them
# open ${https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Solarized%20Dark%20-%20Patched.itermcolors