# Useful stuff for creating a dashboard on Raspberry Pi

- Script that checks if wifi is connected, if not restarts wifi: http://rpi.tnet.com/project/scripts/wifi_check
- Install unclutter: `apt-get install unclutter`
- edit `/etc/lightdm/lightdm.conf`
```
[SeatDefaults]
xserver-command=X -s 0 -dpms
```
- edit `/etc/xdg/lxsession/LXDE/autostart`
```sh
xset s off         # don't activate screensaver
xset -dpms         # disable DPMS (Energy Star) features.
xset s noblank     # don't blank the video device
@unclutter -idle 0.1 -root # hides mouse cursor
#@xscreensaver -no-splash # Optional, enable this if the screen is still going blank
```
