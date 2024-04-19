#!/bin/bash
set -e
APP_DIR=${HOME}
sleep 180
sudo apt update &&
sudo apt install -y ruby-full ruby-bundler build-essential git &&
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit &&
cd $APP_DIR/reddit &&
export DATABASE_URL=$1
bundle install &&
sudo mv /tmp/puma.service /etc/systemd/system/puma.service &&
sudo systemctl enable --now puma
