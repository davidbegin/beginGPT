#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

python $SCRIPT_DIR/openai_scripts/speech_to_text.py

skybox_prompt=$(cat $SCRIPT_DIR/tmp/transcription.txt)

echo "Transcription: $skybox_prompt"
