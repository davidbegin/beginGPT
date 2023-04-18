#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
PARENT_DIR="$( cd "${SCRIPT_DIR}/.." && pwd )"

VOICE_FILE="$1"
DIALOG="$2"
NAMESPACE="$3"

# VOICE=$(echo $VOICE_FILE | sed "s/.wav//")
TMP_ANIMATIONS_FOLDER="$PARENT_DIR"/tmp/animations/"$NAMESPACE"

mkdir -p $TMP_ANIMATIONS_FOLDER

SOUNDFILE="${VOICE_FILE}.wav"

FULL_SOUNDFILE="$PARENT_DIR"/tmp/voices/$NAMESPACE/"$VOICE_FILE".wav

## These need to be namespaces
OUTPUT=$TMP_ANIMATIONS_FOLDER/output.txt

echo "Generating Lip Sync Data: $VOICE_FILE | $OUTPUT | $FULL_SOUNDFILE"

rhubarb -d $DIALOG -o $OUTPUT $FULL_SOUNDFILE
