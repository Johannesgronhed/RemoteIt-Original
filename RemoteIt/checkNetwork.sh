#!/bin/bash

# ping
ping -c 5 8.8.8.8
check=$?

# check if ping went OK!
if [[ $check == '0' ]]
then
        echo "Internet is working"
else    # restart network services 
        nmcli networking off
        nmcli networking on

        sleep 10
        
        
        ping -c 5 8.8.8.8
        checkAgain=$?

        # check if ping went OK again
        if [[ $checkAgain == '0' ]]
        then
                # if ping went OK, then exit this script
                exit 0
        else
                # else try to reload the driver 
                sudo modprobe -r rtl8812au
                sudo modprobe rtl8812au
                sleep 10

                ping -c 5 8.8.8.8
                chckOnce=$?

                # check ping again
                if [[ $chckOnce == '0' ]]
                then
                        exit 0
                else
                        # restart network-manager and check ping again
                        sudo service network-manager restart
                        sleep 10
                        ping -c 5 8.8.8.8
                        chckAgain=$?

                        # if ping went OK, exit this script
                        if [[ $chckAgain == '0' ]]
                        then
                                exit 0
                        else
                                # else restart the computer
                                sudo init 6
                        fi
                fi
        fi
fi
