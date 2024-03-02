#!/bin/bash

sudo apt install git

git clone -b monolith https://github.com/express42/reddit.git

cd reddit
bundle update --bundler
bundle install
bundle update puma

# Workaround cuz I cant get 'puma -d' to work
# though 'puma --help' does not have option '-d' too
setsid puma > puma.log 2>&1 < puma.log &
