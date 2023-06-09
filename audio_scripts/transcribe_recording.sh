#!/bin/sh


# If I only copy the file, on transcription, then we can always attach metadata
# and create file at the same time.
#
# 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Offline
# vosk-transcriber -i $SCRIPT_DIR/tmp/outfile.wav -o $SCRIPT_DIR/tmp/transcription.txt

python $SCRIPT_DIR/../openai_scripts/speech_to_text.py

prompt=$(cat $SCRIPT_DIR/../tmp/current/transcription.txt)

echo "Transcription: $prompt"
