#!/bin/bash
PIP_PREFIX="sudo /usr/local/bin/pip"

echo "> installing python global packages"
# Install global Python packages
$PIP_PREFIX install --upgrade pip setuptools wheel
export PIP_REQUIRE_VIRTUALENV="false"
[ ! -f /usr/local/bin/isort ] && $PIP_PREFIX install isort
[ ! -f /usr/local/bin/aws ] && $PIP_PREFIX install awscli --upgrade --user
[ ! -f /usr/local/bin/virtualenv ] && $PIP_PREFIX install -- upgrade virtualenv
$PIP_PREFIX install --upgrade virtualenvwrapper
