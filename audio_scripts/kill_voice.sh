#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

# VOICE_FILE="$SCRIPT_DIR"/../tmp/current/voice.txt

VOICE=$(ps -ef | grep ".wav"  | grep -v "grep" | awk '{print $9}' | cut -d '/' -f3 | sed 's/.wav//' | dmenu -l 30)

echo $VOICE

$SCRIPT_DIR/kill_audio.sh $VOICE
