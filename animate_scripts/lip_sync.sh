#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

VOICE_FILE="$1"
DIALOG="$2"

VOICE=$(echo $VOICE_FILE | sed "s/.wav//")
TMP_ANIMATIONS_FOLDER=$SCRIPT_DIR/tmp/animations/$VOICE

echo "Generating Lip Sync Data: $1"

SOUNDFILE="$SCRIPT_DIR"/tmp/voices/"$VOICE_FILE"

OUTPUT=$TMP_ANIMATIONS_FOLDER/output.txt

echo "Generating Lip Sync Data: $VOICE_FILE | $OUTPUT | $SOUNDFILE"

rhubarb -d $DIALOG -o $OUTPUT $SOUNDFILE
