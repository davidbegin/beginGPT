#!/bin/sh

AUDIO="$1"

pid=$(ps -ef | grep "$AUDIO".wav | grep -v grep | awk '{print $2}')

if [ -z "$pid" ]; then
  echo "No process found for $AUDIO.wav"
else
  if kill -0 "$pid" 2>/dev/null; then
    kill "$pid"
    echo "PID: $pid killed"
  else
    echo "PID: $pid not found"
  fi
fi
# ps -ef | grep "$AUDIO".wav | grep -v grep | awk '{print $2}' | xargs kill -9
