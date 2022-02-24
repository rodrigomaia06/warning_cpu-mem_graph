#!/bin/bash
PCUSER=`whoami`
echo "Removing Cronjob ......"; crontab -l | grep -v '.scriptmail-dependencies/' | crontab -; sleep 1
echo "Removing Script's Folder ......" 
rm -r -f /home/$PCUSER/.scriptmail-dependencies/; sleep 1
echo "Uninstallation Completed!"; sleep 1
