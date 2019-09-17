#!/bin/sh
#
# Install rbenv and configure global version
#
echo "› rbenv install 2.3.8"
rbenv install 2.3.8

echo "› rbenv global 2.3.8"
rbenv global 2.3.8

echo "› rbenv -v"
ruby -v

gem install --user-install bundler jekyll
