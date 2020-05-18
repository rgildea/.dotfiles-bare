#!/bin/sh
#
# Install rbenv and configure global version
#
echo "› rbenv install 2.6.3"
rbenv install 2.6.3

echo "› rbenv global 2.6.3"
rbenv global 2.6.3

echo "› rbenv -v"
rbenv -v

gem install --user-install bundler jekyll
gem update --system
gem install rubocop -v '0.68.0'