#!/bin/bash

#This script updates EAGLE's library and ulps 
# and Arduino's library folder

cd ~/Pobrane
wget -q https://github.com/PMKrol/WTDAutomatyka/archive/refs/heads/main.zip -O WTDAutomatyka.zip -q && echo "wget ok"
echo "7z x WTDAutomatyka.zip -aoa -bso0 -bsp0"
7z x WTDAutomatyka.zip -aoa -bso0 -bsp0
cp -r WTDAutomatyka-main/snap/arduino/current/* /home/student/snap/arduino/current/
cp -r WTDAutomatyka-main/EAGLE/ /home/student
chmod 0777 /home/student/Pulpit/Dodatek.txt
rm /home/student/Pulpit/Dodatek.txt
cp WTDAutomatyka-main/Dodatek.ngc /home/student/Pulpit/Dodatek.txt
chmod 0444 /home/student/Pulpit/Dodatek.txt
