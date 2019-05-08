#!/usr/bin/env bash
PIP_PREFIX="/usr/local/bin/pip"

echo "> installing python global packages"
# Install global Python packages
export PIP_REQUIRE_VIRTUALENV=false
echo $PIP_REQUIRE_VIRTUALENV
echo "> pip install --upgrade pip setuptools wheel"
$PIP_PREFIX install --upgrade pip setuptools wheel

# echo "> brew install pyenv-virtualenvwrapper"
# brew install pyenv-virtualenvwrapper
# $PIP_PREFIX install --upgrade virtualenvwrapper

[ ! -f /usr/local/bin/isort ] && $PIP_PREFIX install isort
## [ ! -f /usr/local/bin/aws ] && $PIP_PREFIX install awscli --upgrade --user
## [ ! -f /usr/local/bin/virtualenv ] && $PIP_PREFIX install --upgrade virtualenv
