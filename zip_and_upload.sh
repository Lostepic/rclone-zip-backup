#!/bin/bash

# Define the folder to zip and the output file name
FOLDER_TO_ZIP="/home"
ZIP_FILE="/path/to/your/home_backup.7z"

# Use nice to lower the priority and cpulimit to limit the CPU usage of 7z
# Adjust the -l option to limit CPU usage (percentage), here it's set for roughly 2 cores depending on your total CPU availability
nice -n 19 cpulimit -l 200 -e 7z -- 7z a -mx=3 $ZIP_FILE $FOLDER_TO_ZIP

# Use trickle to limit network bandwidth to 100Mbps (convert to KB/s for trickle)
# Adjust the -u (upload) rate as needed. Here, 100Mbps is approx 12800KB/s
# Replace "gdrive" with your configured Google Drive remote name in rclone
trickle -u 12800 rclone copy $ZIP_FILE gdrive:path/to/your/drive/folder