#!/bin/bash

echo "Installing on Raspberry Pi..."

echo "Updating packages"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

echo "Updating firmware"
sudo rpi-update

if [ ! -f /etc/lightdm/lightdm.conf.ori ]; then
	echo "Backing up original lightdm config to /etc/lightdm/lightdm.conf.ori"
	sudo mv /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.ori
fi

if [ ! -f /etc/lightdm/lightdm.conf ]; then
	echo "Configuring lightdm to autologin and disable screen blanking"
	sudo cp lightdm.conf /etc/lightdm/lightdm.conf
fi

if [ ! -f /etc/xdg/lxsession/LXDE/autostart.ori ]; then
	echo "Backing up original LXDE autostart config to /etc/xdg/lxsession/LXDE/autostart.ori"
	sudo mv /etc/xdg/lxsession/LXDE/autostart /etc/xdg/lxsession/LXDE/autostart.ori
fi

if [ ! -f /etc/xdg/lxsession/LXDE/autostart ]; then
	echo "Configuring LXDE to hide the mouse cursor, disable screen blanking and start the browser..."
	sudo cp autostart /etc/xdg/lxsession/LXDE/autostart
fi

if [ ! command -v unclutter >/dev/null 2>&1 ]; then
	echo "Installing Dashy dependency: unclutter"
	sudo apt-get install unclutter
fi

if [ ! command -v chromium >/dev/null 2>&1 ]; then
	echo "Installing Dashy dependency: chromium"
	sudo apt-get install chromium
fi

echo "Done."
