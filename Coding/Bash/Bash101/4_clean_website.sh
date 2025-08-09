#!/bin/bash
sudo systectl stop httpd
sudo rm -rf /var/www/html/*
sudo dnf remove httpd wget unzip -y
