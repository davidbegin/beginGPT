#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

VOICE_FILE="$SCRIPT_DIR"/../tmp/current/voice.txt

cat voices.txt | sort | dmenu -l 30 | tee $VOICE_FILE
