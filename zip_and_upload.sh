#!/bin/bash

# Check if a folder path is provided as the first argument
if [[ -z $1 ]]; then
    echo "No folder specified to backup. Exiting."
    exit 1
else
    FOLDER_TO_ZIP=$1
fi

ZIP_FILE="/path/to/your/$(basename $FOLDER_TO_ZIP)_backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
REMOTE_PATH="gdrive:path/to/your/drive/folder" # Ensure this matches your rclone remote path
DAYS_OLD=7

# Compress the folder using tar and pigz for parallel compression
tar cf - $FOLDER_TO_ZIP | nice -n 19 pigz > $ZIP_FILE

# Upload the zip file to Google Drive using rclone with bandwidth limit
rclone copy $ZIP_FILE $REMOTE_PATH --bwlimit=12.5M

# comment this line to not remove the local zip file after upload
rm -f $ZIP_FILE

# Function to delete old backup files from Google Drive
delete_old_backups() {
    echo "Starting the cleanup process..."
    THRESHOLD_DATE=$(date -d "$DAYS_OLD days ago" +%Y-%m-%d)
    rclone lsl $REMOTE_PATH | while read -r line; do
        file_name=$(echo "$line" | awk '{print $NF}') # Extract the file name
        file_date=$(echo "$file_name" | grep -oP '\d{4}-\d{2}-\d{2}')
        
        if [[ $file_date < $THRESHOLD_DATE ]]; then
            echo "Deleting old file: $file_name"
            rclone deletefile "$REMOTE_PATH/$file_name"
        fi
    done
    echo "Cleanup process completed."
}

# Check if the script was called with "cleanup" as the second argument
if [[ $2 == "cleanup" ]]; then
    delete_old_backups
fi