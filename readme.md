# Useful stuff for creating a dashboard on Raspberry Pi

- Script that checks if wifi is connected, if not restarts wifi: http://rpi.tnet.com/project/scripts/wifi_check
- Install unclutter: `apt-get install unclutter`
- Add to `/etc/lightdm/lightdm.conf` in the correct section:
```
[SeatDefaults]
xserver-command=X -s 0 -dpms
```
- Replace `/etc/xdg/lxsession/LXDE/autostart` contents with:
```sh
xset s off         # don't activate screensaver
xset -dpms         # disable DPMS (Energy Star) features.
xset s noblank     # don't blank the video device
@unclutter -idle 0.1 -root # hides mouse cursor
```

## Dependencises
sudo apt-get install uuid-runtime

## Installation
```bash
mkdir ~/.config/autostart
cp dash.desktop ~/.config/autostart
```
