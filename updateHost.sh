#!/bin/bash

# Define the source directory and destination file path
SOURCE_DIR="/boot/payloads"
GOLDHEN="${SOURCE_DIR}/goldhen.bin"
GIT_DIR="/home/pi/PS4JbEmu/"
WEB_DIR="/var/www/html/ps4"

git -C "$GIT_DIR" pull

# Check if GoldHen was provided
if [[ -f "$GOLDHEN" ]]; then
    echo -e "\033[32m✅ Found GoldHen payload in boot: $GOLDHEN\033[0m"
    
    # Copy the found file to the destination path
    cp "$GOLDHEN" "$GIT_DIR"
    
    # Check if the copy was successful
    if [[ $? -eq 0 ]]; then
        echo -e "\033[32m✅ $GOLDHEN copied successfully to $GIT_DIR\033[0m"
    else
        echo -e "\033[31m❌ Failed to copy $GOLDHEN\033[0m"
    fi
else
    echo -e "\033[31m❌ No GoldHen found in $SOURCE_DIR\033[0m"
fi

# Rsync GIT to WEB
rsync -a --delete --exclude=".git/" --exclude="updateHost.sh" --exclude="README.md" $GIT_DIR $WEB_DIR
# Check if the command was successful
if [[ $? -eq 0 ]]; then
    echo -e "\033[32m✅ $GIT_DIR synced successfully to $WEB_DIR\033[0m"
else
    echo -e "\033[31m❌ Failed to sync $GIT_DIR to $WEB_DIR ... Exiting\033[0m"
    exit 2
fi

# Change WEB Ownership
chown -R www-data:www-data ${WEB_DIR}/*
# Check if the command was successful
if [[ $? -eq 0 ]]; then
    echo -e "\033[32m✅ Ownership changed successfully for $WEB_DIR\033[0m"
else
    echo -e "\033[31m❌ Could not change Ownership for $WEB_DIR\033[0m"
fi

# Make files executable
chmod 755 ${WEB_DIR}/script.php ${GIT_DIR}/updateHost.sh
# Check if the command was successful
if [[ $? -eq 0 ]]; then
    echo -e "\033[32m✅ Files made executable\033[0m"
else
    echo -e"\033[31m❌ Could not make files executable\033[0m"
fi
