sudo apt install veyon-service -y
sudo systemctl enable veyon.service
sudo wget "https://raw.githubusercontent.com/PMKrol/WTDAutomatyka/main/Veyon.conf" -O /etc/xdg/Veyon\ Solutions/Veyon.conf
sudo service veyon restart
