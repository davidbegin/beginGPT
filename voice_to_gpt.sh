#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

$SCRIPT_DIR/audio_scripts/stop_recording.sh

# Send transcribed question to ChatGPT to Answer
python $SCRIPT_DIR/openai_scripts/ask_gpt4.py

# This sends the text to Twitch,
# Which actually sends it to Uberduck
# (It's a Hack!)
echo $(cat $SCRIPT_DIR/tmp/current/chatgpt_response.txt)
# beginbot $(cat $SCRIPT_DIR/tmp/chatgpt_response.txt)
