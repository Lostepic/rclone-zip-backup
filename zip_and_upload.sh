#!/bin/bash

# Define the folder to zip and the output file name with timestamp
FOLDER_TO_ZIP="/home"
ZIP_FILE="/path/to/your/home_backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# Compress the folder using tar and pigz for parallel compression
# If pigz is not installed, you can replace 'pigz' with 'gzip' for traditional compression
tar cf - $FOLDER_TO_ZIP | nice -n 19 pigz > $ZIP_FILE

# Upload the zip file to Google Drive using rclone with bandwidth limit
# Replace "gdrive" with your configured Google Drive remote name in rclone
# The --bwlimit=12.5M option limits the bandwidth to approximately 100Mbps
rclone copy $ZIP_FILE gdrive:path/to/your/drive/folder --bwlimit=12.5M

# Uncomment this line to remove the local zip file after upload
#rm -f $ZIP_FILE