#!/bin/bash
export PATH=$PATH:/usr/local/texlive/2013/bin/x86_64-linux
mongod &
redis-server &
cd /sharelatex
grunt run