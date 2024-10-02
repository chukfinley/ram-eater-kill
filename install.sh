#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Install required packages
apt-get update
apt-get install -y libnotify-bin

# Copy the RAM monitor script to /usr/local/bin
cp ram_monitor.sh /usr/local/bin/
chmod +x /usr/local/bin/ram_monitor.sh

# Copy the systemd service file
cp ram_monitor.service /etc/systemd/system/

# Reload systemd, enable and start the service
systemctl daemon-reload
systemctl enable ram_monitor.service
systemctl start ram_monitor.service

echo "RAM Monitor has been installed and started."
echo "You can check its status with: systemctl status ram_monitor.service"
