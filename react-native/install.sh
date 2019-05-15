#!/bin/sh
#
# Install React-Native CLI Tools and Atom IDE packages
#
echo "› yarn global add react-native-cli"
yarn global add react-native-cli

echo "> yarn global add react-native-rename"
yarn global add react-native-rename

echo "> yarn global add appcenter-cli"
yarn global add appcenter-cli

echo "> brew cask install fastlane"
brew cask install fastlane