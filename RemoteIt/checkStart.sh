#!/bin/bash

# greps to see if chrome is started
ps aux | grep -v grep | grep "/Applications/Google Chrome.app"
check=$?

# if it is, exit this script 
if [ "${check}" -eq "0" ]
then
	# write it to log file
	echo "Chrome is started"

	exit 0
else
	# Else, start chrome
	echo "Starting Chrome RemoteIt"
	export DISPLAY=:0
	python /usr/local/bin/showWebsites.py &
	
	sleep 5
	osascript /usr/local/bin/rmBar.scpt
	
	exit 0

fi
exit 0
