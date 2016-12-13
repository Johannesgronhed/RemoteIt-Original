#!/bin/bash -x

ps aux | grep -v grep | grep /usr/lib/firefox/firefox
check=$?

if [ "${check}" -eq "0" ]
then
	logger -i "Firefox is started"
else
	logger -i "Starting firefox RemoteIt"
	export DISPLAY=:0
	python /home/netadmin/showWebsites.py &
fi

ps aux | grep -v grep | grep Xtightvnc
check2=$?

if [ "${check2}" -eq "0" ]
then
	logger -i "RemoteIt is started"
else
	export USER="netadmin"
	export DISPLAY=:0
	logger -i "Starting vnc RemoteIT"
	/usr/bin/vncserver
fi


exit 0
