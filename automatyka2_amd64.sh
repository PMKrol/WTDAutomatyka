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

#echo "Password for student"
#su student -P -c "
#	gsettings set org.gnome.desktop.screensaver lock-enabled false;
#	gsettings set org.gnome.desktop.session idle-delay 0;
#	gsettings set org.gnome.settings-daemon.plugins.power button-power 'shutdown';"

#Disable screen-lock
#TODO
kwriteconfig5 --file kscreensaverrc --group Daemon --key Autolock false

#Disable sleep
#TODO
sudo systemctl mask sleep.target suspend.target

#Set power-button to off
#TODO

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
