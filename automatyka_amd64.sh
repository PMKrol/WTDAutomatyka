#! /bin/bash

sudo apt update

#sudo apt remove unattended-upgrades modemmanager -y
sudo apt remove  modemmanager -y
sudo apt install veyon-service mc screen openssh-server openssh-client x11vnc apache2 openjdk-8-jdk gnome-disk-utility smartmontools net-tools -y

#sleep 1h
#systemctl reboot

### Arduino IDE ###
sudo snap install arduino
arduino &
sudo usermod -a -G dialout student
sudo apt remove modemmanager -y
ln -s /var/lib/snapd/desktop/applications/arduino_arduino.desktop "/home/student/Pulpit/Arduino IDE"

### EAGLE install ###
#Based on https://github.com/Blunk-electronic/EAGLE_Linux_Installer

mkdir eagle
cd eagle
wget https://trial2.autodesk.com/NET17SWDLD/2017/EGLPRM/ESD/Autodesk_EAGLE_9.6.2_English_Linux_64bit.tar.gz
#wget https://github.com/Blunk-electronic/EAGLE_Linux_Installer/raw/master/install-eagle.sh
#chmod +x *.sh


installer=Autodesk_EAGLE_9.6.2_English_Linux_64bit.tar.gz
version=9.6.2
target_dir=/opt

echo "installing EAGLE" $version to target directory $target_dir "..."

echo "unzipping the install file" $installer "..."
# unpack without warning. Keep installer file.
gunzip --force -k $installer

installer=${installer%.gz}
echo "unpacking the tape archive" $installer to target directory $target_dir "..."
sudo tar --warning none --no-same-owner -xf $installer -C $target_dir

# clean up
rm *.tar

# change to target directory
#cd $target_dir

echo "setting permissions ..."

# Change permissions so that non-root users may enter and read it:
sudo chmod 755 /opt/eagle-$version

# change into the eagle install directory
#cd eagle-$version

