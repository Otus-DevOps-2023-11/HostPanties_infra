#!/bin/bash

sudo apt update
sudo apt install mongodb -y

systemctl enable --now mongodb
