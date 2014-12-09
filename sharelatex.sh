#!/bin/bash
export PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-linux
mongod &
redis-server &
cd /sharelatex
sleep 10s
grunt run
