#!/bin/bash

ping -c 1 8.8.8.8
check=$?

if [[ $check == '0' ]]
then
	echo "Internet is working"
else
	logger -i "Internet is down rebooting"
	/home/netadmin/rebootIt.sh
fi
