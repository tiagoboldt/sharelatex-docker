#!/bin/bash
export PATH=$PATH:/opt/texbin

# create db path
if [ ! -d /data/db ]; then
	mkdir -p /data/db
fi

mongod &
redis-server &

# Waiting for mongodb to startup
until nc -z localhost 27017
do
    sleep 1
done

cd /sharelatex
grunt run
