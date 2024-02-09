# rclone-zip-backup
SH Script to zip and rclone with Network limit

```
git clone https://github.com/Lostepic/rclone-zip-backup
```

Step 1: Install Necessary Tools

You'll need to install `pigz`. For Debian/Ubuntu systems, you can use:

```
sudo apt-get update
sudo apt-get install pigz
```

Step 2: Edit the script

Instructions for each option are inside the script, make sure to have rclone setup already with your remote, in my example using gdrive

```
nano zip_and_upload.sh
```

Step 3: Make the Script Executable

```
chmod +x zip_and_upload.sh
```

Step 4: Schedule with Cron

```
crontab -e
```

Add a line to schedule your script, for example:

```
0 1,13 * * * /path/to/your/zip_and_upload.sh
```

Notes:
- The nice command can be used to lower the priority of a process, making it yield CPU time to other processes more readily. This doesn't limit CPU usage to a specific percentage but can reduce the overall impact on system performance, ```-n 19``` sets the niceness level to 19, which is the lowest priority.
- Remember to test this script manually to ensure it works as expected, especially to confirm that it doesn't unduly impact your production environment.

This setup should do regular backups of the directory set with minimal impact on your server's performance and network bandwidth.