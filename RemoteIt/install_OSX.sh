#!/bin/bash

usr="/Users/netadmin/"

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -privs -all -users netadmin

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install chromedriver
brew install wget

wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

installPIP=$(sudo pip install selenium)
if [[ ${installPIP} == 0 ]]
then
    echo "pip installed correctly"
else
    sudo pip install selenium
fi

wget https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg

sudo hdiutil attach googlechrome.dmg
sudo cp -r /Volumes/Google\ Chrome/Google\ Chrome.app /Applications/
sudo hdiutil detach /Volumes/Google\ Chrome

sudo crontab tmpSuCron.txt

echo "*/1 * * * * /usr/local/bin/checkStart.sh 2> /Users/netadmin/check_Error.log" >> tmpCron.txt
echo "*/1 * * * * osascript /usr/local/bin/focus.scpt 2> /Users/netadmin/check_Error.log" >> tmpCron.txt

crontab tmpCron.txt

echo "Enabling ssh login"
sudo systemsetup -setremotelogin on

echo "00 06 * * * /sbin/shutdown -r now 2> /dev/null" >> tmpSuCron.txt
#echo "*/2 * * * * /usr/local/bin//checkNetwork.sh" >> tmpSuCron.txt # Only for Raspberries

sudo crontab tmpSuCron.txt

rm tmpSuCron.txt tmpCron.txt

echo "Setting values to disable sleep"
sleep 5
sudo pmset sleep 0
sudo pmset displaysleep 0
echo "Done"

echo "Disables notifications"
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

echo "Creating directories and files for netadmin"
sleep 5
mkdir ${usr}showWebsites
echo "http://hd.se/#hds-no-ads-impressions" > ${usr}showWebsites/confSites.txt
echo "http://sydsvenskan.se/#hds-no-ads-impressions" >> ${usr}showWebsites/confSites.txt

echo "Cleaning"
sleep 5
sudo rm -r /usr/local/bin/install_OSX.sh
sudo rm -r ${usr}googlechrome.dmg
sudo rm -r ${usr}get-pip.py

echo "Done!"

exit 0
