#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

$SCRIPT_DIR/stop_recording.sh

# Convert Audio-to-Text
# Online
python $SCRIPT_DIR/openai_scripts/speech_to_text.py

# Offline
# vosk-transcriber -i $SCRIPT_DIR/tmp/outfile.wav -o $SCRIPT_DIR/tmp/transcription.txt

# Send transcribed question to ChatGPT to Answer
python $SCRIPT_DIR/openai_scripts/ask_gpt4.py

# This sends the text to Twitch,
# Which actually sends it to Uberduck
# (It's a Hack!)
echo $(cat $SCRIPT_DIR/tmp/chatgpt_response.txt)
beginbot $(cat $SCRIPT_DIR/tmp/chatgpt_response.txt)
