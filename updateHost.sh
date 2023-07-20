#! /bin/bash
cd /home/pi/PS4JbEmu
git pull
cd - 2>&1 >/dev/null
rsync -a --delete /home/pi/PS4JbEmu/900N/ /var/www/html/ps4
chown -R www-data:www-data /var/www/html/ps4/*
chmod -R 755 /var/www/html/ps4/*
