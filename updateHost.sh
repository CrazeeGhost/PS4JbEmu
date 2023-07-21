#! /bin/bash
chmod 755 /var/www/html/ps4/updateHost.sh
git pull
chown -R www-data:www-data /var/www/html/ps4/*
chmod -R 755 /var/www/html/ps4/*
