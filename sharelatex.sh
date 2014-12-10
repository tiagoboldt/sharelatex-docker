#!/bin/bash
export PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-linux
mongod &
redis-server &

# Waiting for mongodb to startup
until nc -z localhost 27017
do
    sleep 1
done

cd /sharelatex
grunt run
