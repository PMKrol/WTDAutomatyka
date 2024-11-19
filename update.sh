#!/bin/bash

#This script updates EAGLE's library and ulps 
# and Arduino's library folder

cd ~/Pobrane
wget -q https://github.com/PMKrol/WTDAutomatyka/archive/refs/heads/main.zip -O WTDAutomatyka.zip -q && echo "wget ok"
#echo "7z x WTDAutomatyka.zip -aoa -bso0 -bsp0"
7z x WTDAutomatyka.zip -aoa -bso0 -bsp0
cp -r WTDAutomatyka-main/snap/arduino/current/* /home/student/snap/arduino/current/
cp -r WTDAutomatyka-main/EAGLE/ /home/student
chmod 0777 /home/student/Pulpit/Dodatek.txt
rm /home/student/Pulpit/Dodatek.txt
cp WTDAutomatyka-main/Dodatek.ngc /home/student/Pulpit/Dodatek.txt
chmod 0444 /home/student/Pulpit/Dodatek.txt

### disable password prompt for poweroff ###
echo "[Allow all users to shutdown]
Identity=unix-user:*
Action=org.freedesktop.login1.power-off-multiple-sessions
ResultAny=yes
ResultActive=yes
[Allow all users to reboot]
Identity=unix-user:*
Action=org.freedesktop.login1.reboot-multiple-sessions
ResultAny=yes
ResultActive=yes
[Allow all users to suspend]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend-multiple-sessions
ResultAny=yes
ResultActive=yes
[Allow all users to ignore inhibit of shutdown]
Identity=unix-user:*
Action=org.freedesktop.login1.power-off-ignore-inhibit
ResultAny=yes
ResultActive=yes
[Allow all users to ignore inhibit of reboot]
Identity=unix-user:*
Action=org.freedesktop.login1.reboot-ignore-inhibit
ResultAny=yes
ResultActive=yes
[Allow all users to ignore inhibit of suspend]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend-ignore-inhibit
ResultAny=yes
ResultActive=yes
" | sudo tee /etc/polkit-1/localauthority/50-local.d/nofurtherlogin.pkla && echo "OK!"


### disable brltty for 22.04
sudo systemctl stop brltty-udev.service
sudo systemctl mask brltty-udev.service
sudo systemctl stop brltty.service
sudo systemctl disable brltty.service

sudo chmod +x ./veyon.sh
sudo ./veyon.sh
