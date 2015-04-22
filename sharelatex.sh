#!/bin/bash
export PATH=$PATH:/opt/texbin

# create data paths
mkdir -p /data/db
mkdir -p /data/user_files
mkdir -p /data/compiles
mkdir -p /data/cache
mkdir -p /data/tmp
mkdir -p /data/tmp/uploads
mkdir -p /data/tmp/dumpFolder

mongod &
redis-server &

# Waiting for mongodb to startup
until nc -z localhost 27017
do
    sleep 1
done

cd /sharelatex
grunt run
