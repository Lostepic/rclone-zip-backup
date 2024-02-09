# rclone-zip-backup
SH Script to zip and rclone with CPU and Network limits

```
git clone https://github.com/Lostepic/rclone-zip-backup
```

Step 1: Install Necessary Tools

You'll need to install `7zip`, `cpulimit` and `trickle`. For Debian/Ubuntu systems, you can use:

```
sudo apt-get update
sudo apt-get install p7zip-full trickle cpulimit
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

- The nice command adjusts the priority of the process, making it less likely to interfere with more critical processes like those running your website.
- cpulimit does not limit the process to specific cores but limits its CPU usage to a percentage of the total available CPU power. If you have a specific requirement to use exactly two cores, you might need a more complex setup involving taskset and a detailed analysis of your server's load and capabilities.
- The -mx=3 option for 7z sets the compression level to a balance between speed and compression efficiency. You can adjust this based on your needs.
- Remember to test this script manually to ensure it works as expected, especially to confirm that it doesn't unduly impact your production environment.

This setup should do regular backups of the directory set with minimal impact on your server's performance and network bandwidth.