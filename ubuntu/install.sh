if [ ! command -v google-chrome-stable >/dev/null 2>&1 ]; then
	echo "Installing Dashy dependency: google-chrome-stable"
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
	sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
	sudo apt-get update
	sudo apt-get install google-chrome-stable
fi
if [ ! command -v uuidgen >/dev/null 2>&1 ]; then
	echo "Installing Dashy dependency: uuid-runtime"
	sudo apt-get install uuid-runtime
fi
if [ ! command -v unclutter >/dev/null 2>&1 ]; then
	echo "Installing Dashy dependency: unclutter"
	sudo apt-get install unclutter
fi

if [ ! -f /etc/lightdm/lightdm.conf.ori ]; then
	echo "Backing up original lightdm config to /etc/lightdm/lightdm.conf.ori"
	sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.ori
fi
echo "Configuring lightdm to disable screen blanking"
sudo cp lightdm.conf /etc/lightdm/lightdm.conf

if [ ! -f ~/.config/autostart/dashy.desktop ]; then
	echo "Creating autostart desktop entry"
	ln -s "$(pwd)/dashy.desktop" ~/.config/autostart/dashy.desktop
fi

# sudo apt install --no-install-recommends openbox

#sudo install -b -m 755 /dev/stdin /opt/kiosk.sh << EOF
#!/bin/bash

#xset -dpms
#xset s off
#openbox-session &

# while true; do
    #google-chrome --kiosk --no-first-run
# done
#EOF

#sudo install -b -m 644 /dev/stdin /etc/init/kiosk.conf << EOF
#start on (filesystem and stopped udevtrigger)
#stop on runlevel [06]

#emits starting-x
#respawn

#exec sudo -u $USER startx /etc/X11/Xsession /opt/kiosk.sh --
#EOF

#sudo dpkg-reconfigure x11-common  # select Anybody

#echo manual | sudo tee /etc/init/lightdm.override  # disable desktop

#sudo reboot