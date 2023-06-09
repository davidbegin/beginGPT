#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

## Explore using Trapt instead
# Should we extract out the outfile.wav name???

# So we don't cut off the end of the recording
# This seemed to work in the worst cast
# sleep 2

# Get the process ID(s) of the outfile.wav process
pid=$(ps -ef | grep outfile.wav | grep -v grep | awk '{print $2}')

# Check if the PID is empty
if [ -z "$pid" ]; then
  echo "No process found for outfile.wav"
else
  if kill -0 "$pid" 2>/dev/null; then
    kill "$pid"
    echo "Recording PID: $pid killed"
  else
    echo "Recording PID: $pid not found"
  fi
fi

# # This works always
ps -ef | grep outfile.wav | grep -v grep | awk '{print $2}' | xargs kill -9

$SCRIPT_DIR/transcribe_recording.sh
