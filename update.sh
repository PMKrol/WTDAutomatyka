#!/bin/bash

//This script updates EAGLE's library and ulps 
// and Arduino's library folder

cd Pobrane
wget https://github.com/PMKrol/WTDAutomatyka/archive/refs/heads/main.zip -O WTDAutomatyka.zip
7z x WTDAutomatyka.zip -aoa
cp -r WTDAutomatyka-main/snap/arduino/current/* /home/student/snap/arduino/current/
cp -r WTDAutomatyka-main/EAGLE/ /home/student
