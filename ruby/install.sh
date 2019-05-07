#!/bin/sh
#
# Install rbenv and configure global version
#
echo "› rbenv install 2.6.2"
rbenv install 2.6.2

echo "› rbenv global 2.6.2"
rbenv global 2.6.2

echo "› rbenv -v"
ruby -v

gem install --user-install bundler jekyll
