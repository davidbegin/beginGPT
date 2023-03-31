#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

VOICE="$1"
DIALOG="$2"

echo "Generating Lip Sync Data: $1"

SOUNDFILE="$SCRIPT_DIR"/tmp/"$VOICE".wav

OUTPUT="$SCRIPT_DIR"/tmp/animations/output.txt

echo "Generating Lip Sync Data: $VOICE | $OUTPUT | $SOUNDFILE"

rhubarb -d $DIALOG -o $OUTPUT $SOUNDFILE
