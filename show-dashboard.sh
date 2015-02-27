#!/bin/bash

GIT_VER="$(git rev-parse HEAD)"
echo "Dashy Device rev. ${GIT_VER}"

PRIMARY_DISPLAY_WIDTH="$(xrandr | grep "*" | xargs | cut -d " " -f 1 | cut -d "x" -f 1)"
PRIMARY_DISPLAY_HEIGHT="$(xrandr | grep "*" | xargs | cut -d " " -f 1 | cut -d "x" -f 2)"
SECONDARY_DISPLAY_WIDTH="$(xrandr | grep "*" | xargs | cut -d " " -f 4 | cut -d "x" -f 1)"
SECONDARY_DISPLAY_HEIGHT="$(xrandr | grep "*" | xargs | cut -d " " -f 4 | cut -d "x" -f 2)"

if [ -n "$SECONDARY_DISPLAY_WIDTH" ]; then
  MULTI_DISPLAY=true
else
  MULTI_DISPLAY=false
fi

echo "Primary display width: ${PRIMARY_DISPLAY_WIDTH}px"
echo "Primary display height: ${PRIMARY_DISPLAY_HEIGHT}px"
if $MULTI_DISPLAY; then
  echo "Secondary display width: ${SECONDARY_DISPLAY_WIDTH}px"
  echo "Secondary display height: ${SECONDARY_DISPLAY_HEIGHT}px"
fi

if [ ! -f ~/.dashy ]; then
  echo "Initialising ~/.dashy config..."
  echo "DASHY_CLIENT_URL=\"http://client.dashy.io/\"" >> ~/.dashy
  echo "DASHY_API_URL=\"http://api.dashy.io/\"" >> ~/.dashy
  echo "DASHBOARD1_ID=$(uuidgen)" >> ~/.dashy
  if $MULTI_DISPLAY; then
    echo "DASHBOARD2_ID=$(uuidgen)" >> ~/.dashy
    echo "DISPOSITION=horizontal" >> ~/.dashy
  fi
else
  echo "Using existing ~/.dashy config"
fi

source ~/.dashy

if $MULTI_DISPLAY; then
  echo "Dashboard multi-screen disposition: ${DISPOSITION}"
fi

DASHBOARD1_URL="${DASHY_CLIENT_URL}?id=${DASHBOARD1_ID}&ver=${GIT_VER}"
DASHBOARD2_URL="${DASHY_CLIENT_URL}?id=${DASHBOARD2_ID}&ver=${GIT_VER}"

echo "Dashboard 1 URL: ${DASHBOARD1_URL}"
if [ -n "$DASHBOARD2_ID" ]; then
  echo "Dashboard 2 URL: ${DASHBOARD2_URL}"
fi

printf "Waiting for api.dashy.io to be available: "
until $(curl --output /dev/null --silent --head --fail ${DASHY_API_URL}status); do
    printf '.'
    sleep 1
done
printf "OK\r\n"

echo "Automatically hiding the mouse cursor"
unclutter -idle 0.5

if command -v google-chrome-stable >/dev/null 2>&1; then
  echo "Running google-chrome-stable on primary screen"
  google-chrome-stable --incognito --no-first-run --start-fullscreen --window-position=0,0 --user-data-dir="$(mktemp -d)" ${DASHBOARD1_URL} 2> /dev/null &
  if [ -n "$DASHBOARD2_ID" ]; then
    if [ "$DISPOSITION" == "horizontal" ]; then
      WINDOW_POSITION=${PRIMARY_DISPLAY_WIDTH},0
    else
      WINDOW_POSITION=0,${PRIMARY_DISPLAY_HEIGHT}
    fi
    echo "Running google-chrome-stable on secondary screen (${WINDOW_POSITION})"
    google-chrome-stable --incognito --no-first-run --start-fullscreen --window-position=${WINDOW_POSITION} --user-data-dir="$(mktemp -d)" ${DASHBOARD2_URL} 2> /dev/null &
  fi
  exit 0
fi

# if command -v midori >/dev/null 2>&1; then
#   echo "Running dashboard with midori"
#   midori -e Fullscreen -a ${DASHBOARD_FILE}
#   exit 0
# fi

# if command -v epiphany-browser >/dev/null 2>&1; then
#   echo "Running dashboard with epiphany-browser"
#   epiphany-browser -a --profile /tmp ${DASHBOARD_FILE}
#   exit 0
# fi

echo "ERROR: Cannot find a browser!"
exit 1
