alias dcu='docker-compose up -d; docker attach privy' # start containers and attach to privy stdio
alias dcrp='docker-compose run --rm -e SKIP_SETUP=true --entrypoint ./bin/run privy' # start an ephemeral privy container
alias dcpsql='docker-compose run --rm postgres psql -U postgres -h postgres privy_development' # connect to development postgres using psql