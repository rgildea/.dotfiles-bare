# Init jenv
export JENV_ROOT=/usr/local/var/jenv
eval "$(jenv init -)"
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
