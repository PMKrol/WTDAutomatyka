#!/bin/bash

#This script updates EAGLE's library and ulps 
# and Arduino's library folder

cd ~/Pobrane
wget -q https://github.com/PMKrol/WTDAutomatyka/archive/refs/heads/main.zip -O WTDAutomatyka.zip -q && echo "wget ok"
7z x WTDAutomatyka.zip -aoa > /dev/null
cp -r WTDAutomatyka-main/snap/arduino/current/* /home/student/snap/arduino/current/
cp -r WTDAutomatyka-main/EAGLE/ /home/student
cp WTDAutomatyka-main/Dodatek.ngc /home/student/Pulpit/Dodatek.txt
chmod 0444 /home/student/Pulpit/Dodatek.txt
