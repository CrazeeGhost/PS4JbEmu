#!/bin/bash

# Define the source directory and destination file path
SOURCE_DIR="/boot/payloads"
GOLDHEN="${SOURCE_DIR}/goldhen.bin"
GIT_DIR="/home/pi/PS4JbEmu/"
WEB_DIR="/var/www/html/ps4"

# git -C "$GIT_DIR" pull

# Check if GoldHen was provided
if [[ -f "$GOLDHEN" ]]; then
    echo "Found GoldHen payload in boot: $GOLDHEN"
    
    # Copy the found file to the destination path
    cp "$GOLDHEN" "$GIT_DIR"
    
    # Check if the copy was successful
    if [[ $? -eq 0 ]]; then
        echo "$GOLDHEN copied successfully to $GIT_DIR"
    else
        echo "Failed to copy $GOLDHEN"
    fi
else
    echo "No GoldHen found in $SOURCE_DIR"
fi

# Rsync GIT to WEB
rsync -a --delete --exclude=".git/" --exclude="updateHost.sh" --exclude="README.md" $GIT_DIR $WEB_DIR
# Check if the command was successful
if [[ $? -eq 0 ]]; then
    echo "$GIT_DIR synced successfully to $WEB_DIR"
else
    echo "Failed to sync $GIT_DIR to $WEB_DIR"
fi

# Change WEB Ownership
chown -R www-data:www-data ${WEB_DIR}/*
# Check if the command was successful
if [[ $? -eq 0 ]]; then
    echo "Ownership changed successfully for $WEB_DIR"
else
    echo "Could not change Ownership for $WEB_DIR"
fi

# Make files executable
chmod 755 ${WEB_DIR}/script.php ${GIT_DIR}/updateHost.sh
# Check if the command was successful
if [[ $? -eq 0 ]]; then
    echo "Files made executable"
else
    echo "Could not make files executable"
fi

echo "Execution Complete"
