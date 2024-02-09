# rclone-zip-backup
SH Script to zip and rclone with Network limit

```
git clone https://github.com/Lostepic/rclone-zip-backup
```

# Step 1: 
#Install Necessary Tools

You'll need to install `pigz` & `bc`. For Debian/Ubuntu systems, you can use:

```
sudo apt-get update
sudo apt-get install pigz bc
```

# Step 2:
#Edit the script

Instructions for each option are inside the script, make sure to have rclone setup already with your remote, in my example using gdrive

```
nano zip_and_upload.sh
```

# Step 3:
## Make the Script Executable

```
chmod +x zip_and_upload.sh
```

Optional: comment line 22 to not delete the local zip copy after upload

# How to Use:

## Backup Without Cleanup: Simply pass the directory you want to backup.

```
./zip_and_upload.sh "/path/to/folder"
```

## Backup With Cleanup: Pass the directory you want to backup followed by cleanup.
```
./zip_and_upload.sh "/path/to/folder" cleanup
```

## Schedule with Cron

```
crontab -e
```

Add a line to schedule your script, for example:

```
0 1,13 * * * cd /root/rclone-zip-backup && bash zip_and_upload.sh "/home" cleanup >> /var/log/zip-and-backup.log 2>&1
```

Notes:
- The nice command can be used to lower the priority of a process, making it yield CPU time to other processes more readily. This doesn't limit CPU usage to a specific percentage but can reduce the overall impact on system performance, ```-n 19``` sets the niceness level to 19, which is the lowest priority.
- Remember to test this script manually to ensure it works as expected, especially to confirm that it doesn't unduly impact your production environment.
- This was made to work with an already setup rclone, it is an alternative to using the built in backup in my own cloudpanel server and you should not just blindly run this, I take no responsibility if you break something

This setup should do regular backups of the directory set with minimal impact on your server's performance and network bandwidth.