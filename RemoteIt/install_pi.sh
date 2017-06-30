#!/bin/bash

sudo apt-get install -y unclutter openssh-server ubuntu-mate-desktop dkms build-essential bc gcc
sudo update-rc.d ssh enable

echo "*/3 * * * * /home/netadmin/checkStart.sh 2> /home/netadmin/check_Error.log" >> tmpCron.txt

crontab tmpCron.txt


echo "00 06 * * * /sbin/shutdown -r now 2> /dev/null" >> tmpSuCron.txt
echo "*/2 * * * * /home/netadmin/checkNetwork.sh" >> tmpSuCron.txt

sudo crontab tmpSuCron.txt

sudo sed -i.bak s/APT::Periodic::Update-Package-Lists\ "1";/APT::Periodic::Update-Package-Lists "0";/g /etc/apt/apt.conf.d/10periodic

echo "Downloading files for wireless"
sleep 5

git clone https://github.com/abperiasamy/rtl8812AU_8821AU_linux && cd rtl*


sed -i.bak s/CONFIG_PLATFORM_I386_PC\ =\ y/CONFIG_PLATFORM_I386_PC\ =\ n/g Makefile

sed -i.bak s/CONFIG_PLATFORM_ARM_RPI\ =\ n/CONFIG_PLATFORM_ARM_RPI\ =\ y/g Makefile

make

sudo make install

wget https://raw.github.com/alxr91/RemoteIt/master/checkNetwork.sh

wget https://raw.github.com/alxr91/RemoteIt/master/checkStart.sh

wget https://raw.github.com/alxr91/RemoteIt/master/rebootit.sh

wget https://raw.github.com/alxr91/RemoteIt/master/showWebsites.py

wget https://raw.github.com/alxr91/RemoteIt/master/updateScript.sh

echo "Moving files for RI - Remote It"

mkdir -p /home/${USER}/showWebsites
sudo mv updateScript.sh /usr/bin/updateScript.sh
cp *.sh /home/${USER}
cp *.py /home/${USER}


sudo sh -c 'echo "autologin-user=netadmin" >> /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf'

echo "Downloading Geckodriver"
wget https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-arm7hf.tar.gz
tar xvfz geckodriver-v0.11.1-arm7hf.tar.gz
sudo mv geckodriver /usr/bin/geckodriver

echo "Geckodriver is in place!"

sudo apt-get install -y python-pip

sudo -H pip install selenium
chmod +x *.sh
rm -r /home/netadmin/*.txt

echo "Everything is done, rebooting in 10sek"
sleep 10

sudo shutdown -r now

exit 0