# All files there must have the r (readable) flag set so that also non-root
# users can open and read them:
sudo chmod -R a+r /opt/eagle-$version/*

# Change the Eagle executable so that non-root users may launch it:
sudo chmod a+x /opt/eagle-$version/eagle

# All directories must be readable by all users. so that non-root users
# can change into them:
sudo find /opt/eagle-$version/ -type d -exec chmod a+x {} \;

# Remove all files starting with 'libxcb' in the subdirectory 'lib'
sudo rm /opt/eagle-$version/lib/libxcb*

# The remaining libraries there must be set executable for non-root 
# users. I'm not sure if all files require this setting but this way all
# of them are addressed:
sudo chmod 755 /opt/eagle-$version/lib/*

# Change permissions of Qt stuff:
sudo chmod 755 /opt/eagle-$version/libexec/QtWebEngineProcess

echo "Installation complete. Please adjust PATH variable."

#Create icons
echo "installing EAGLE desktop icon" $version "..."

icon=$HOME/Pulpit/EAGLE_$version.desktop

if [ -e $icon ]; then
	{
	echo "removing old icon ..."
	rm $icon
	}
fi

echo [Desktop Entry] >> $icon
echo Version=1.0 >> $icon
echo Type=Application >> $icon
echo Name=EAGLE_$version >> $icon
echo Comment= >> $icon
echo Exec=/opt/eagle-$version/eagle >> $icon
echo Icon=/opt/eagle-$version/bin/eagle-logo.png >> $icon
echo Path= >> $icon
echo Terminal=false >> $icon
echo StartupNotify=false >> $icon
#End of create icon

cd ..


### Arduino libs ###
### EAGLE Libs + Ulps ###
#mkdir eagleStuff
#cd eagleStuff
#wget "https://github.com/PMKrol/EagleStuff/archive/refs/heads/main.zip"
#7z x main.zip
#mv EagleStuff-main/ EAGLE
#cp EAGLE ~/ -r
#cd ..

### Universal G-Code sender
mkdir UGS
cd UGS
#sudo apt install openjdk-8-jdk -y
wget https://ugs.jfrog.io/ugs/UGS/v2.0.11/UniversalGcodeSender.zip
7z x UniversalGcodeSender.zip -aoa
sudo cp UniversalGcodeSender/UniversalGcodeSender.jar /opt
echo '#! /bin/bash' > /home/student/Pulpit/UGS.sh
echo 'java -jar /opt/UniversalGcodeSender.jar' >> /home/student/Pulpit/UGS.sh
chmod +x /home/student/Pulpit/UGS.sh
cd ..


### VNC ###
#sudo apt install x11vnc -y

### webgcode localhost
#sudo apt install apache2 -y
wget "https://github.com/nraynaud/webgcode/archive/refs/heads/gh-pages.zip"
7z x gh-pages.zip -aoa
sudo cp -r webgcode-gh-pages/* /var/www/html
sudo chmod -R 775 /var/www/html

icon=/home/student/Pulpit/Gcode.desktop
echo [Desktop Entry] > $icon
echo Encoding=UTF-8 >> $icon
echo Name=G-code Viewer >> $icon
echo Type=Link >> $icon
echo URL=http://localhost/ >> $icon
echo Icon=text-html >> $icon

#unattended
#sudo nano /etc/apt/apt.conf.d/20auto-upgrades
sudo cp /usr/share/unattended-upgrades/20auto-upgrades-disabled  /etc/apt/apt.conf.d/

### automatyka2 ###

#Disable wifi settings access
icon=disable-network-control.pkla

echo [Wifi management] > $icon
echo "Identity=unix-user:*" >> $icon
echo Action=org.freedesktop.NetworkManager.settings.* >> $icon
echo ResultAny=no >> $icon
echo ResultInactive=no >> $icon
echo ResultActive=no >> $icon

echo [Wifi sysad management] >> $icon
echo "Identity=unix-group:sudo;unix-user:root" >> $icon
echo Action=org.freedesktop.NetworkManager.settings.* >> $icon
echo ResultAny=yes >> $icon
echo ResultInactive=yes >> $icon
echo ResultActive=yes >> $icon

sudo cp disable-network-control.pkla /etc/polkit-1/localauthority/50-local.d/disable-network-control.pkla

#Disable screen-lock
#TODO
kwriteconfig5 --file kscreensaverrc --group Daemon --key Autolock false

#Disable sleep
#TODO
sudo systemctl mask sleep.target suspend.target

#Set power-button to off
#TODO

#Disable MSI touchscreen
icon=20-block-touchscreen-msi.rules

echo "#MSI Touchscreen disable, Quanta Computer, Inc. OpticalTouchScreen" >> $icon
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0408", ATTRS{idProduct}=="3008", ATTR{authorized}="0"' >> $icon

sudo cp $icon /lib/udev/rules.d/

### VNC ####
sudo apt install net-tools nmap -y
icon=x11vnc.service

echo '# File: /etc/systemd/system/x11vnc.service' > $icon
echo '[Unit]' >> $icon
echo 'Description="x11vnc"' >> $icon
echo 'Requires=display-manager.service' >> $icon
echo 'After=display-manager.service' >> $icon
echo '' >> $icon
echo '[Service]' >> $icon
echo 'ExecStart=/usr/bin/x11vnc -loop -nopw -xkb -repeat -noxrecord -noxfixes -noxdamage -forever -rfbport 5900 -display :0 -auth guess' >> $icon
echo '#ExecStart=/usr/bin/x11vnc -loop -nopw -noxdamage -forever -rfbport 5900 -auth guess -display :0' >> $icon
echo 'ExecStop=/usr/bin/killall x11vnc' >> $icon
echo 'Restart=on-failure' >> $icon
echo 'RestartSec=2' >> $icon
echo 'User=student' >> $icon
echo '' >> $icon
echo '[Install]' >> $icon
echo 'WantedBy=multi-user.target' >> $icon

sudo cp $icon /etc/systemd/system/x11vnc.service

sudo systemctl daemon-reload
sudo systemctl enable x11vnc.service
sudo systemctl start x11vnc.service
#systemctl status x11vnc.service

sudo apt update && sudo apt upgrade -y

#18.11.2024
chmod +x porzadek.sh
sudo ./porzadek.sh

### automatyka2 end ###

### todo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# lid -> nothing
# powerbutton = off
# no screen-lock
# x11vnc from source


### NEW ###
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
" | sudo tee /etc/polkit-1/localauthority/50-local.d/nofurtherlogin.pkla

### hosts
sudo nano /etc/hostname
sudo nano /etc/hosts

wget https://github.com/PMKrol/WTDAutomatyka/raw/main/update.sh -O update.sh
chmod +x update.sh
./update.sh

### useradd and mod ###
sudo adduser san
sudo usermod -a -G sudo san
sudo adduser san dialout
echo "User san"
su san -P -c "sudo deluser student sudo"

gnome-disks

systemctl reboot
