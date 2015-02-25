#!/bin/bash

xset s off # don't activate screensaver
xset -dpms # disable DPMS (Energy Star) features.
xset s noblank # don't blank the video device
unclutter -idle 0.1 -root # hides mouse cursor
~/dashy-client/show-dashboard.sh