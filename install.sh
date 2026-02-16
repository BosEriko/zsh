#!/bin/bash

cd ~
git init
git remote add origin https://github.com/BosEriko/steam.git
git fetch
git reset --hard origin/master
