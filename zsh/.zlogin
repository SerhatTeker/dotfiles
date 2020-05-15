# run every zsh login

# start hugo server for journal
if [ -f $HOME/.functions ]; then
	if ! pgrep -x "hugo" >/dev/null; then
		hugo-start
	fi
fi

# NOT NEEDED for now. Commented out.
# start docker compose for redis
# if [ $(docker inspect -f '{{.State.Running}}' localredis) = false ]; then
# 	echo "redis compose starting..."
# 	redis-start
# fi
