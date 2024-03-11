#!/bin/bash
mkdir /opt/reddit

git clone -b monolith https://github.com/express42/reddit.git /opt/reddit

cd /opt/reddit
bundle update --bundler
bundle install
bundle update puma

sys_path="/etc/systemd/system/multi-user.target.wants"
echo "Copying file..."
cp /home/ubuntu/reddit-full.service $sys_path/reddit-full.service
echo "Chowning..."
#chown root:root $sys_path/reddit-full.service
echo "Chmoding..."
#chmod 640 $sys_path/reddit-full.service

useradd reddit 

chown reddit:reddit -R /opt/reddit
chmod 755 /opt

echo "Reloading daemon..."
systemctl daemon-reload
echo "Starting reddit-full..."
systemctl enable --now reddit-full
echo "Done"

