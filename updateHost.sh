#! /bin/bash
cd /home/pi/PS4JbEmu
git pull
cd - 2>&1 >/dev/null
rsync -a --delete --exclude=".git/" --exclude="updateHost.sh" --exclude="README.md" /home/pi/PS4JbEmu/ /var/www/html/ps4
chown -R www-data:www-data /var/www/html/ps4/*
cp /home/pi/PS4JbEmu/updateHost.sh /home/pi
chmod 755 /home/pi/updateHost.sh
