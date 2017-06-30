#!/bin/bash

# Remove all old scripts
rm -r /usr/local/bin/checkStart.sh
rm -r /usr/local/bin/checkNetwork.sh
rm -r /usr/local/bin/updateScript.sh
rm -r /usr/local/bin/focus.scpt
rm -r /usr/local/bin/rmBar.scpt
rm -r /usr/local/bin/*.py

# Kill Google Chrome and chromedriver
killall Google\ Chrome && killall chromedriver

# Download an update package
wget https://github.com/alxr91/RemoteIt/raw/master/RiUpdate_OSX.pkg

tty=$(who | grep 'ttys' | wc -l )

# Install the new scripts
sudo installer -pkg RiUpdate_OSX.pkg -target /


# Make them executable
chmod +x /usr/local/bin/*.sh
chmod +x /usr/local/bin/*.scpt
chmod +x /usr/local/bin/*.py

# Exit with code 0
exit 0
