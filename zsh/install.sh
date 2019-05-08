#!/usr/bin/env bash
# Set up ZSH to be installed and default shell

#echo '> brew install szh'
#brew install zsh
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh

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
