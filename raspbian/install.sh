#!/bin/bash

echo "Installing Dashy on Raspberry Pi..."

read -p "Do you want to update the system? [Y/n] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
	echo "Updating packages..."
	sudo apt-get update
	sudo apt-get --yes upgrade
	sudo apt-get --yes dist-upgrade
	echo "Updating firmware..."
	sudo rpi-update
fi

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd ${DIR}

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

echo "Configuring LXDE-pi to hide the mouse cursor, disable screen blanking and start the browser"
sudo cp autostart /etc/xdg/lxsession/LXDE-pi/autostart

if [ ! -f /etc/crontab.ori ]; then
	echo "Backing up original crontab to /etc/crontab.ori"
	sudo mv /etc/crontab /etc/crontab.ori
fi

popd

echo "Configuring crontab to automatically reboot device once per day"
sudo cp crontab /etc/crontab

echo "Installing Dashy dependency: unclutter"
sudo apt-get --yes install unclutter

echo "Installing Dashy dependency: chromium"
sudo apt-get --yes install chromium

echo "Done."
