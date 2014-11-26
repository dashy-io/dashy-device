if [ ! -f /etc/lightdm/lightdm.conf.ori ]; then
  echo "Backing up original lightdm config to /etc/lightdm/lightdm.conf.ori"
  sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.ori
fi
echo "Configuring lightdm to disable screen blanking..."
sudo cp lightdm.conf /etc/lightdm/lightdm.conf

if [ ! -f /etc/xdg/lxsession/LXDE/autostart.ori ]; then
  echo "Backing up original LXDE autostart config to /etc/xdg/lxsession/LXDE/autostart.ori"
  sudo cp /etc/xdg/lxsession/LXDE/autostart /etc/xdg/lxsession/LXDE/autostart.ori
fi
echo "Configuring LXDE to hide the mouse cursor and disable screen blanking..."
sudo cp autostart /etc/xdg/lxsession/LXDE/autostart

echo "Installing Dashboard autostart..."
mkdir -p  ~/.config/autostart
cp dash.desktop ~/.config/autostart

echo "Done."
