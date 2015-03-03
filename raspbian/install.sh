#!/bin/bash

echo "Installing on Raspberry Pi..."

read -p "Do you want to update the system? [Y/n] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
	echo "Updating packages"
	sudo apt-get update
	sudo apt-get --yes upgrade
	sudo apt-get --yes dist-upgrade
	echo "Updating firmware"
	sudo rpi-update
fi

if [ ! -f /etc/lightdm/lightdm.conf.ori ]; then
	echo "Backing up original lightdm config to /etc/lightdm/lightdm.conf.ori"
	sudo mv /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.ori
fi

echo "Configuring lightdm to autologin and disable screen blanking"
sudo cp lightdm.conf /etc/lightdm/lightdm.conf

if [ ! -f /etc/xdg/lxsession/LXDE-pi/autostart.ori ]; then
	echo "Backing up original LXDE-pi autostart config to /etc/xdg/lxsession/LXDE-pi/autostart.ori"
	sudo mv /etc/xdg/lxsession/LXDE-pi/autostart /etc/xdg/lxsession/LXDE-pi/autostart.ori
fi

echo "Configuring LXDE-pi to hide the mouse cursor, disable screen blanking and start the browser..."
sudo cp autostart /etc/xdg/lxsession/LXDE-pi/autostart

echo "Installing Dashy dependency: unclutter"
sudo apt-get --yes install unclutter

echo "Installing Dashy dependency: chromium"
sudo apt-get --yes install chromium

echo "Done."
