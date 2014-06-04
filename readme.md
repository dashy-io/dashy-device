# Useful stuff for creating a dashboard on Raspberry Pi

- Checks if wifi is connected, if not restarts wifi
  http://rpi.tnet.com/project/scripts/wifi_check
- install unclutter
- edit /etc/xdg/lxsession/LXDE/autostart
  ```sh
  xset s off         # don't activate screensaver
  xset -dpms         # disable DPMS (Energy Star) features.
  xset s noblank     # don't blank the video device
  @unclutter -idle 0.1 -root # hides mouse cursor
  ```
- sudo vi /etc/lightdm/lightdm.conf
  ```
  [SeatDefaults]
  xserver-command=X -s 0 -dpms
  ```
